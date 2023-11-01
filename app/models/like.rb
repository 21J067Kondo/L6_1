class Like < ApplicationRecord
    belongs_to :user5
    belongs_to :tweet5
    def create
    puts '-+-+-+-+'
    tweet5 = Tweet5.find(params[:tweet_id])
    unless tweet.liked?(current_user)
    tweet5.like(current_user)
    end
    redirect_to root_path
    end
    
    def destroy
    tweet = Tweet.find(params[:id])
    if tweet.liked?(current_user)
    tweet.unlike(current_user)
    end
    redirect_to root_path
    end
end
