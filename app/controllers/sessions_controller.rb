class SessionsController < ApplicationController
  def connect
    logger.debug "params: #{params}"
    session[:xero_api_client_id] = params[:client_id]
    session[:xero_api_client_secret] = params[:client_secret]
    redirect_to '/auth/xero_oauth2'
  end

  def setup
    logger.debug "omniauth setup"
    request.env['omniauth.strategy'].options[:client_id] = session[:xero_api_client_id]
    request.env['omniauth.strategy'].options[:client_secret] = session[:xero_api_client_secret]
    logger.debug "setup - request.env: #{request.env['omniauth.strategy']}"
    render :plain => "Omniauth setup phase.", :status => 404
end

  def create
    auth_hash = request.env['omniauth.auth']
    logger.debug "omniauth.auth: #{auth_hash}"

    user = User.find_or_create_by(xeroUid: auth_hash['uid'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.xeroAccessToken = auth_hash['credentials']['token']
    user.xeroRefreshToken = auth_hash['credentials']['refresh_token']
    user.xeroTenantId = auth_hash['extra']['xero_tenants'][0]['tenantId']
    user.xeroTokenExpiresAt = auth_hash['credentials']['expires_at']
    user.save

    redirect_to controller: 'organisation', action: 'index', xeroUid: user.xeroUid
  end
end
