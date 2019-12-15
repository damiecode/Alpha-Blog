# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_same_user, only: %i[edit update]

  def index
    @pagy, @users = pagy(User.all, items: 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated suucessfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @pagy, @users_articles = pagy(@user.articles.all, items: 4)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can only edit your own account'
      redirect_to root_path
    end
  end
end
