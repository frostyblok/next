class OtpSecretsController < ApplicationController
  def new
    params.merge!(title: params.dig(:article_params, :title),
                  description: params.dig(:article_params, :description),
                  image: params.dig(:article_params, :image),
                  body: params.dig(:article_params, :body),
                  user_id: params.dig(:article_params, :user_id))

    @otp_secret = current_user.present? && current_user.otp_secret.present? ? current_user.otp_secret : ROTP::Base32.random
    totp = ROTP::TOTP.new(
      @otp_secret, issuer: 'NextBlog'
    )
    @qr_code = RQRCode::QRCode
                 .new(totp.provisioning_uri(current_user.email))
                 .as_png(resize_exactly_to: 300)
                 .to_data_url
  end

  def create
    @otp_secret = params[:otp_secret]
    totp = ROTP::TOTP.new(
      @otp_secret, issuer: 'NextBlog'
    )

    last_otp_at = totp.verify(
      params[:otp_attempt], after: current_user.last_otp_at
    )

    user_last_otp_at = last_otp_at.present? ? last_otp_at : 0
    current_user.update(otp_secret: @otp_secret, last_otp_at: user_last_otp_at)

    if last_otp_at
      article = Article.find(params[:article_id])

      if permitted_article_params.present?
        article.update!(permitted_article_params)
      else
        article.published!
      end

      redirect_to article_path(article), notice: 'Successfully published article'
    else
      flash.now[:alert] = 'The code you provided was invalid!'
      @qr_code = RQRCode::QRCode
                   .new(totp.provisioning_uri(current_user.email))
                   .as_png(resize_exactly_to: 300)
                   .to_data_url
      render :new
    end
  end

  private

  def permitted_article_params
    params.require(:article_params).permit(:title, :description, :body, :user_id)
  end
end
