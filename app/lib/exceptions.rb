module Exceptions
  class PostProcessError < StandardError
    def initialize e
      super e
    end
  end

  class GetCommandError < PostProcessError; end
  class RenderingError < PostProcessError; end
  class ParseError < PostProcessError
    def initialize
      super "Failed to parse the response body."
    end
  end
end
