class GenerateImageUrlFromPostUrl
  
  attr_reader :post_url
  
  def initialize(post_url)
    @post_url = post_url
  end
  
  def return_url_string
    image_url_object = open_graph_protocol_object(post_url)
    begin
      if image_url_object.images.any? && valid_image_url(image_url_object)
        image_url_object.images.first.src.to_s
      end
    rescue =>e
      Rails.logger.warn("Couldn't parse OG data for post #{post_url}")
    end
  end
  
  private
  
  def open_graph_protocol_object(url)
    LinkThumbnailer.generate(url_with_protocol(url), attributes: [:images], http_timeout: 2, image_limit: 1, image_stats: false)
  end
  
  #prepend http:// to url if it is missing
  def url_with_protocol(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
  
  #return false if url starts with a / character
  #I want to ignore these urls as it results in a localhost lookup
  #
  #example: /images/sample.jpg would be false
  def valid_image_url(url)
    !url.images.first.src.to_s.starts_with?('/')
  end
   
end
