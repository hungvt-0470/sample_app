class SessionsController < ApplicationController
  LOGIN_PARAMS = [
    :email,
    :password,
    :remember_me
  ].freeze

  def new; end

  def create
    user = User.find_by email: login_params[:email]&.downcase

    if user&.authenticate login_params[:password]
      log_in user
      login_params[:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t "pages.login.form.invalid"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def login_params
    params.require(:session).permit(LOGIN_PARAMS)
  end
end
