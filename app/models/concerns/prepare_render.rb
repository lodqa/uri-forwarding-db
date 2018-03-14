require 'net/http'
require 'kaminari'

module PrepareRender
  extend ActiveSupport::Concern
  include PostProcess

  def do_prepare_render
    post_process do
      @data[:image_url] = prepare_render @query, @data[:url], @matcher.uri_pattern, @matcher.url_replacement_pattern_for_media
      @data
    end
  end

  private

  def prepare_render query, url, uri_pattern, url_replacement_pattern_for_media
    return url if url_replacement_pattern_for_media.blank?

    query.gsub(Regexp.compile(uri_pattern), url_replacement_pattern_for_media)
  end
end
