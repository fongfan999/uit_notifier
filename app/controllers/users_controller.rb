class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :sender_id)
    end
end
