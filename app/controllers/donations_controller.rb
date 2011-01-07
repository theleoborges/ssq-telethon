class DonationsController < ApplicationController
  def index
  end
  
  def callback
    @request = request
  end

end
