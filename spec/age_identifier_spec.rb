# frozen_string_literal: true

require_relative '../lib/registration_generators/age_identifier'

class TestClass
  extend AgeIdentifier
end

describe AgeIdentifier do
  TestClass.new
  describe '.generate_age_identifier' do
    context 'given an invalid date string' do
      it 'returns nil' do
        expect(TestClass.generate_age_identifier('')).to eq(nil)
        expect(TestClass.generate_age_identifier('aa')).to eq(nil)
        expect(TestClass.generate_age_identifier('99999')).to eq(nil)
        expect(TestClass.generate_age_identifier('9f9f9f9')).to eq(nil)
        expect(TestClass.generate_age_identifier('10-17-1999')).to eq(nil)
      end
    end
    context 'given a date with month March-August' do
      it 'returns year without century' do
        expect(TestClass.generate_age_identifier('10-07-2001')).to eq('01')
        expect(TestClass.generate_age_identifier('10-07-1999')).to eq('99')
      end
    end
    context 'given a date with month September-February' do
      it 'returns year without century plus 50' do
        expect(TestClass.generate_age_identifier('10-09-2001')).to eq('51')
        expect(TestClass.generate_age_identifier('10-09-2040')).to eq('90')
        expect(TestClass.generate_age_identifier('10-09-1999')).to eq('49')
      end
    end
  end
end
