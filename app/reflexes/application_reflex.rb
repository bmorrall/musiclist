# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  # Handle exceptions with Rollbar
  rescue_from StandardError do |exception|
    Rollbar.error(exception)
  end
  rescue_from Pundit::NotAuthorizedError do |exception|
    Rollbar.info(exception)
    throw :abort
  end

  delegate :current_user, to: :connection

  # Put application wide Reflex behavior in this file.
  #
  # Example:
  #
  #   # If your ActionCable connection is: `identified_by :current_user`
  #   delegate :current_user, to: :connection
  #
  # Learn more at: https://docs.stimulusreflex.com

  protected

  def authorize(resource, action)
    Pundit.authorize(current_user, resource, action)
  end

  def policy(resource)
    Pundit.policy!(current_user, resource)
  end
end
