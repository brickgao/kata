def create_default_admin
  user = User.new(:name => "admin",
                  :email => "test@test.com",
                  :password => "adminadmin",
                  :password_confirmation => "adminadmin",
                  :user_type => 1)
  user.save!
end

if __FILE__ == $0
  create_default_admin
end
