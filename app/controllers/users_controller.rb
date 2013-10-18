class UsersController < ApplicationController
  def me
    @user = current_user
    render :show
  end
end
