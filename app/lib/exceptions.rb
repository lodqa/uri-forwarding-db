module Exceptions
  class GetCommandError < StandardError
    attr_reader :url

    def initialize url, e
      super e
      @url = url
    end
  end
end
