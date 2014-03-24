# encoding: utf-8
module PerformancesHelper  

  # Method save Disciplines in a list
  # by checking the Performance if the Discipline is a part of the Performance
  def putInCategory(performance_list)
    discipline_dict = {}
    CATEGORY_ID.each do |category, category_id| 
      discipline_dict[category] = performance_list.select {|performance| performance.getCategoryID == category_id}
    end
    discipline_dict
  end
  
  # Method for render unit subforms
  # this Froms show the Value Field
  def getUnitFormElements unit_id
    unit_form = UNIT_TYPES[unit_id]
    if mobile_device?
      unit_form_mobile = unit_form + "_mobile"
      render :partial => 'examiners/performances/subforms/'.concat(unit_form_mobile)
    else
      render :partial => 'examiners/performances/subforms/'.concat(unit_form)
    end
  end
  
  # Method searching perfromance
  def get_search_form
    unless @performances.empty?
      render :partial => "search_performance"
    else
      render :partial => '/common/notice', :locals => {:title => 'Es konnten keine Leistungen gefunden werden!'}
    end
  end
  
  # Method render the result partial
  # checking performnace value as maxima and looking for
  # next higher medal and result
  def tell_complete_result_and_next(maxima)
    medal_count = {}
    maxima.each_value {|v| medal_count[v] = medal_count.fetch(v,0) + 1}
    result = complete_result(medal_count)
    possible = next_possible(result, medal_count)
    render :partial => 'athletes/performances/result_and_next', :locals => {:result => result, :possible => possible}
  end
  
  private
  
  # Method check the points as medal_count an Athlete
  # reach in a performance and return the Medal 
  # which he has reach in the performance
  def complete_result(medal_count)
    if medal_count.values().sum() < 4
      return nil
    end
    # calculate the sum of points
    sum_of_points, medal = 0, nil
    medal_count.each do |medal, amount|
      sum_of_points += (amount * medal.points)
    end
    case sum_of_points
    when 0...4
      medal = Medal.find(1).sign # participate
    when 4...8
      medal = Medal.find(2).sign # Bronze
    when 8...11
      medal = Medal.find(3).sign # Silver
    else
      medal = Medal.find(4).sign # Gold
    end
    {:points => sum_of_points, :medal => medal} 
  end
  
  # Method checking what are the next higher Medals
  # a Athelet can reach after finishing a perfromance
  def next_possible(result, medal_count)
    return nil if result == nil
    return {} if result[:medal].downcase == "gold"
    sum_of_points, medal, next_possible = result[:points], result[:medal], {}
    case medal.downcase
    when "teilgenommen"
      to_next = 4
    when "bronze"
      to_next = 8
    when "silber"
      to_next = 11
    end
    gold, silver, bronze = *(Medal.where("points > 0").order("points DESC"))
    
    while to_next > 0
      if to_next >= gold.points
        next_possible["gold"] = next_possible.fetch("gold",0) + 1
        to_next -= gold.points
      elsif to_next >= silver.points
        next_possible["silber"] = next_possible.fetch("silber",0) + 1
        to_next -= silver.points
      else
        next_possible["bronze"] = next_possible.fetch("bronze",0) + 1
        to_next -= bronze.points
      end
    end
    next_possible
  end
  
  # returns the background color for the inspection of a performance
  # in the performances:district_chiefs_controller
  def inspected_class(is_inspected)
    return 'accepted_performance' if is_inspected
    'rejected_performance'
  end
  
  def inspected_text(is_inspected)
    return 'bestätigt' if is_inspected
    'abgelehnt'
  end
end
