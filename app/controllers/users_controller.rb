class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @users = User.find_by(id: params[:id])
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(name: params[:name], email: params[:email], password_digest: params[:password_digest])
    if @users.save
      session[:user_id] = @users.id
      redirect_to("/users/index")
    else
      render("users/new")
    end
  end

  def edit
    @users = User.find_by(id: params[:id])
  end

  def update
    @users = User.find_by(id: params[:id])
    @users.name = params[:name]
    @users.email = params[:email]
    @users.password_digest = params[:password_digest]
    @users.save
    redirect_to("/users/index")
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email],password_digest: params[:password_digest])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

end
