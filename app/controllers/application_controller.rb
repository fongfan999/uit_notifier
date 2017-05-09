class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_root

  private
    def authenticate_root
      authenticate_or_request_with_http_token do |token, options|
        token == ENV["ROOT_ACCESS_TOKEN"]
      end
    end
end
