class FlitsController < ApplicationController
  before_filter :login_required
#  require 'open-uri'

  def create
    flit = current_user.flits.build(params[:flit])
    flit.message = flit.message[0..140]
#    flit.message = tiny_url(flit.message)
    flit.created_at = Time.now
    flit.save
    redirect_to user_flits_path(current_user.username)
  end

  def destroy
    @flit = Flit.find(params[:id])
    @flit.destroy
    flash[:notice] = t(:deleted)
    redirect_to user_flits_path(current_user.username)
  end

private

  def tiny_url(msg)
    urls = msg.scan(Regexp.new('((https?|file|ftp) : [\w/#~:.?+=&%@!\-] +?) (?=[.:?\-] * (?: [^\w/#~:.?+=&%@!\-]| $ ))', Regexp::EXTENDED))
    urls.each do |url|
      tiny_url = open("http://tinyurl.com/api-create.php?url=#{ url[0]}") { |s| s.read}
      msg.sub!(url[0], "<a href='#{ tiny_url}'>#{tiny_url}</a>")
    end
  end

end
