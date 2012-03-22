module RecordsHelper

  def minutes_to_str( minutes = 0 )
    Time.at(minutes * 60).utc.strftime('%H:%M')
  end

end
