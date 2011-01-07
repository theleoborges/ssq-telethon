class DashboardsController < ApplicationController
  def index
    data = {'total' => Donation.sum('amount'), 'donations' => Donation.count}
    render :json => data.to_json
  end
end
