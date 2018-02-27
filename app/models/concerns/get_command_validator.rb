# Verify whether url_replacement_pattern has a valid get command.
class GetCommandValidator < ActiveModel::Validator
  def validate(record)
    unless record.url_replacement_pattern.count('`').modulo(2) == 0
      record.errors[:url_replacement_pattern] << 'must include even number of backtick.'
    end

    commands = record.url_replacement_pattern.scan(/`([^`]+)`/)
    unknown_commands = commands.reject do |cmd|
      cmd[0].start_with? 'GET'
    end
    unless unknown_commands.length == 0
      record.errors[:url_replacement_pattern] << 'may include get commands starting with "GET" enclosed in backtick.'
    end
  end
end
