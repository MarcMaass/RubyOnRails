module AthletesHelper
  #
  # this method decides if the organization units should be shown
  # in the user profile
  # if the actual user is an Athlete, then the organization_units should
  # be rendered.
  # district chiefs and examiners should not change the memberships
  #
  def render_organization_units
    if session[:type] == "Athlete"
      render :partial => 'common/profile/orga_units'
    end
  end
  
  # prints the status of activation
  def active(user)
    return '<span class=red>aktiviert</span>'.html_safe if user.activated
    '<span class=red>nicht aktiviert</span>'.html_safe
  end
  
end
