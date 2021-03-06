class TasksController < ApplicationController
  before_action :set_task,only: [:show,:edit,:update,:destroy]
  def index
    @q=current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct:true).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_param)
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_param)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」更新しました。"
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def task_param
    params.require(:task).permit(:name, :description,:image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
