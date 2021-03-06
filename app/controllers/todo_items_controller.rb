class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy, :complete, :uncomplete]

  # GET /todo_items
  # GET /todo_items.json
  def index
    TodoItem.delete_empty_tags
    if params[:tag]
      @incomplete_todo_items = TodoItem.tagged_with(params[:tag]).where(complete: false).order(updated_at: :desc)
      @complete_todo_items = TodoItem.tagged_with(params[:tag]).where(complete: true).order(updated_at: :desc)
    else
      @incomplete_todo_items = TodoItem.where(complete: false).order(updated_at: :desc)
      @complete_todo_items = TodoItem.where(complete: true).order(updated_at: :desc)
    end
  end

  # GET /todo_items/1
  # GET /todo_items/1.json
  def show
  end

  # GET /todo_items/new
  def new
    @todo_item = TodoItem.new
  end

  # GET /todo_items/1/edit
  def edit
  end

  # POST /todo_items
  # POST /todo_items.json
  def create
    @todo_item = TodoItem.new(todo_item_params)

    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to @todo_item, notice: 'Todo item was successfully created.' }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1
  # PATCH/PUT /todo_items/1.json
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to @todo_item, notice: 'Todo item was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :edit }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1
  # DELETE /todo_items/1.json
  def destroy
    @todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_items_url, notice: 'Todo item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_completed
    completed = TodoItem.where(complete: true).map(&:id)
    if completed.empty?
      respond_to do |format|
        format.html { redirect_to todo_items_url, notice: 'No completed todo items to destroy.' }
        format.json { head :no_content }
      end
    else
      TodoItem.destroy(completed)
      respond_to do |format|
        format.html { redirect_to todo_items_url, notice: 'All completed todo items were successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def complete
    @todo_item.update(complete: true)
    redirect_to todo_items_path
  end

  def uncomplete
    @todo_item.update(complete: false)
    redirect_to todo_items_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_item_params
      params.require(:todo_item).permit(:title, :description, :all_tags)
    end
end
