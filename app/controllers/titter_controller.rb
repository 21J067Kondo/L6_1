class TitterController < ApplicationController
  def top
    params[:session]|=nil
    flash[:notice]=nil
    flash[:ntice]=nil
    @all_tweet=Tweet.all
    @all_like=Like.all
    if session[:login_uid]
      @user_like=Like.where(user_id: User5.find_by(uid: session[:login_uid]).id)
      @prof=Profile.find_by(user_id: User5.find_by(uid: session[:login_uid]).id).message
    end
  end
  
  def login
    flash[:notice]=''
    user=User5.find_by(uid: params[:uid])
    if user!=nil
    p=BCrypt::Password.new(user.pass)
    if p==params[:pass]
      session[:login_uid]=params[:uid]
      puts session[:login_uid]
      redirect_to '/'
    end
    else
      flash[:noteice]='ユーザIDもしくは、パスワードが違います'
      render 'loginp'
    end
  end
  
  def regist
    flash[:notice]=''
    user=User5.find_by(uid: params[:uid])
    if user!=nil
      flash[:notice] ='別のユーザーidを入力してください'
      render 'regi'
    else
      user=User5.new(uid: params[:uid],pass: BCrypt::Password.create(params[:pass]))
      user.save
      prof=Profile.new(user_id: user.id)
      prof.save
      session[:login_uid]=params[:uid]
      redirect_to '/'
    end
  end
  
  def logout
    session[:login_uid]=nil
    redirect_to '/'
  end
  
  def new
    @tweet=Tweet.new
  end
  
  def create
    user=User5.find_by(uid: session[:login_uid])
    @tweet=Tweet.new(message: params[:tweet][:message],user_id: user.id)
    if @tweet.save
    end
    redirect_to '/'
  end
  
  def like
    p=Like.new(user_id: User5.find_by(uid: session[:login_uid]).id,tweet_id: params[:tid])
    p.save
    redirect_to '/'
  end
  
  def not_like
    Like.find(params[:lid]).destroy
    redirect_to '/'
  end
  
  def new_profile
    @profile=Profile.find_by(user_id: User5.find_by(uid: session[:login_uid]).id)
  end
  
  def profile
    p=Profile.find_by(user_id: User5.find_by(uid: session[:login_uid]).id)
    p.message=params[:profile][:message]
    p.save
    redirect_to '/'
  end
end
