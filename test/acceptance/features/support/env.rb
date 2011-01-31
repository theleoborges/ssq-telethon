require 'watir-webdriver'

profile = Selenium::WebDriver::Firefox::Profile.new

if ENV['http_proxy']
  require 'uri'
  proxy_uri = URI.parse ENV['http_proxy']

  profile['network.proxy.http'] = proxy_uri.host
  profile['network.proxy.http_port'] = proxy_uri.port
  profile['network.proxy.type'] = 1
end

driver = Selenium::WebDriver.for :firefox, :profile => profile

browser ||= Watir::Browser.new driver
INDEX_OFFSET = -1
WEBDRIVER = true

Before do
  @browser = browser
end

at_exit do
  #browser.close
end