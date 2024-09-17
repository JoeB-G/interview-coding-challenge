# frozen_string_literal: true

require 'csv'
require_relative 'registration'
# class to read vehicle records from CSV and generate registrations for each vehicle
class VehicleRecords
  attr_reader :unprocessable_vehicles, :completed_registrations, :csv_path, :retry_limit, :total_retries

  def initialize(csv_path)
    @csv_path = csv_path
    @completed_registrations = {}
    @unprocessable_vehicles = []
    @retry_limit = 10
    @total_retries = 0
  end

  # method to loop through vehicles CSV attempting to generate a registration for each
  def generate_registrations
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |vehicle|
      date_of_manufacture = vehicle[:dateofmanufacture]
      registration_area = vehicle[:registrationarea].downcase.to_sym
      retry_count = 0

      loop do
        registration = Registration.new(date_of_manufacture:, registration_area:).generate

        if registration.nil?
          unprocessable_vehicles.append vehicle
          break
        end
        break if add_to_completed_registrations(registration_area, registration) == :duplicate

        if retry_count > retry_limit
          pp 'Hit retry limit'
          unprocessable_vehicles.append vehicle
          break
        end

        retry_count += 1
        @total_retries += 1
      end
    end
  end

  def add_to_completed_registrations(registration_area, registration)
    completed_registrations[registration_area] ||= Set.new
    return unless completed_registrations[registration_area].add? registration

    :duplicate
  end

  # output total of vehicle records processed
  def output_totals
    total_registrations = 0
    completed_registrations.each do |location, registrations|
      pp "total number of #{location} registrations #{registrations.count}"
      total_registrations += registrations.count
    end
    pp "total successful registered vehicles #{total_registrations}"
    pp "total vehicles where registration count not be determined #{unprocessable_vehicles.count}"
    pp "total vehicle records processed #{total_registrations + unprocessable_vehicles.count}"
    pp "total retries #{@total_retries}"
  end
end
