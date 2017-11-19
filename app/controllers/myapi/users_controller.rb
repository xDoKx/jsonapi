# Контроллер работы с юзверями.
class Myapi::UsersController < ApiController
  # Перед началом работы обязательно проходим аутентификацию
  before_action :authenticate_token!

  # Показываем всех юзверей (с моделью User работает ActiveModel::Serializer)
  def index
    render json: User.all
  end

  # Создаем нового юзверя с проверкой на существование по имени
  def create
    @user = User.where(name: params[:name])

    if @user&.empty?
      @user = User.create(user_params)
      if @user.valid?
        @output = {"Status" => "Created", "Data" => @user}
      else
        @output = {"Status" => "Error", "Data" => "Validation failed!"}
      end
    else
      @output = {"Status" => "Error", "Data" => "User with that name already exist"}
    end

    render json: @output
  end

  # Strong validation, чтобы не скидывать params в модель.
  private
  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
