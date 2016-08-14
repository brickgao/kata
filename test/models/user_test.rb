require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "badpasswd", password_confirmation: "badpasswd",
                     user_type: 0)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " " * 10
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " " * 10
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@EXAMPLE.com test_uSer@test.edu.cn
                         firstname.lastname@test.com name+nickname@test.in]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should not accept invalid addresses" do
    invalid_addresses = %w[test@com u*x@test.com user man@.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email.upcase!
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_email_address = "AdMin@tesT.Com"
    @user.email = mixed_email_address
    @user.save
    assert_equal mixed_email_address.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "2" * 5
    assert_not @user.valid?
  end

  test "user_type should be present" do
    @user.user_type = nil
    assert_not @user.valid?
  end
end
