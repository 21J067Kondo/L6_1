class User5 < ApplicationRecord
    has_many :tweet5s, dependent: :destroy
    has_many :like5s, dependent: :destroy
    has_many :like_tweet5s, through: :like5s, source: :tweet5
    has_one :profile
end
