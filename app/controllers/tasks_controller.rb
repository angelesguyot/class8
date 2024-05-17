class TasksController < ApplicationController
  def index
    @tasks = Task.where({"user_id"=>session["user_id"]}) #para que cada persona solo vea sus tareas
    @current_user=User.find_by({"id" => session["user_id"]}) #si no estoy logeada es nil
  end

  
  def create
   #if @current_user no hacerlo aca porque es una mala user experience
    @task = Task.new
    @task["description"] = params["description"]
    @task["user_id"] = session["user_id"] #agrego el user id a cada entry de tasks
    @task.save
    redirect_to "/tasks"
  # else flash["notice"] = "You need to log in"
  # end
  end

  def destroy
    @task = Task.find_by({ "id" => params["id"] })
    @task.destroy
    redirect_to "/tasks"
  end
end
