module PostProcess
  extend ActiveSupport::Concern

  def initialize query, matcher, data = { url: query.gsub(Regexp.compile(matcher.uri_pattern), matcher.url_replacement_pattern) }, err = nil
    @query = query
    @matcher = matcher
    @data = data
    @error = err
  end

  def setData data
    Url.new @query, @matcher, data
  end

  def setError e
    Url.new @query, @matcher, @data, e
  end

  def post_process
    return self if @error

    data = yield

    setData data
  rescue Exceptions::PostProcessError => e
    setError e
  end
end
