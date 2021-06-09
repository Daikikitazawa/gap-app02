class PostsController < ApplicationController
  before_action :ensure_currect_user,{only: [:edit, :update, :destroy]}

  def ensure_currect_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
  end

  def new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    @post.save
    redirect_to("/posts/index")
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
    redirect_to("/posts/index")
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.destroy
    redirect_to("/posts/index")
  end



end
