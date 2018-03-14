require 'net/http'
require 'nokogiri'

module Render
  extend ActiveSupport::Concern
  include PostProcess

  def do_render
    post_process do
      @data[:rendering] = render @data[:image_url], @matcher.xpath_to_media
      @data
    end
  end

  private

  def render url, xpath_to_media
    return nil if xpath_to_media.blank?

    url = URI.parse(url)
    res = get url

    doc = Nokogiri::HTML.parse res.body
    node = doc.at_xpath xpath_to_media

    { url: URI.join(url, node['src']), title: node['title'] || node['alt'], mime_type: 'image/*' } if node&.name == 'img'
  rescue URI::InvalidURIError => e
    raise ::Exceptions::RenderingError.new url, e
    [err, m, url]
  end

  def get url
    req = Net::HTTP::Get.new(url)
    # http://www.genecards.org/ requires something to the 'User-Agante' header.
    req['User-Agent'] = 'something'
    http = Net::HTTP.new(url.hostname, url.port)
    http.use_ssl = (url.scheme == "https")
    response = http.request(req)

    # The www.genecards.org may return redirect response.
    # For example: http://www.genecards.org/cgi-bin/carddisp.pl?gene=ABCDS
    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then get URI.join(url, response['location'])
    end
  end
end
