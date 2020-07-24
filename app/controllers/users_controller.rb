class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_full_params)

    if @user.save
      redirect_to users_path, notice: t('flash_message.user.create.success')
    else
      render :new
    end
  end

  def show
    @user = User.find(id)
  end

  def edit
  end

  def update
    @user = User.find(id)

    if @user.update(user_params)
      redirect_to user_path(@user), notice: t('flash_message.user.update.success')
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(id)
    @user.destroy

    redirect_to users_path, notice: t('flash_message.user.message.destroy.success')
  end

  protected

  # Current user can not downgrade their account to Student
  def user_params
    current_user == @user ? user_info_params : user_full_params
  end

  def user_full_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_ids)
  end

  def user_info_params
    user_full_params.except(:role_ids)
  end
end
