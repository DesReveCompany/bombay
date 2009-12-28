class HomeController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :following, :page]

  def index 
    @search = Flit.search(params[:search]) 
    @flits = @search.paginate(:all, :page => params[:page], :order => "id desc", :per_page => 15) 
  end
  
  def show 
    @user = User.find_by_username(params[:username]) 
    @flits = @user.user_and_friends_flits.paginate(:page => params[:page], :per_page => 15) 
    @user_flits = @user.user_flits.paginate( :page => params[:page], :per_page => 15)
  end

  def page
    @flit = Flit.find(params[:id])
  end


  def follow
    @User = User.find_by_username(params[:username])
    if current_user.is_friend? @user
      flash[:notice] = "You are no longer following @#{@user.username}"
      current_user.remove_friend(@user)
    else
      flash[:notice] = "You are now following @#{@user.username}"
      current_user.add_friend(@user)
    end
    redirect_to user_flits_path(@user.username)
  end

  def follow_via_ajax
    user = User.find_by_username(params[:username])
    if current_user.is_friend? user
      current_user.remove_friend(user)
    else
      current_user.add_friend(user)
    end
    render :text => user.username

  end

  def following
    @user = User.find_by_username(params[:username])
    if request.url =~ /following$/
      @message = "#{ @user.username } follows #{ @user.friends.size } people"
      @friends = @user.friends
    elsif  request.url =~ /followers$/
      @message = "#{ @user.username } is being followed by #{ @user.friends_of.size } people"
      @friends = @user.friends_of
    else
      redirect :action => "index"
    end
    @friends = @friends.paginate( :page => params[:page], :order => "random()", :per_page => 15)
  end


  def unfollow
    friend = User.find_by_username(params[:username])
    if friend
      current_user.remove_friend(friend)
      render :text => friend.username
    else
      render :text => "None"
    end
  end

  def search
    @q = params[:q]
    @friends = User.find_by_search_query(@q)
  end

end
