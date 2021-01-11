class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contents

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

  enum role: { student: 1, contributor: 2 }

end
