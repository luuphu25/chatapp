  OmniAuth.config.logger = Rails.logger

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '1537224436317682', '5870f2ee193cad47cb7580582b89b486'
  end