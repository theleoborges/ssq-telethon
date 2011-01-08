class DonationMailer < ActionMailer::Base
  default :from => "osidt@smartservice.qld.gov.au"
  
  def donation_confirmation(donation)
    @donation = donation
    mail(:to => "#{donation.customer.given_name} #{donation.customer.family_name} <#{donation.customer.email}>", 
      :subject => "Smart Service Queensland - Receipt: #{donation.id}")
  end
  
end
