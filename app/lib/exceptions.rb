module Exceptions
  class PostProcessError < StandardError; end

  class GetCommandError < PostProcessError
    def initialize e
      super e
    end
  end

  class InvalidURIError < PostProcessError; end

  class GatewayError < PostProcessError
    def initialize(response)
      super "Gateway Error: the sever returns '#{response.code} #{response.message}'"
    end
  end

  class ParseError < PostProcessError
    def initialize
      super "Failed to parse the response body."
    end
  end
end
