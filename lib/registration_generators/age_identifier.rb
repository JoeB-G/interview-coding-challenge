# frozen_string_literal: true

# module to generate age identifier for vehicle registrations from date of manufacture
module AgeIdentifier
  REGEX = /-(?<month>\d{1,2})-.{2}(?<year>\d\d)$/

  def generate_age_identifier(date)
    month, year = date.scan(REGEX).flatten
    case month.to_i
    when 3..8
      year.to_s
    when 9..12, 1..2
      (year.to_i + 50).to_s.chars.last(2).join
    else
      nil
    end
  end
end
