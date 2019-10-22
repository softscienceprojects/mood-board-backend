class UsersController < ApplicationController

    def index
        render json: User.all
    end

    def show
        render json: User.find(params[:id])
    end

    def create
        user = User.create(user_params)
        # uncomment the below when ready to implement auth
        # if user.valid?
        #     render json: { token: issue_token({user_id: user.id}), user: UserSerializer.new(user) }
        # else
        #     render json: { errors: user.errors.full_messages }, status: :not_acceptable
        # end
    end

    def login
        
        user = User.find_by(email: params[:data][:email])

        if user && user.authenticate(params[:data][:password])
            render json: user
        else
            render json: { error: 'Username/password combination invalid' }, status: 401
        end
    end

    def signup
        
    end

    private
    def user_params
        require(:user).permit(:email, :password, :password_confirmation)
    end
end
