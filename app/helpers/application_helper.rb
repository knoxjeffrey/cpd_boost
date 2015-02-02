module ApplicationHelper
  
  #modify date presentation.
  #
  #example 15 hours, 1 day, 1 week 
  def display_friendly_date(date)
    time_ago_in_words(date)
  end
  
end
