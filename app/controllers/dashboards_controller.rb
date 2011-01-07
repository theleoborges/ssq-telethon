class DashboardsController < ApplicationController
  def index
    total = Donation.sum('amount');
    render :json => total.to_json
  end
end
