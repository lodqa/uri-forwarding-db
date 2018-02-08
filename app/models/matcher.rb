class Matcher < ApplicationRecord
  validates :uri_pattern, presence: true, regex: true
  validates :url_replacement_pattern, presence: true
  validates :name, presence: true
  validates :priority, presence: true

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
