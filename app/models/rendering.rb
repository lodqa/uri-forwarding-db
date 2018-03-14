class Rendering
  class << self
    # Get information of a media specified with XPATH from the html
    def from html, xpath_to_media
      doc = Nokogiri::HTML.parse html
      node = doc.at_xpath xpath_to_media
      parse_node node
    end

    private

    def parse_node node
      case node&.name
      when 'img'
        new url: node['src'], mime_type: 'image/*', title: node['title'] || node['alt']
      when 'audio'
        parse_media_tag node, 'audio'
      when 'video'
        parse_media_tag node, 'video'
      else
        new text: node.text.strip, mime_type: 'text/plain'
      end
    end

    def parse_media_tag node, media
      src = node.children.find{ |n|n.name == 'source' }
      if src
        new url: src['src'], mime_type: src['type'] || "#{media}/*"
      else
        new url: node['src'], mime_type: "#{media}/*"
      end
    end
  end

  def initialize(hash = {})
    @hash = hash
  end

  def to_absolute_url url
    return self unless @hash[:url]
    self.class.new self.to_hash.merge(url: URI.join(url, @hash[:url]))
  end

  def to_hash
    @hash
  end
end
