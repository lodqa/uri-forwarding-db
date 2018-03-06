class Url
  include GetCommand
  include PrepareRender
  include Render

  attr_reader :error

  def do_process
    self.do_get_command
        .do_prepare_render
        .do_render
  end

  def to_success
    {
      name: @matcher.name,
      forwarding: {
        url: @data[:url],
      },
      rendering: @data[:rendering],
      priority: @matcher.priority,
      matching_score: matching_score(@matcher.uri_pattern, @query)
    }
  end

  def to_error
    {
      error: @error.class,
      matcher: {
        name: @matcher.name,
        uri_pattern: @matcher.uri_pattern,
        url_replacement_pattern: @matcher.url_replacement_pattern,
      },
      replaced_url: @data[:url],
      target_url: @error.url,
      error_message: @error.message
    }
  end

  private

  def matching_score uri_pattern, query
    longest_common_substr(uri_pattern, query).length.to_f / query.length
  end

  # https://stackoverflow.com/questions/2158313/finding-common-string-in-array-of-strings-ruby
  def longest_common_substr uri_pattern, query
    strings = [uri_pattern, query]
    shortest = strings.min_by &:length
    maxlen = shortest.length
    maxlen.downto(0) do |len|
      0.upto(maxlen - len) do |start|
        substr = shortest[start,len]
        return substr if strings.all?{|str| str.include? substr }
      end
    end
  end
end
