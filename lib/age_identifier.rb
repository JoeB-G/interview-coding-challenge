# frozen_string_literal: true

# class to generate age identifier for vehicle registrations from date of manufacture
class AgeIdentifier
  REGEX = /-(?<month>\d{1,2})-.{2}(?<year>\d\d)$/

  # def initialize
  #   @regex = /-(?<month>\d{1,2})-.{2}(?<year>\d\d)$/
  # end

  def self.generate(date)
    month, year = date.scan(REGEX).flatten.map(&:to_i)
    case month
    when 3..8
      year.to_s
    when 9..12, 1..2
      (year + 50).to_s
    else
      nil
    end
  end
end
