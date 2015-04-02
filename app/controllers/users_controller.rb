class UsersController < ApplicationController
  before_action :create

  # GET /users
  # GET /users.json
  def index
    @current_user = User.find(session[:user_id])
    if @current_user.admin
      @users = User.all
      @comments = Comment.all
    else
      @users = User.where("active = ?", true)
      @comments = Comment.where("created_at > ?", @current_user.created_at)
    end
    @users.each do |user|
      user.update_active_users
    end
  end

  def re_index
    current_user = User.find(session[:user_id])
    respond_to do |format|
      format.html do
        render :partial => 'current_user', :locals => { :user => current_user }
      end
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

  def update_user_list
    current_user = User.find(session[:user_id])
    check_users = User.all
    check_users.each do |user|
      user.update_active_users
    end
    if current_user.admin
      users = User.all
    else
      users = User.where("active = ?", true)
    end   
    respond_to do |format|
      format.html do
        render :partial => 'user_list', :locals => { :users => users }
      end
    end
  end

  def update_comments
    current_user = User.find(session[:user_id])
    if current_user.admin
      comments = Comment.all
    else
      comments = Comment.where("created_at > ?", current_user.created_at)
    end
    respond_to do |format|
      format.html do 
        render :partial => 'comment_table', :locals => { :comments => comments }
      end
    end
  end 

  def destroy_session
    session[:user_id] = nil
    redirect_to :back
  end

  # POST /users
  # POST /users.json
  def create
    unless session[:user_id].present?
      user = User.create_user
      session[:user_id] = user.id
    end
  end

end
