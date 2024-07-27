class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  validates :nickname, presence: true
  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters' }
  validates :kana_last, presence: true,
                        format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width characters' }
  validates :kana_first, presence: true,
                         format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width characters' }
  validates :birthday, presence: true
end
