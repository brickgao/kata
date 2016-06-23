require 'digest'

module UsersHelper

  def get_gavater_img(email, size=64)
    email_digest =Digest::MD5.hexdigest(email)
    "https://secure.gravatar.com/avatar/#{email_digest}?s=#{size}"
  end
end
