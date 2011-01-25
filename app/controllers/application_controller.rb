class ApplicationController < ActionController::Base
  CANONICAL_HOST = 'telethon.smartservice.qld.gov.au'

  before_filter :clear_etag, :redirect_to_ssl
  
  def clear_etag
    response.etag = nil
  end
  
  def redirect_to_ssl
    return if ENV["NO_SSL"]
    return unless Rails.env.production?
    return if request.ssl? && request.host == CANONICAL_HOST
    redirect_to 'https://' + CANONICAL_HOST
  end
end
