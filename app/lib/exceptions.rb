module Exceptions
  class PostProcessError < StandardError
    attr_reader :url

    def initialize url, e
      super e
      @url = url
    end
  end

  class GetCommandError < PostProcessError; end
  class RenderingError < PostProcessError; end
end
