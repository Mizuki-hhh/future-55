class Content < ApplicationRecord
  mount_uploader :image_content, ImageVideoUploader
  mount_uploader :video_content, ImageVideoUploader

  belongs_to :user
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :overview
    validates :writing
    validates :source
  end

  validates :video_content, presence: true, unless: :image_content?
  validates :image_content, presence: true, unless: :video_content?

end
