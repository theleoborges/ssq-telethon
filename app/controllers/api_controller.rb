class ApiController < ApplicationController
  def totals
    total = Donation.sum('amount', :conditions => ["return_code = ?", '0']).to_s
    donation = Donation.where("return_code = '0'").count
    data = {'total' => total, 'donations' => donation}
    render :json => data.to_json
  end
end
