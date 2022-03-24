class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, :format => /@/ 
    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :ideas, through: :favourites, source: :idea
end
