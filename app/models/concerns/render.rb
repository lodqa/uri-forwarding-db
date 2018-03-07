require 'net/http'
require 'nokogiri'

module Render
  extend ActiveSupport::Concern
  include PostProcess

  def do_render
    post_process do
      @data[:rendering] = render @data[:image_url], @matcher.xpath_to_image
      @data
    end
  end

  private

  def render url, xpath_to_image
    return nil if xpath_to_image.blank?

    url = URI.parse(url)
    req = Net::HTTP::Get.new(url)
    # http://www.genecards.org/ requires something to the 'User-Agante' header.
    req['User-Agent'] = 'something'
    http = Net::HTTP.new(url.hostname, url.port)
    http.use_ssl = (url.scheme == "https")
    res = http.request(req)

    doc = Nokogiri::HTML.parse res.body
    node = doc.at_xpath xpath_to_image
    { url: URI.join(url, node['src']), title: node['title'] || node['alt'] } if node
  rescue URI::InvalidURIError => e
    raise ::Exceptions::RenderingError.new url, e
    [err, m, url]
  end
end
