class Matcher < ApplicationRecord
  include GetCommand

  validates :uri_pattern, presence: true, regex: true
  validates :url_replacement_pattern, presence: true
  validates :name, presence: true
  validates :priority, presence: true
  validates_with GetCommandValidator

  # Replace a query uri to URLs
  def self.replace query
    all
      .select{ |m| Regexp.compile(m.uri_pattern).match? query }
      .map { |m| [m, query.gsub(Regexp.compile(m.uri_pattern), m.url_replacement_pattern)] }
      .map do |m, url|
        [nil, m, do_get_command(url)]
      rescue Exceptions::GetCommandError => e
        [e, m, url]
      end
      .reduce(results:[], errors: []) do |body, (err, m, url)|
        unless err
          body[:results] << {
            name: m.name,
            url: url,
            priority: m.priority,
            matching_score: m.matching_score(query)
          }
        end

        if err
          body[:errors] << {
            error: :get_command_error,
            input_uri: query,
            uri_pattern: m.uri_pattern,
            url_replacement_pattern: m.url_replacement_pattern,
            replaced_url: url,
            get_target_url: err.url,
            error_message: err.message
          }
        end

        body
      end
  end

  def matching_score query
    longest_common_substr(query).length.to_f / query.length
  end

  private

  # https://stackoverflow.com/questions/2158313/finding-common-string-in-array-of-strings-ruby
  def longest_common_substr query
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
