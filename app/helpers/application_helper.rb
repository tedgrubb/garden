module ApplicationHelper
  def format_temperature(temp)    
    "#{temp.ceil}°"  
  end

  def formatted_date
    today = Date.today
    "#{today.strftime("%A, %B")} #{today.strftime("%e").to_i.ordinalize}"
  end
end
