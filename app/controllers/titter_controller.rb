class TitterController < ApplicationController
  def top
    params[:session]|=nil
    flash[:notice]=nil
    flash[:ntice]=nil
    @all_tweet=Tweet.all
  end
  
  def login
    flash[:notice]=''
    user=User.find_by(uid: params[:uid])
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
    user=User.find_by(uid: params[:uid])
    if user!=nil
      flash[:notice] ='別のユーザーidを入力してください'
      render 'regi'
    else
      user=User.new(uid: params[:uid],pass: BCrypt::Password.create(params[:pass]))
      user.save
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
    user=User.find_by(uid: session[:login_uid])
    @tweet=Tweet.new(message: params[:tweet][:message],user_id: user.id)
    if @tweet.save
    end
    redirect_to '/'
  end
end
