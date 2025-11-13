class Api::V1::ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project
    else
     render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    # todo if current_user != @project.owner.user to make sure only owner can delete
    @project.destroy
    render json: {}, status: :no_content
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :owner_id)
  end
end
