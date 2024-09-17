# frozen_string_literal: true

require_relative '../lib/registration'

describe Registration do

  describe '.generate' do
    context 'given an invalid date of manufacture returns nil' do
      it 'returns nil' do
        registration = Registration.new(date_of_manufacture: 'sausages', registration_area: :swansea)
        expect(registration.generate).to eq(nil)
      end
    end
    context 'given an invalid registration area returns nil' do
      it 'returns nil' do
        registration = Registration.new(date_of_manufacture: '10-10-2010', registration_area: :poland)
        expect(registration.generate).to eq(nil)
      end
    end
    context 'given a valid valid area and data' do
      it 'returns a valid registration when given valid area and data' do
        registration = Registration.new(date_of_manufacture: '10-10-2010', registration_area: :cardiff)
        expect(registration.generate).to match(/C[L-Z] 60 [A-Z]{3}/)
      end
    end
  end
end
