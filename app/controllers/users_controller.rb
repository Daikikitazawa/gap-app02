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
    @users.save
    redirect_to("/users/index")
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

end
