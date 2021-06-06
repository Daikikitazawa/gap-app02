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

end
