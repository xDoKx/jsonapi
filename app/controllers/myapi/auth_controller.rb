# Контроллер авторизации.
class Myapi::AuthController < ApiController

  # Метод вывода токена в случае, если найден такой юзверь и пароль совпадает с паролем в базе
  def create
    user = User.where(name: params[:name]).first

    if user&.valid_password?(params[:password])
      @output = {"Status" => "Authorized", "Data" => {"Token" => JsonWebToken.encode(name: user[:name], email: user[:email])}}
    else
      @output = {"Status" => "Error", "Data" => {"Message" => "User didnt find or password is incorrect!"}}
    end
    render json: @output
  end

  # Метод для создания базового юзверя с проверкой на уже существующего
  def force
    user = User.where(name: "baseuser")

    if user.empty?
      user = User.create(name: "baseuser", password: "123456", email: "basemail@mail.ru")
      render json: user
    else
      render json: user
    end
  end
end
