# frozen_string_literal: true

require_relative 'area_code'
require_relative 'random_letters'
require_relative 'age_identifier'
# class responsible for creating a vehicle registration by delegating each part to a separate method
class Registration
  attr_reader(:date_of_manufacture, :registration_area)

  def initialize(date_of_manufacture:, registration_area:)
    @date_of_manufacture = date_of_manufacture
    @registration_area = registration_area
  end

  def generate
    area_code = AreaCode.generate(registration_area)
    age_identifier = AgeIdentifier.generate(date_of_manufacture)
    random_letters = RandomLetters.generate

    return nil unless area_code && age_identifier

    "#{area_code} #{age_identifier} #{random_letters}"
  end
end
