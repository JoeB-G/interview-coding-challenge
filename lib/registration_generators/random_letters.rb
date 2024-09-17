# frozen_string_literal: true

# module to generate the ending 3 random letters from a subset of letters for vehicle registrations
module RandomLetters
  LETTERS_SUBSET = %w[A B C D E F G H J L N O P Q R S T U V W X Z].freeze

  def generate_ending_letters
    Array.new(3) { LETTERS_SUBSET.sample }.join
  end
end
