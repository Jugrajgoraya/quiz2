class Idea < ApplicationRecord
    validates :title, presence: true
    has_many :reviews, dependent: :destroy
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :likers, through: :favourites, source: :user
end
