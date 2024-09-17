# frozen_string_literal: true

# class to create area codes for vehicle registration, stores required character sets + business logic
class AreaCode
  # attr_reader(:swansea_characters, :cardiff_characters, :birmingham_characters)
  SWANSEA_CHARACTERS =  [*'A'..'K']
  CARDIFF_CHARACTERS = [*'L'..'Z']
  BIRMINGHAM_CHARACTERS = %w[A B C]
  # def initialize
  #   @swansea_characters = [*'A'..'K']
  #   @cardiff_characters = [*'L'..'Z']
  #   @birmingham_characters = %w[A B C]
  #   super
  # end

  def self.generate(area)
    case area
    when :swansea
      "C#{SWANSEA_CHARACTERS.sample}"
    when :cardiff
      "C#{CARDIFF_CHARACTERS.sample}"
    when :birmingham
      "B#{BIRMINGHAM_CHARACTERS.sample}"
    else
      nil
    end
  end
end
