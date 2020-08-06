class ApplicationController < ActionController::Base
  include ApplicationUrls
  include SessionAuth
  include Pundit
end
