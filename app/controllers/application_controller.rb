class ApplicationController < ActionController::Base
  before_filter :clear_etag
  
  def clear_etag
    response.etag = nil
  end
  
  def force_cache
    response.headers['Cache-Control'] = 'public, max-age=300'
  end
  
  def force_no_cache    
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  def redirect_to_ssl
    return unless ENV["USE_SSL"] == "true"
    return if request.ssl? && request.host == ENV["CANONICAL_HOST"]
    redirect_to url_for params.merge({:protocol => 'https://', :host => ENV["CANONICAL_HOST"]})
  end
end
