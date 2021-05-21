class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    sign_in_merchant
  end

  def google_oauth2
    sign_in_merchant
  end

  private

  def sign_in_merchant
    @user = User.from_omniauth(auth)
    sign_in_and_redirect @user

  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "Could not log in user at the moment"
    failure
  end

  def auth
    @auth ||= request.env["omniauth.auth"]
  end

  def failure
    redirect_to new_user_registration_url
  end
end
