# encoding: UTF-8
module DisciplinesHelper
  # Method return gender String from gender ID
  def fancy_gender(id)
    return "FRAUEN" if id == 1
    "MÄNNER"
  end
  
  # Method take performance Value and convert it in correct from
  def convert_value(value, unit)
    case UNIT_TYPES[unit.id]
    when 'time_minutes'
      "#{(value.to_i/60)}:#{number_to_human(value.to_i%60, :format => ('0%n' if (value.to_i%60) < 10))}"
    when 'time_seconds'
      number_with_precision(value, :precision => 1, :seperator => ',')
    when 'metre'
      number_with_precision(value, :precision => 2, :seperator => ',')
    else
      value.to_i
    end 
  end
end
  
