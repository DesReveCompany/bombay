# Methods added to this helper will be available to all templates in the application.

module ApplicationHelper

  include TagsHelper

  def show_date(date)
    date.strftime("%m/%d/%Y %I:%M%p")
  end

  def image_icon_tag(source, options = {})
    options.symbolize_keys!

    options[:src] = "images/icon/" + source + ".png"
    options[:alt] ||= File.basename(options[:src], '.*').split('.').first.to_s.capitalize

    options[:width], options[:height] = 14
    options[:id] = "icon"

    tag("img", options)
  end


end
