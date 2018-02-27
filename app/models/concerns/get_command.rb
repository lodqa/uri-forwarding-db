require 'net/http'
require 'active_support/concern'

# Replace /`GET (.+)`/ by HTTP get method to \1
module GetCommand
  extend ActiveSupport::Concern

  TOTAL_REGEXP = /`GET [^`]+`/
  CAPTHABLE_REGEXP = /`GET ([^`]+)`/

  class_methods do
    def do_get_command str
      while TOTAL_REGEXP.match str
        str = replace_by_http_get str
      end

      str
    end

    private

    def replace_by_http_get str
      matched = CAPTHABLE_REGEXP.match str
      url = URI.parse(matched[1])
      res = Net::HTTP.get(url).chomp
      str.sub(TOTAL_REGEXP, res)

    rescue SocketError => e
      raise ::Exceptions::GetCommandError.new url, e
    end
  end
end
