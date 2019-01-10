class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :edit, :new, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @favoreites_blogs = @user.favorites
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'ブログを編集しました'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache)
  end

end
