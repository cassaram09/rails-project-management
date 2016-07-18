Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '584173048410440', '6f7eb14fdfc2463837885c082b717c5a'
end