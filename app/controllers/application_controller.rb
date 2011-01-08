class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :clear_etag
  
  def clear_etag
    response.etag = nil
  end
end
