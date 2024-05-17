class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier - emailaddres

    @user = User.find_by ({"email"=> params["email"]})

    # 2. if the user exists -> check if they know their password

    if @user 

    # 3. if they know their password -> login is successful

    if BCrypt::Password.new(@user["password"])==params["password"]

    flash["notice"] = "Welcome."
    session["user_id"]=@user["id"] #ahora q guardamos el user id lo podemos usar
    redirect_to "/companies"

    else
        redirect_to "/login"
    end
    else 

    # 4. if the user doesn't exist or they don't know their password -> login fails
    
    redirect_to "/login"
    end
  end

  def destroy
    # logout the user    
    session["user_id"]=nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
