module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title = ""
    base_title = t "title.base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def tutorial_link
    link_to t("pages.home.links.tutorial"), Settings.defaults.tutorial_url
  end

  def help_link
    link_to t("pages.help.links.help"), Settings.defaults.help_url
  end

  def book_link
    link_to t("pages.help.links.book_html"), Settings.defaults.book_url
  end

  def avatar_change_link
    link_to t("pages.edit.link"), Settings.defaults.avatar_change_url,
            target: :blank
  end

  def time obj
    time_ago_in_words obj.created_at
  end
end
