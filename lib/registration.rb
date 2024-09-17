# frozen_string_literal: true

require_relative 'registration_generators/area_code'
require_relative 'registration_generators/random_letters'
require_relative 'registration_generators/age_identifier'
# class responsible for creating a vehicle registration by using methods from the registration generator moudles
class Registration
  attr_reader(:date_of_manufacture, :registration_area)

  extend AgeIdentifier
  extend RandomLetters
  extend AreaCode

  def initialize(date_of_manufacture:, registration_area:)
    @date_of_manufacture = date_of_manufacture
    @registration_area = registration_area
  end

  def generate
    area_code = Registration.generate_area_code(registration_area)
    age_identifier = Registration.generate_age_identifier(date_of_manufacture)
    random_letters = Registration.generate_ending_letters

    return nil unless area_code && age_identifier

    "#{area_code} #{age_identifier} #{random_letters}"
  end
end
