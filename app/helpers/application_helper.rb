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
  
  def generate_url_attributes_preview(post_url)
    url = url_with_protocol(post_url.to_s)
    begin
      url_attributes ||= LinkThumbnailer.generate(url, attributes: [:images], http_timeout: 2, image_limit: 1, image_stats: false)
      if !url_attributes.images.empty? && valid_image_url(url_attributes)
        url_attributes.images.first.src.to_s
      else
        ''
      end
    rescue =>e
      ''
    end
  end
  
  #return false is url starts with a / character
  #I want to ignore these urls as it results in a localhost lookup
  #
  #example: /images/sample.jpg would be false
  def valid_image_url(url)
    !url.images.first.src.to_s.starts_with?('/')
  end
  
end
