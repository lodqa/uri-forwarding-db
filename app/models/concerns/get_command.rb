require 'net/http'
require 'active_support/concern'

# Replace /`GET (.+)`/ by HTTP get method to \1
module GetCommand
  extend ActiveSupport::Concern
  include PostProcess

  def do_get_command
    post_process do
      @data[:url] = do_get @data[:url]
      @data
    end
  end

  private

  TOTAL_REGEXP = /`GET [^`]+`/
  CAPTHABLE_REGEXP = /`GET ([^`]+)`/

  def do_get str
    while TOTAL_REGEXP.match str
      str = replace_by_http_get str
    end

    str
  end

  def replace_by_http_get str
    matched = CAPTHABLE_REGEXP.match str
    url = URI.parse(matched[1])
    res = URI.encode(Net::HTTP.get(url).chomp)
    str.sub(TOTAL_REGEXP, res)
  rescue SocketError => e
    raise ::Exceptions::GetCommandError.new url, e
  end
end
