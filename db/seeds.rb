case Rails.env

when "development"
puts "********Seeduje Dane na localhost************"
User.create(:username => "localAdministrator", :password => "password", :password_confirmation => "password", :email => "user@example.pl")
end
