class DownloadReceiptsSearch
  require 'timeliness'
  include ActiveModel::Validations
 
  validates_date :date_from, :message => "invalid date - use dd/mm/yyyy", :allow_blank => true
  validates_date :date_to, :message => "invalid date - use dd/mm/yyyy", :allow_blank => true
  validate :at_least_one_date

  attr_accessor :date_from, :date_to

  def initialize(params = {})
    @date_from = params[:date_from]
    @date_to = params[:date_to]
  end

  def at_least_one_date
    return unless date_from.blank? and date_to.blank?
    errors.add(:date,'must have from or to date')
  end
end