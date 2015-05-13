require "mixed_number/version"

class MixedNumber < Numeric
	extend Forwardable

	attr_accessor :value

	DECIMAL_NUMBER_REGEX  = /^-?\d+(.\d+)?$/
	RATIONAL_NUMBER_REGEX = /^-?\d+\/\d+$/
	MIXED_NUMBER_REGEX    = /^-?\d+\s+\d+\/\d+$/

	def_delegators :@value, :abs

	def initialize(input=0)
		input = input.to_s.strip
		raise MixedNumberFormatError unless is_mixed_number(input)
		
		reduction_method = input =~ /^-/ ? :- : :+
		@value = input.split.map { |r| Rational(r) }.reduce(reduction_method).to_r
	end

	def ==(other)
		@value == other
	end

	def <=>(other)
		@value <=> other
	end

	def +(other)
		if other.is_a? MixedNumber
    	MixedNumber.new(value + other.value)
    elsif other.is_a? Numeric
    	MixedNumber.new(value + other)
    else
    	if other.respond_to? :coerce
    		a, b = other.coerce(self)
    		a + b
    	else
    		raise TypeError, "#{other.class} can't be coerced into MixedNumber"
    	end
    end
	end

	def coerce(other)
		[MixedNumber.new(other), self]
	end

	private

		def is_mixed_number(s)
			s =~ Regexp.union(DECIMAL_NUMBER_REGEX, RATIONAL_NUMBER_REGEX, MIXED_NUMBER_REGEX)
		end

	class MixedNumberFormatError < StandardError; end
end

