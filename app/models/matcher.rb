class Matcher < ApplicationRecord
  validates :uri_pattern, presence: true, regex: true
  validates :url_replacement_pattern, presence: true
  validates :name, presence: true
  validates :priority, presence: true
  validates_with GetCommandValidator

  class << self
    # Replace a query uri to URLs
    def replace query
      result = urls_for(query)
        .map(&:do_process)
        .reduce(results:[], errors: []) { |body, url| format_result body, url }

      result[:input_uri] = query
      result
    end

    private

    def urls_for query
      all
        .select{ |m| Regexp.compile(m.uri_pattern).match? query }
        .map { |m| Url.new query, m }
    end

    def format_result body, url
      if url.error
        body[:errors] << url.to_error
      else
        body[:results] << url.to_success
      end

      body
    end
  end
end
