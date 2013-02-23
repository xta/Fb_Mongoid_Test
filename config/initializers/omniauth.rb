Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_CONFIG["fb_app_id"], APP_CONFIG["fb_app_secret"]
end