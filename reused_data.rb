# frozen_string_literal: true

# A lightweight class (Struct) to hold variables we will be using throughout the code challenge
Struct.new('RegistrationData', :end_letters, :swansea_characters, :cardiff_characters, :birmingham_characters,
           :unprocessable_records, :vehicle_registration, :date_capture_regex, :swansea_complete_registrations,
           :cardiff_complete_registrations, :birmingham_complete_registrations, :swansea_dupes, :cardiff_dupes,
           :birmingham_dupes) do

  def initialize
    super
    self.end_letters = [*'A'..'H', 'J', 'L', *'N'..'X', 'Z']
    self.swansea_characters = [*'A'..'K']
    self.cardiff_characters = [*'L'..'Z']
    self.birmingham_characters = %w[A B C]
    self.unprocessable_records = []
    self.vehicle_registration = []
    self.date_capture_regex = /-(?<month>\d{1,2})-.{2}(?<year>\d\d)$/
    self.swansea_complete_registrations = Set.new
    self.cardiff_complete_registrations = Set.new
    self.birmingham_complete_registrations = Set.new
    self.swansea_dupes = 0
    self.cardiff_dupes = 0
    self.birmingham_dupes = 0
  end
end

def registration_data
  @registration_data ||= Struct::RegistrationData.new
end
