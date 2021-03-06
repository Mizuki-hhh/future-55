class User < ApplicationRecord
  enum role: { student: 1, contributor: 2 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contents
  has_many :comments #, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_contents, through: :favorites, source: :content

  with_options presence: true do
    validates :name
    validates :role
    validates :birthday
    validates :occupation
    validates :password_confirmation
  end

  validates :email, uniqueness: { case_sensitive: false }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, :password_confirmation,  with: PASSWORD_REGEX 

end
