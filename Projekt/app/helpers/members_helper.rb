module MembersHelper
  # Check User authority
  def write_type(type)
    case type
    when "DistrictChief"
      "Bezirksleiter"
    when "Examiner"
      "Pruefer"
    else
      "Sportler"
    end
  end
  
  # Method User authority is changing
  def options(member)
    unless member.type
      upgrade(member)
    else
      downgrade(member)
    end
  end
  
  # authority upgrade
  def upgrade(member)
    render :partial => 'upgrade', :locals => {:member => member}
  end
  
  # authority downgrade
  def downgrade(member)
    link_to 'Pruefungsrecht entziehen', district_chiefs_downgrade_path(member), :method => :put, :remote => :true, :confirm => 'Sind Sie sicher?', :id => "options_#{member.id}" 
  end
  
end