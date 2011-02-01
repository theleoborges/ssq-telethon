class Page
  def self.urls
    {
      'local' => 'http://localhost:3000/',
      'test' => 'http://ssq-telethon-test.heroku.com',
      'staging' => 'http://ssq-telethon-staging.heroku.com',
      'production' => 'http://telethon.smartservice.qld.gov.au'
    }
  end

  attr_reader :browser
  
  def initialize browser
    @browser = browser
  end

  def check_we_are_on_this_page
    #override this in your specific pages to check you are on the right one
  end

  def base_url
    Page.urls[ENV["TELETHON_ENVIRONMENT"] || 'local']
  end
end