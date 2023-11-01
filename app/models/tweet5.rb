class Tweet5 < ApplicationRecord
    has_many :like5s
    has_many :user5, dependent: :destroy
    has_many :like_user5s, through: :like5s, source: :User5
    
    def like(user)
    like5s.create(user5_id: user.id)
    end

    def unlike(user)
    like5s.find_by(user5_id: user.id).destroy
    end

    def liked?(user) #いいね済みか調べる(true / false)
    Like5.find_by(user5_id: user.id)
    end
end
