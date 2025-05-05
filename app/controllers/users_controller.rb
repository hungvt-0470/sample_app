class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t("mailer.info")
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @user = User.find_by id: params[:id]
    if @user.update user_params
      flash[:success] = t("pages.edit.success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("pages.admin.destroy.success")
    else
      flash[:danger] = t("pages.admin.destroy.fail")
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(User::USER_PARAMS)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "pages.edit.not_found"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("pages.errors.not_log_in")
    redirect_to login_url
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t("pages.errors.not_user")
    redirect_to root_path
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
