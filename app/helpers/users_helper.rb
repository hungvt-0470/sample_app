module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = Settings.users.gravatar_url_heading + gravatar_id
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
