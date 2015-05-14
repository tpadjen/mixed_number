require "mixed_number/version"

class MixedNumber < Numeric

	class << self
		DECIMAL_NUMBER_REGEX  = /^-?\d+(.\d+)?$/
		RATIONAL_NUMBER_REGEX = /^-?\d+\/\d+$/
		MIXED_NUMBER_REGEX    = /^-?\d+\s+\d+\/\d+$/

		def parse(input=0)
			input = input.to_s.strip
			raise MixedNumberFormatError unless is_mixed_number?(input)
			
			reduction_method = input =~ /^-/ ? :- : :+
			new(input.split.map { |r| Rational(r) }.reduce(reduction_method).to_r)
		end

		private

			def is_mixed_number?(s)
				s =~ Regexp.union(DECIMAL_NUMBER_REGEX, RATIONAL_NUMBER_REGEX, MIXED_NUMBER_REGEX)
			end
	end

	def whole
		to_i
	end

	def fraction
		(abs - whole.abs).to_r
	end

	def ==(other)
		@rational == other
	end

	def <=>(other)
		@rational <=> other
	end

	def +(other)
		return to_s + other if other.is_a? String

		combine(:+, other)
	end

	[:-, :*, :**, :quo].each do |method_name|
		define_method method_name do |other|
			combine(method_name, other)
		end
	end
		
	def coerce(other)
		[MixedNumber(other), self]
	end

	def to_s
		sign + remove_zeroes("#{whole.abs} #{fraction}")
	end

	alias_method :/, :quo
	alias_method :to_str, :to_s

	def method_missing(name, *args, &block)
		@rational.send(name, *args, &block)
	end

	private_class_method :new

	private

		def initialize(r)
			@rational = r
		end

		def sign
			self < 0 ? "-" : ""
		end

		def remove_zeroes(string)
			string.gsub(/^0 /, "").gsub(/ 0$/, "").gsub(/ 0\/\d+/, "")
		end

		def combine(method, other)
	    if other.is_a? Numeric
	    	MixedNumber(@rational.send(method, other.to_r))
	    else
	    	raise TypeError, "#{other.class} can't be coerced into MixedNumber" unless other.respond_to? :coerce
	    	a, b = other.coerce(self)
	    	a.send(method, b)
	    end
		end

	class MixedNumberFormatError < StandardError; end
end

def MixedNumber(input=0)
	return input if input.kind_of?(MixedNumber)

	MixedNumber.parse(input)
end

