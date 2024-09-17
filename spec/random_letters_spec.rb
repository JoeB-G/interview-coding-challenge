# frozen_string_literal: true

require_relative '../lib/registration_generators/random_letters'

class TestClass
  extend RandomLetters
end

describe RandomLetters do
  TestClass.new
  describe '.generate_ending_letters' do
    context 'when the method is called' do
      it 'returns 3 capital letters from the set of valid letters' do
        50.times do
          expect(TestClass.generate_ending_letters.length).to eq(3)
          expect(TestClass.generate_ending_letters.chars).to all(match(/[A-HJLN-XZ]/))
        end
      end
    end
  end
end
