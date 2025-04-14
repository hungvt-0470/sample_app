module ApplicationHelper
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
end
