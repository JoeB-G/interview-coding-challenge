# frozen_string_literal: true

# class to generate the ending 3 random letters from a subset of letters for vehicle registrations
class RandomLetters
  LETTERS_SUBSET = [*'A'..'H', 'J', 'L', *'N'..'X', 'Z'].freeze

  def self.generate
    Array.new(3) { LETTERS_SUBSET.sample }.join
  end
end
