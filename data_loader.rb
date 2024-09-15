# frozen_string_literal: true

require('csv')
require_relative 'reused_data'

def generate_vehicle_registration(vehicle)
  vehicle[:registrationarea].downcase!
  add_area_code(vehicle)
  append_age_identifier(vehicle)
  append_random_letters
  add_to_complete_registrations(vehicle)
  registration_data.vehicle_registration = []
end


def vehicle_registration_generator
  CSV.foreach('vehicles.csv', headers: true, header_converters: :symbol) do |vehicle|
    generate_vehicle_registration(vehicle)
  rescue ProcessingError => e
    registration_data.unprocessable_records << e.vehicle
  rescue DuplicateRegistrationError => e
    registration_data.vehicle_registration = []
    retry
  end

  pp "total number of unprocessable records #{registration_data.unprocessable_records.count}"
  pp "total number of swansea registrations #{registration_data.swansea_complete_registrations.count}"
  pp "total number of cardiff registrations #{registration_data.cardiff_complete_registrations.count}"
  pp "total number of birmingham registrations #{registration_data.birmingham_complete_registrations.count}"
  pp "total successful registered vehicles #{registration_data.cardiff_complete_registrations.count +
    registration_data.birmingham_complete_registrations.count +
    registration_data.swansea_complete_registrations.count}"
end

def add_area_code(vehicle)
  case vehicle[:registrationarea]
  when 'swansea'
    registration_data.vehicle_registration.prepend('C', registration_data.swansea_characters.sample, ' ')
  when 'cardiff'
    registration_data.vehicle_registration.prepend('C', registration_data.cardiff_characters.sample, ' ')
  when 'birmingham'
    registration_data.vehicle_registration.prepend('B', registration_data.birmingham_characters.sample, ' ')
  else
    raise ProcessingError.new('unable to process vehicle registration area', vehicle)
  end
end

def append_age_identifier(vehicle)
  month, year = vehicle[:dateofmanufacture].scan(registration_data.date_capture_regex).flatten.map(&:to_i)
  case month
  when 3..8
    registration_data.vehicle_registration.append(year)
  when 9..12, 1..2
    registration_data.vehicle_registration.append(year + 50)
  else # type code here
    raise ProcessingError.new('unable to process vehicle age', vehicle)
  end
end

def append_random_letters
  registration_data.vehicle_registration.append(' ', registration_data.end_letters.sample,
                                                registration_data.end_letters.sample,
                                                registration_data.end_letters.sample)
end

def add_to_complete_registrations(vehicle)
  case vehicle[:registrationarea]
  when 'swansea'
    unless registration_data.swansea_complete_registrations.add? registration_data.vehicle_registration.join
      raise DuplicateRegistrationError, vehicle
    end
  when 'cardiff'
    unless registration_data.cardiff_complete_registrations.add? registration_data.vehicle_registration.join
      raise DuplicateRegistrationError, vehicle
    end
  when 'birmingham'
    unless registration_data.birmingham_complete_registrations.add? registration_data.vehicle_registration.join
      raise DuplicateRegistrationError, vehicle
    end
  else
    raise ProcessingError.new('error adding registration to completed queue', vehicle)
  end
end

# error type to throw when unable to process a vehicle record into a registration
class ProcessingError < StandardError
  attr_reader :vehicle

  def initialize(message, vehicle)
    vehicle[:unprocessed_reason] = message
    @vehicle = vehicle
    super(message)
  end
end

# error type to throw when a generated registration is already in use
class DuplicateRegistrationError < StandardError
  attr_reader :vehicle

  def initialize(vehicle, message = 'generated vehicle registration is a duplicate')
    @vehicle = vehicle
    super(message)
  end
end

vehicle_registration_generator
