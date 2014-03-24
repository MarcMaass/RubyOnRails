module PathHelper
  # Method help to show the correct site pathes by checking User authority
  def application_home_url
    case session[:type]
    when "Examiner"
      examiners_path
    when "DistrictChief" 
      district_chiefs_path
    else
      athletes_path
    end
  end
 
end