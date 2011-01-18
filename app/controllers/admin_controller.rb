class AdminController < ApplicationController
  USER_NAME, PASSWORD = "admin", "password"

  before_filter :authenticate

  def download_postal_receipts
    if params[:date] != nil
      render :text => params[:date]
    end
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
end