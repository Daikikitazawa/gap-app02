class UsersController < ApplicationController
  before_action :ensure_currect_user,{only: [:edit, :update]}

  def ensure_currect_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], password_digest: params[:password_digest], image_name: "default_user.jpg")
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password_digest = params[:password_digest]
   if params[:image]
    @user.image_name = "#{@user.id}.jpg"
    image = params[:image]
    File.binwrite("public/user.images/#{@user.image_name}", image.read)
  end
   if @user.save
    redirect_to("/users/#{@user.id}")
   else
    render("users/edit")
   end
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

  def ranking
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
    @posts = Post.all.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
    @post = Post.find_by(id: params[:id])
  end

end
