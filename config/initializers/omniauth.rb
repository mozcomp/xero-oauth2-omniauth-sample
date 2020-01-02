## BMS-IUGIS-AU
ENV['xero_api_client_id'] = '40E96E2E803340FB8D05EC6510D65F2C' #replace this with your own client_id
ENV['xero_api_client_secret'] = 'RGaJW6qdsLwbng3rJjyIFwpI8LV0VITXj7BQ6Nu3-ry7V4bi' #replace this with your own client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :xero_oauth2,
    ENV['xero_api_client_id'],
    ENV['xero_api_client_secret'],
    scope: 'openid profile email files accounting.transactions accounting.transactions.read accounting.reports.read accounting.journals.read accounting.settings accounting.settings.read accounting.contacts accounting.contacts.read accounting.attachments accounting.attachments.read offline_access',
  )
end

# by default the callback url / redirect_uri on developer.xero.com should be seet to /auth/xero_oauth2/callback
# to override it, added redirect_uri: 'https:/your.app/callback/url' to provider() function 