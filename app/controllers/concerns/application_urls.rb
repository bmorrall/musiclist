# frozen_string_literal: true

# ApplicationUrls generated by rockstart:frontend_helpers
module ApplicationUrls
  extend ActiveSupport::Concern

  included do
    helper_method :url_for_authentication
    helper_method :url_for_landing_page
    helper_method :url_for_user_dashboard
  end

  protected

  def url_for_authentication
    auth_sign_in_path
  end

  def url_for_landing_page
    root_url # TODO: Provide url for landing page
  end

  def url_for_user_dashboard
    root_url # TODO: Provide url for user dashboard link
  end
end