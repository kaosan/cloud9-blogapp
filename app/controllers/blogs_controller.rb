class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destro]
  before_action :logged_in?, only: [:new, :edit, :show, :destroy]

  def top
   end

  def index
    @blogs = Blog.all  
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: 'ブログを作成しました'
    else
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
   end

  def edit
    unless @blog.user_id == current_user.id
      redirect_to blogs_path, notice: "権限がありません"
    end
   end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: 'ブログを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: 'ブログを削除しました'
  end

  def confirm
    @user = User.find(session[:user_id])
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def logged_in?
    if current_user.present?
    else
      flash[:notice] = 'ログインしてください'
      redirect_to new_session_path
    end
  end
end
