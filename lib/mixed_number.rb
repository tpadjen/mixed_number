require "mixed_number/version"
require "bigdecimal"

class MixedNumber < Numeric

	class << self
		DECIMAL_NUMBERS  = /^-?\d+(.\d+)?$/
		RATIONAL_NUMBERS = /^-?\d+\/\d+$/
		MIXED_NUMBERS    = /^-?\d+\s+\d+\/\d+$/
		VALID_NUMBERS = Regexp.union(DECIMAL_NUMBERS, RATIONAL_NUMBERS, MIXED_NUMBERS) 

		def parse(input=0)
			n = stringify(input).strip
			raise MixedNumberFormatError unless n =~ VALID_NUMBERS
			
			reduction_method = n =~ /^-/ ? :- : :+
			new(n.split.map { |r| Rational(r) }.reduce(reduction_method).to_r)
		end

		private
			def stringify(n)
				n.is_a?(BigDecimal) ? n.to_s('F') : n.to_s
			end
	end

	def whole
		to_i
	end

	def fraction
		abs.to_r - whole.abs
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
		@rational_string
	end

	def to_d
		BigDecimal(@rational, 32)
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
			@rational_string = sign + remove_zeroes("#{whole.abs} #{fraction}")
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

