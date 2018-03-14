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
        new node['src'], 'image/*', node['title'] || node['alt']
      when 'audio'
        parse_media_tag node, 'audio'
      when 'video'
        parse_media_tag node, 'video'
      end
    end

    def parse_media_tag node, media
      src = node.children.find{ |n|n.name == 'source' }
      if src
        new src['src'], src['type'] || "#{media}/*"
      else
        new node['src'], "#{media}/*"
      end
    end
  end

  def initialize(url, mime_type, title = '')
    @url = url
    @mime_type = mime_type
    @title = title
  end

  def to_absolute_url url
    self.class.new URI.join(url, @url), @mime_type, @title
  end

  def to_hash
    { url: @url, mime_type: @mime_type, title: @title }
  end
end
