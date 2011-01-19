class AdminController < ApplicationController
  USER_NAME, PASSWORD = "admin", "password"

  before_filter :authenticate

  def download_postal_receipts
    if params[:date] != nil
      render :text => params[:date]
    end
  end
  
  def reissue_receipts
  end
  
  def find_receipts
    @donations = Donation.paid.joins(:customer).limit(50).order(:id)
    @donations = @donations.where(:id => params[:receipt_number]) unless params[:receipt_number] == ""
    @donations = @donations.where(:amount => params[:amount]) unless params[:amount] == ""
    @donations = @donations.where("customers.given_name = ?", params[:given_name]) unless params[:given_name] == ""
    @donations = @donations.where("customers.family_name = ?", params[:family_name]) unless params[:family_name] == ""
    @donations = @donations.where("DATE(donations.updated_at) = ?", params[:donation_date]) unless params[:donation_date] == ""
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
end