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

  def change_username
    user = User.find(session[:user_id])
    all_users = User.all
    all_users.each do |user|
      if user.username == params[:username]
        redirect_to :back, :flash => { :error => "Username Already Exists!" } and return
      end
    end
    user.change_user_name(params[:username])
    redirect_to :back
  end

  def update_admin
    user = User.find(params[:user_id])
    user.update_attributes(admin: params[:admin])
    redirect_to :root
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