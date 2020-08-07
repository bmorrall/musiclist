class ApplicationController < ActionController::Base
  include ApplicationUrls
  include SessionAuth
  include Pundit

  protected

  def present(record_or_array, klass)
    if record_or_array.respond_to?(:map)
      record_or_array.map { |item| klass.new(item, view_context) }
    else
      klass.new(record_or_array, view_context)
    end
  end
  helper_method :present
end
