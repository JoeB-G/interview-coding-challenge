# frozen_string_literal: true

require_relative '../lib/registration_generators/area_code'

class TestClass
  extend AreaCode
end

describe AreaCode do
  TestClass.new
  describe '.generate_area_code' do
    context 'given an invalid registration area' do
      it 'returns nil' do
        expect(TestClass.generate_area_code('')).to eq(nil)
        expect(TestClass.generate_area_code('aa')).to eq(nil)
        expect(TestClass.generate_area_code(:london)).to eq(nil)
        expect(TestClass.generate_area_code(:Swansea)).to eq(nil)
        expect(TestClass.generate_area_code(:cardifff)).to eq(nil)

      end
    end
    context 'given a valid registration area' do
      it 'returns the correct first character of area code' do
        expect(TestClass.generate_area_code(:swansea).chars[0]).to eq('C')
        expect(TestClass.generate_area_code(:cardiff).chars[0]).to eq('C')
        expect(TestClass.generate_area_code(:birmingham).chars[0]).to eq('B')
      end
    end
    it 'returns the a second character of area code from the correct range' do
      20.times do
        expect(TestClass.generate_area_code(:swansea).chars[1]).to match(/[A-K]/)
        expect(TestClass.generate_area_code(:cardiff).chars[1]).to match(/[L-Z]/)
        expect(TestClass.generate_area_code(:birmingham).chars[1]).to match(/[A-C]/)
      end
    end
  end
end
