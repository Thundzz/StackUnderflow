# Load the rails application
require 'casclient' 
require 'casclient/frameworks/rails/filter'
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StackUnderflow::Application.initialize!
CASClient::Frameworks::Rails::Filter.configure( :cas_base_url => "https://cas.ipb.fr/" )
