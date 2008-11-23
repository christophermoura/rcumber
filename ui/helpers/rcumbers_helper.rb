module RcumbersHelper

  def rcumber_flashes(message = 'There were some problems with your submission:')
    if flash[:notice]
      flash_to_display, level = flash[:notice], 'notice'
    elsif flash[:warning]
      flash_to_display, level = flash[:warning], 'warning'
    elsif flash[:error]
      flash_to_display, level = flash[:error], 'error'
    else
      return
    end
    content_tag 'div', flash_to_display, :class => "flash #{level}"
  end
  
end
