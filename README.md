# MixedNumber

Mixed numbers in ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'mixed_number'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mixed_number

## Usage
```ruby
# Creating Mixed Numbers
MixedNumber() == 0		   		# => true
MixedNumber(8)					# => 8
MixedNumber(1.5).to_s      		# => "1 1/2"
MixedNumber("2 6/18") 			# => 2 1/3
MixedNumber(9.0/3)			 	# => 3
MixedNumber("-4 3/4").to_f  	# => -4.75
```
```ruby
# MixedNumbers are Numerics
mixed = MixedNumber("3 3/4")
mixed.truncate					# => 3
mixed.round						# => 4
mixed.numerator					# => 15
mixed + 2						# => 5 3/4
2 * mixed						# => 7 1/2
# ...
```
```ruby
# Convert Numbers and Strings
1.5.to_mixed					# => 1 1/2
(15.0/4).to_m					# => 3 3/4
Rational(14, 4).to_m			# => 3 1/2
BigDecimal(1.8, 4).to_m			# => 1 4/5
"3 5/6".to_m					# => 3 5/6
```

## Contributing

1. Fork it ( https://github.com/tpadjen/mixed_number/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
