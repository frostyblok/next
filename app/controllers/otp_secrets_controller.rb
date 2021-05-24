class OtpSecretsController < ApplicationController
  def new
    merge_article_params!

    @otp_secret = current_user.present? && current_user.otp_secret.present? ? current_user.otp_secret : ROTP::Base32.random
    totp = initialize_otp_secret(@otp_secret)
    @qr_code = setup_qrcode(totp)
  end

  def verify_and_update
    @otp_secret = params[:otp_secret]
    totp = initialize_otp_secret(@otp_secret)
    last_otp_at = verify_otp_secret(totp)

    update_user_otp_attribute(@otp_secret, last_otp_at)

    if last_otp_at
      article = Article.find(params[:article_id])
      update_article(article)
      redirect_to article_path(article), notice: 'Successfully updated article'
    else
      flash.now[:alert] = 'The code you provided was invalid!'
      @qr_code = setup_qrcode(totp)
      render :new
    end
  end

  private

  def merge_article_params!
    params.merge!(title: params.dig(:article_params, :title),
                  description: params.dig(:article_params, :description),
                  image: params.dig(:article_params, :image),
                  body: params.dig(:article_params, :body),
                  user_id: params.dig(:article_params, :user_id))
  end

  def initialize_otp_secret(otp_secret)
    ROTP::TOTP.new(
      otp_secret, issuer: 'NextBlog'
    )
  end

  def setup_qrcode(totp)
    RQRCode::QRCode
      .new(totp.provisioning_uri(current_user.email))
      .as_png(resize_exactly_to: 300)
      .to_data_url
  end

  def verify_otp_secret(totp)
    totp.verify(
      params[:otp_attempt], after: current_user.last_otp_at
    )
  end

  def update_user_otp_attribute(otp_secret, last_otp_at)
    user_last_otp_at = last_otp_at.present? ? last_otp_at : 0
    current_user.update(otp_secret: otp_secret, last_otp_at: user_last_otp_at)
  end

  def update_article(article)
    return article.published! unless edit_article_action

    article.update!(permitted_article_params)
  end

  def edit_article_action
    permitted_article_params[:title].present? || permitted_article_params[:description].present? ||
      permitted_article_params[:body].present?
  end

  def permitted_article_params
    params.require(:article_params).permit(:title, :description, :body, :user_id)
  end
end
