# frozen_string_literal: true

require_relative '../lib/vehicle_records'

csv_path = ARGV[0] || 'vehicles.csv'

vehicle_records = VehicleRecords.new(csv_path)
vehicle_records.generate_registrations
vehicle_records.output_totals
