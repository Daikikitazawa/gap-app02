class PostsController < ApplicationController
  before_action :ensure_currect_user,{only: [:edit, :update, :destroy]}
  protect_from_forgery :only => ["create"]

  def ensure_currect_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
end

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
    @post = Post.find_by(id: params[:id])
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(**post_params, content: params[:content], user_id: @current_user.id)
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

  def ranking
    @posts = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  def test
  end

  private
  def post_params
    params.require(:post).permit(:content, :image)
  end

end
