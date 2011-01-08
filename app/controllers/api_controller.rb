class ApiController < ApplicationController
  def totals
    data = {'total' => Donation.sum('amount', :conditions => ["return_code = ?", '0']), 'donations' => Donation.count}
    render :json => data.to_json
  end
end
