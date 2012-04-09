module RecordsHelper

  def minutes_to_str( minutes = 0 )
    Time.at(minutes * 60).utc.strftime('%H:%M')
  end

  def link_to_today(date = nil)
    unless date == Date.today
      link_to "Today", records_path(:date => Date.today)	  
    else
      "Today activities"
    end
  end
  
  def records_for_date(records,date)   
    records.select{ |rec| rec.date == date}
  end
end

