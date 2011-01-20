class AdminController < ApplicationController
  USER_NAME, PASSWORD = "admin", "password"

  before_filter :authenticate

  def download_postal_receipts
    if params[:date] != nil
      render :text => params[:date]
    end
  end
  
  def reissue_receipts
    @receipt_search = ReceiptSearch.new
  end
  
  def find_receipts
    @receipt_search = ReceiptSearch.new(params[:receipt_search])
    @donations = Donation.paid.joins(:customer).limit(50).order(:id).includes(:customer)
    
    if @receipt_search.valid?
      date = DateTime.strptime(@receipt_search.donation_date, "%d/%m/%Y") unless @receipt_search.donation_date == ""
      
      @donations = @donations.where(:id => @receipt_search.receipt_number) unless @receipt_search.receipt_number == ""
      @donations = @donations.where(:amount => @receipt_search.amount) unless @receipt_search.amount == ""
      @donations = @donations.where("customers.given_name = ?", @receipt_search.given_name) unless @receipt_search.given_name == ""
      @donations = @donations.where("customers.family_name = ?", @receipt_search.family_name) unless @receipt_search.family_name == ""
      @donations = @donations.where("customers.email = ?", @receipt_search.email_address) unless @receipt_search.email_address == ""
      @donations = @donations.where("donations.updated_at >= ?", date - 10.hours) unless date.nil?
      @donations = @donations.where("donations.updated_at <= ?", date + 1.day - 10.hours) unless date.nil?
    end
    
    @errors = @receipt_search.errors
    @errors.add(:no_results_found, ["please refine your search parameters"]) unless @donations.all.count > 0
    
    render :action => "reissue_receipts" unless @errors.empty?
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
end