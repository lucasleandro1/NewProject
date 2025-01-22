module UserManager
  class Creator
    attr_reader :user_params

    def initialize(user_params)
      @user_params = user_params
    end

    def call
      if user_exists
        response_error(message: "user_exists")
      else
        response(create_user)
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def response(data)
      { success: true, message: "user_created", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def user_exists
      User.exists?(cpf: user_params[:cpf])
    end

    def create_user
      user = User.new(user_params)
      if user.save
        user
      else
        raise StandardError.new(user.errors.full_messages.to_sentence)
      end
    end
  end
end