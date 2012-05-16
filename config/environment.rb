# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TshirtidTeaser::Application.initialize!

# Haml options
Haml::Template.options[:format] = :html5