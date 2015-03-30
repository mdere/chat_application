class CommentsController < ApplicationController

  def submit
    Comment.new_comment(params[:comment], session[:user_id])
    redirect_to :root
  end
  # GET /comments
  # GET /comments.json
  def index
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
  end
end
