class UsersController < ApplicationController
  layout :render_layout
  before_filter :login_required, :only => [:edit, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def index
    @search = User.search(params[:search])
    @users = @search.paginate(:all, :page => params[:page], :order => "random()", :per_page => 15)
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = t(:account_updated)
      redirect_to edit_user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find_by_username(params[:username])
  end

private

  def render_layout
    case params[:action]
    when 'new'
      return 'sessions'
    when 'create'
      return 'sessions'
    else
      return 'application'
    end
  end

end
