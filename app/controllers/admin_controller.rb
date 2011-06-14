class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :force_no_cache
  
  def download_receipts
    @download_receipts_search = DownloadReceiptsSearch.new
  end

  def download_receipts_csv
    @download_receipts_search = DownloadReceiptsSearch.new(params[:download_receipts_search])
    
    @download_receipts_search.valid?
    @errors = @download_receipts_search.errors

    if @errors.empty?
      date_from = to_date @download_receipts_search.date_from
      date_to = to_date @download_receipts_search.date_to
      
      @donations = Donation.paid.joins(:customer).includes(:customer).order("donations.id")
      @donations = @donations.where("donations.updated_at >= ?", date_from - 10.hours) unless date_from.nil?
      @donations = @donations.where("donations.updated_at <= ?", date_to + 1.day - 10.hours) unless date_to.nil?

      if params[:submit] == 'Postal Receipts'
        @donations = @donations.where("customers.wants_receipt_by_snail_mail = true")
      end

      if params[:submit] == '$10K+ Donations'
        @donations = @donations.where("donations.amount >= 10000.00")
      end

      @errors.add(:no_results_found, ["please refine your search parameters"]) unless @donations.all.count > 0
    end

    if @errors.empty?
      response.headers['Content-type'] = 'text/csv'
      response.headers['Content-disposition'] = 'attachment;filename=TelethonReceipts.csv'
      render :layout => false
    else
      render :action => :download_receipts unless @errors.empty?
    end
  end

  def receipt_search
    @receipt_search = ReceiptSearch.new
  end
  
  def find_receipts
    @receipt_search = ReceiptSearch.new(params[:receipt_search])
    @donations = Donation.joins(:customer).limit(50).order("donations.id").includes(:customer)
    
    if @receipt_search.valid?
      date = DateTime.strptime(@receipt_search.donation_date, "%d/%m/%Y") unless @receipt_search.donation_date == ""
      @donations = @donations.paid if @receipt_search.paid?
      @donations = @donations.unpaid if @receipt_search.unpaid?
      @donations = @donations.where(:id => @receipt_search.receipt_number) unless @receipt_search.receipt_number == ""
      @donations = @donations.where(:amount => @receipt_search.amount) unless @receipt_search.amount == ""
      @donations = @donations.where("customers.given_name ILIKE ?", "%#{@receipt_search.given_name}%") unless @receipt_search.given_name == ""
      @donations = @donations.where("customers.family_name ILIKE ?", "%#{@receipt_search.family_name}%") unless @receipt_search.family_name == ""
      @donations = @donations.where("customers.organisation_name ILIKE ?", "%#{@receipt_search.organisation_name}%") unless @receipt_search.organisation_name == ""
      @donations = @donations.where("customers.email ILIKE ?", "%#{@receipt_search.email_address}%") unless @receipt_search.email_address == ""
      @donations = @donations.where("donations.updated_at >= ?", date - 10.hours) unless date.nil?
      @donations = @donations.where("donations.updated_at <= ?", date + 1.day - 10.hours) unless date.nil?
    end
    
    @errors = @receipt_search.errors
    @errors.add(:no_results_found, ["please refine your search parameters"]) unless @donations.all.count > 0

    render :action => "receipt_search" unless @errors.empty?
  end
  
  def donation
    @donation = Donation.find(params[:donation_id])
  end
  
  def reissue_receipt
    @donation = Donation.find(params[:donation_id])
    @donation.customer.update_attributes(params[:customer])
    @donation.customer.wants_receipt_by_email = true
    @donation.customer.wants_receipt_by_snail_mail = false
    @donation.customer.save
    
    @errors = @donation.customer.errors
    
    if @errors.empty?
      DonationMailer.delay.donation_confirmation @donation if donation.paid?
    else
      render :action => "donation"
    end
  end
private
  def to_date text
    DateTime.strptime(text, "%d/%m/%Y") unless text == ""
  end
end