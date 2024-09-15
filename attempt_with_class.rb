# frozen_string_literal: true

# class to use data from vehicle CSV to generate Vehicle Registration Numbers
class VehicleRegistration
  attr_accessor(:area, :date, :code)

  def initialize(area:, date:)
    @area = area
    @date = date
    super
  end

  def generate

  end

  private

  def area_code(area)
    case area
    when 'swansea'
      code.prepend('C', registration_data.swansea_characters.sample, ' ')
    when 'cardiff'
      code.vehicle_registration.prepend('C', registration_data.cardiff_characters.sample, ' ')
    when 'birmingham'
      code.vehicle_registration.prepend('B', registration_data.birmingham_characters.sample, ' ')
    else
      raise ProcessingError.new('unable to process vehicle registration area', vehicle)
    end
  end

  def age_identifier(date)
    month, year = date.scan(registration_data.date_capture_regex).flatten.map(&:to_i)
    case month
    when 3..8
      registration_data.vehicle_registration.append(year)
    when 9..12, 1..2
      registration_data.vehicle_registration.append(year + 50)
    else
      raise ProcessingError.new('unable to process vehicle age', vehicle)
    end
  end

  def random_ending_letters
    registration_data.vehicle_registration.append(' ', registration_data.end_letters.sample,
                                                  registration_data.end_letters.sample,
                                                  registration_data.end_letters.sample)
  end
  
end
