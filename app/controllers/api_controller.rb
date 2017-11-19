# Этот контрол наследуют все прочие в папке myapi.
# Удобно, т.к. позволяет легко менять фильтры и модули.

class ApiController < ApplicationController

  private
  def authenticate_token!
    begin
      payload = JsonWebToken.decode(auth_token)
      if payload.present?
        @current_user = User.find_by(name: payload[0]["name"])
      else
        render json: {"Status" => "Error", "Data" => {"Message" => "Invalid token!"}}
      end
    rescue
      render json: {"Status" => "Error", "Data" => {"Message" => "Invalid token!"}}
    end
  end

  def auth_token
    request.headers.fetch("Auth", "").split(" ").last
  end
end
