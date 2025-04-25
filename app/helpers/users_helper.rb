module UsersHelper
  def gravatar_for user,
    options = {size: Settings.users.gravatar.default_size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "#{Settings.users.gravatar.heading}#{gravatar_id}?s=##{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def can_destroy_user? user
    current_user.admin? && !current_user?(user)
  end
end
