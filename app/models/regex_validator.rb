class RegexValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Regexp.compile(value)
  rescue RegexpError
    record.errors[attribute] << (options[:message] || 'is not valid Perl Compatible Regular Expressions')
  end
end
