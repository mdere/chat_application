class UsersController < ApplicationController
  before_action :create

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @users.each do |user|
      user.update_active_users
    end
    @comments = Comment.all
    @current_user = User.find(session[:user_id])
  end

  def update_users_session
    respond_to do |format|
      format.html
      format.js
    end
  end

  def change_username
    user = User.find(session[:user_id])
    all_users = User.where("active = ?", true)
    all_users.each do |user|
      if user.username == params[:username] || params[:username].nil?
        session[:message] = "User Name Already Exists OR Can Not Be Empty!"
        redirect_to :back and return
      end
    end
    user.change_user_name(params[:username])
    clear_message
    redirect_to :back
  end

  def update_admin
    if params[:admin].present? && params[:user_id].present?
      user = User.find(params[:user_id])
      user.update_attributes(admin: params[:admin])
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def update_comments
    @new_comments = Comment.where("created_at > ?", Time.at(params[:after]) + 1)
  end  

  def destroy_session
    session[:user_id] = nil
    redirect_to :back
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    unless session[:user_id].present?
      user = User.create_user
      session[:user_id] = user.id
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

  end
end
