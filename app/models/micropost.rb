class Micropost < ApplicationRecord
  MICROPOST_PARAMS = [
    :content,
    :image
  ].freeze

  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display,
                      resize_to_limit: Settings.resize_to_limit
  end

  validates :content, presence: true,
length: {maximum: Settings.microposts.content_max_size}
  validates :image, content_type: {
                      in: Settings.microposts.allowed_image_mime_types,
                      message: :"micropost.img_type_msg"
                    },
                    size: {less_than: Settings.max_size.megabytes,
                           message: :"micropost.img_size_msg"}

  scope :newest, ->{order(created_at: :desc)}
end
