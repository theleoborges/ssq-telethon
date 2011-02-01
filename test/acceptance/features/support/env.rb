require File.dirname(__FILE__)+'/../pages/page'

raise "Please set TELETHON_ENVIRONMENT to one of #{Page.urls.keys.join(',')}" unless ENV['TELETHON_ENVIRONMENT']

require 'watir-webdriver'
require 'watir-webdriver/extensions/wait'

driver = Selenium::WebDriver.for :firefox

browser ||= Watir::Browser.new driver
INDEX_OFFSET = -1
WEBDRIVER = true

Before do
  @browser = browser
end

at_exit do
  browser.close
end