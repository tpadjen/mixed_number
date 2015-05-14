require "mixed_number/version"

class MixedNumber < Numeric
	attr_accessor :value

	DECIMAL_NUMBER_REGEX  = /^-?\d+(.\d+)?$/
	RATIONAL_NUMBER_REGEX = /^-?\d+\/\d+$/
	MIXED_NUMBER_REGEX    = /^-?\d+\s+\d+\/\d+$/

	def initialize(input=0)
		input = input.to_s.strip
		raise MixedNumberFormatError unless is_mixed_number?(input)
		
		reduction_method = input =~ /^-/ ? :- : :+
		@value = input.split.map { |r| Rational(r) }.reduce(reduction_method).to_r
	end

	def whole
		value.to_i
	end

	def fraction
		((value.abs - whole.abs) % 1).to_r
	end

	def ==(other)
		@value == other
	end

	def <=>(other)
		@value <=> other
	end

	def +(other)
		return to_s + other if other.is_a? String

		combine(:+, other)
	end

	def -(other)
		combine(:-, other)
	end

	def *(other)
		combine(:*, other)
	end

	def **(other)
		combine(:**, other)
	end

	def /(other)
		quo(other)
	end

	def quo(other)
		combine(:quo, other)
	end
		
	def coerce(other)
		[MixedNumber.new(other), self]
	end

	def to_s
		sign + remove_zeroes("#{whole.abs} #{fraction}")
	end

	def to_str
		to_s
	end

	private

		def is_mixed_number?(s)
			s =~ Regexp.union(DECIMAL_NUMBER_REGEX, RATIONAL_NUMBER_REGEX, MIXED_NUMBER_REGEX)
		end

		def sign
			value < 0 ? "-" : ""
		end

		def remove_zeroes(string)
			string.gsub(/^0 /, "").gsub(/ 0$/, "").gsub(/ 0\/\d+/, "")
		end

		def combine(method, other)
			if other.is_a? MixedNumber
	    	MixedNumber.new(value.send(method, other.value))
	    elsif other.is_a? Numeric
	    	MixedNumber.new(value.send(method, other))
	    else
	    	if other.respond_to? :coerce
	    		a, b = other.coerce(self)
	    		a.send(method, b)
	    	else
	    		raise TypeError, "#{other.class} can't be coerced into MixedNumber"
	    	end
	    end
		end

	class MixedNumberFormatError < StandardError; end
end

