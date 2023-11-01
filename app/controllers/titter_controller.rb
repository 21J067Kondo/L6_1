class TitterController < ApplicationController
  def top
    params[:session]|=nil
    flash[:notice]=nil
    flash[:ntice]=nil
    @all_tweet=Tweet5.all
    @all_like=Like5.all
    if current_user
      @user_like=Like5.where(user5_id: current_user.id)
      @prof=Profile.find_by(user_id: current_user.id).message
    end
  end
  
  def login
    flash[:notice]=''
    user=User5.find_by(uid: params[:uid])
    if user!=nil
    p=BCrypt::Password.new(user.pass)
    if p==params[:pass]
      session[:login_uid]=params[:uid]
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
      current_user.uid=params[:uid]
      redirect_to '/'
    end
  end
  
  def logout
    session[:login_uid]=nil
    redirect_to '/'
  end
  
  def new
    @tweet=Tweet5.new
  end
  
  def create
    user=User5.find_by(uid: session[:login_uid])
    @tweet=Tweet5.new(message: params[:tweet5][:message],user_id: user.id)
    if @tweet.save
    end
    redirect_to '/'
  end
  
  def like
    Tweet5.find(params[:tweet]).like(current_user)
    redirect_to '/'
  end
  
  def unlike
    a=Tweet5.find(params[:lid])
    Tweet5.find(params[:lid]).unlike(current_user)
    puts '---------'
    puts a
    puts '---------'
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
