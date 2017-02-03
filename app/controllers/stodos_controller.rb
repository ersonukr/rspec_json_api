class StodosController < ApplicationController
  before_action :set_stodo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @stodos = Stodo.all
    json_response(@stodos)
  end

  # POST /todos
  def create
    @stodo = Stodo.create!(stodo_params)
    json_response(@stodo, :created)
  end

  # GET /todos/:id
  def show
    json_response(@stodo)
  end

  # PUT /todos/:id
  def update
    @stodo.update(stodo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @stodo.destroy
    head :no_content
  end

  private

  def stodo_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_stodo
    @stodo = Stodo.find(params[:id])
  end
end
