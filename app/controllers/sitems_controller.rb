class SitemsController < ApplicationController
  before_action :set_stodo
  before_action :set_stodo_sitem, only: [:show, :update, :destroy]

  # GET /todos/:todo_id/items
  def index
    json_response(@stodo.sitems)
  end

  # GET /todos/:todo_id/items/:id
  def show
    json_response(@sitem)
  end

  # POST /todos/:todo_id/items
  def create
    @stodo.sitems.create!(sitem_params)
    json_response(@stodo, :created)
  end

  # PUT /todos/:todo_id/items/:id
  def update
    @sitem.update(sitem_params)
    head :no_content
  end

  # DELETE /todos/:todo_id/items/:id
  def destroy
    @sitem.destroy
    head :no_content
  end

  private

  def sitem_params
    params.permit(:name, :done)
  end

  def set_stodo
    @stodo = Stodo.find(params[:stodo_id])
  end

  def set_stodo_sitem
    @sitem = @stodo.sitems.find_by!(id: params[:id]) if @stodo
  end
end
