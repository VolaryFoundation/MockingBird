if ENV['RACK_ENV'] == 'production' || ENV['RACK_ENV'] == 'staging'
  Pony.options = {
    :from => 'noreply@volary.org',
    :headers => { 'Content-Type' => 'text/html' },
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
  
else
  Pony.options = {
    :from => 'noreply@volary.org',
    :headers => { 'Content-Type' => 'text/html' }
  }
end