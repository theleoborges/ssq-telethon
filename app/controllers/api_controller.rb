class ApiController < ApplicationController
  def totals
    total = Donation.sum('amount', :conditions => ["return_code = ?", '0']).to_s
    data = {'total' => total, 'donations' => Donation.count}
    render :json => data.to_json
  end
end
