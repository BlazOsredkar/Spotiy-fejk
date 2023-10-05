class UsersController < ApplicationController
    def show
        if params[:search]
            @user = User.find(params[:id])
        end
    end
end
