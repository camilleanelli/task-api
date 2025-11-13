class Api::V1::TasksController < ApplicationController
  before_action :find_project, only: [ :index, :create, :update, :destroy ]

  def index
    @tasks = @project.tasks.all
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    head :no_content
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
