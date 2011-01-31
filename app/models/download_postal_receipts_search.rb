class DownloadPostalReceiptsSearch
  require 'timeliness'
  include ActiveModel::Validations
 
  validates_date :date, :message => "invalid date - use dd/mm/yyyy"
 
  attr_accessor :date
  
  def initialize(params = {})
    @date = params[:date]
  end
end