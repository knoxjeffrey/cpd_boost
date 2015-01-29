module ApplicationHelper
  
  #prepend http:// to url if it is missing
  def url_with_protocol(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
  
  #modify date presentation.
  #
  #example 15 hours, 1 day, 1 week 
  def display_friendly_date(date)
    time_ago_in_words(date)
  end
  
  def generate_url_preview(post_url)
    url = url_with_protocol(post_url.to_s)
    LinkThumbnailer.generate(url)
  end
  
end
