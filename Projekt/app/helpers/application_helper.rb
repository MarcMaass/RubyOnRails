module ApplicationHelper
  # Method render Nav when User is logedin
  def renderMainNavIfLoggedIn
    application_nav if session[:user_id]      
  end
  # Method render Nav when User is logedin
  def renderHederNavIfLoggedIn
    header_nav if session[:user_id]      
  end
  # Method render Nav when User is logedin
  def renderHeaderMobDataNav
    render :partial => '/common/navs/header_data_nav'
  end
  
  def header_nav
    render :partial => '/common/navs/header_nav'
  end
  
  def application_nav  
    render :partial => '/common/navs/side_nav'
  end
 
  def box_wrapper(&block)  
    content = capture(&block)  
    content_tag(:div, content, :class => 'box')  
  end
end
