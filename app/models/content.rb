class Content < ApplicationRecord
  mount_uploader :image_content, ImageVideoUploader
  mount_uploader :video_content, ImageVideoUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  with_options presence: true do
    validates :title
    validates :overview
    validates :writing
    validates :source
    validates :category_id
  end

  validates :video_content, presence: true, unless: :image_content?
  validates :image_content, presence: true, unless: :video_content?

  def self.search(search)
    if search != ""
      Content.where('title LIKE(?)', "%#{search}%")
        .or(Content.where('overview LIKE(?)', "%#{search}%"))
          .or(Content.where('writing LIKE(?)', "%#{search}%"))
    else
      Content.all
    end
  end

end
