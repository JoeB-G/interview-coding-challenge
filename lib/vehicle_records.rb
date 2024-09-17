# frozen_string_literal: true

require 'csv'
require_relative 'registration'
# class to read vehicle records from CSV and generate registrations for each vehicle
class VehicleRecords
  attr_reader :unprocessable_vehicles, :completed_registrations, :csv_path, :retry_limit, :total_retries

  def initialize(csv_path)
    @csv_path = csv_path
    @completed_registrations = { swansea: Set.new, cardiff: Set.new, birmingham: Set.new, all: Set.new }
    @unprocessable_vehicles = []
    @retry_limit = 10
    @total_retries = 0
  end

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

        break if completed_registrations[registration_area].add? registration
        break if retry_count > retry_limit

        pp registration
        pp vehicle.to_h
        retry_count += 1
        @total_retries += 1
      end
    end
  end

  def output_totals
    pp "total number of unprocessable records #{unprocessable_vehicles.count}"
    pp "total number of swansea registrations #{completed_registrations[:swansea].count}"
    pp "total number of cardiff registrations #{completed_registrations[:cardiff].count}"
    pp "total number of birmingham registrations #{completed_registrations[:birmingham].count}"
    pp "total successful registered vehicles #{completed_registrations[:birmingham].count + completed_registrations[:cardiff].count + completed_registrations[:swansea].count}"
    pp "total retries #{@total_retries}"
  end
end
