# Be sure to restart your server when you modify this file.

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :github,
    Rails.application.secrets.omniauth_provider_key,
    Rails.application.secrets.omniauth_provider_secret
  )
end
