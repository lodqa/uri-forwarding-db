require 'csv'

CSV.generate(col_sep: "\t") do |csv|
  @result.each { |r| csv << [r[:name], r[:url], r[:priority], r[:matching_score]] }
end
