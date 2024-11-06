$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'redmine'
require_dependency 'redmine_omniauth_azure/hooks'

Redmine::Plugin.register :redmine_omniauth_azure do
  name 'Redmine Omniauth Azure plugin'
  author 'Gucin Tsui'
  description 'This is a plugin for Redmine registration through Azure AD'
  version '0.2.0'
  url 'https://github.com/kimjyb/redmine_omniauth_azure'
  author_url 'https://github.com/'

  settings :default => {
    :client_id => "",
    :client_secret => "",
    :github_oauth_autentication => false,
    :allowed_domains => ""
  }, :partial => 'settings/azure_settings'
end
