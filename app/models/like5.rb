class Like5 < ApplicationRecord
    belongs_to :user5
    belongs_to :tweet5
    def create
    tweet5 = Tweet5.find(params[:tweet_id])
    unless tweet5.liked?(current_user)
    tweet5.like(current_user)
    end
    redirect_to root_path
    end
    
end
