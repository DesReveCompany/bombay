class MainController < ApplicationController

  def index
    @flit = Flit.find :all
  end

  def search
    @q = params[:q]
#    @friends = User.find_by_search_query(@q)
#    @total = User.find :all, :include => [:flits],
    @total = User.find :all
#             :conditions => ['users.username LIKE ? OR flits.message LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%"]
    @friends = User.paginate :per_page => 10, :page => params[:page], :include => [:flits],
             :conditions => ['users.username LIKE ? OR flits.message LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%"]
  end


end
