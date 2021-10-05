module Exceptions
  class PostProcessError < StandardError
    def initialize e
      super e
    end
  end

  class GetCommandError < PostProcessError; end
  class RenderingError < PostProcessError; end
end
