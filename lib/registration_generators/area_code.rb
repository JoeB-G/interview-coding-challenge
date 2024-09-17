# frozen_string_literal: true

# module to create area codes for vehicle registration, stores required character sets + business logic
module AreaCode

  SWANSEA_CHARACTERS = ('A'..'K').to_a.freeze
  CARDIFF_CHARACTERS = ('L'..'Z').to_a.freeze
  BIRMINGHAM_CHARACTERS = %w[A B C].freeze

  def generate_area_code(area)
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
