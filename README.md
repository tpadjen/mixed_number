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
MixedNumber() == 0		   		# true
MixedNumber(8)					# 8
MixedNumber(1.5).to_s      		# "1 1/2"
MixedNumber("2 6/18") 			# 2 1/3
MixedNumber("9/3")		 		# 3
MixedNumber("-4 3/4").to_f  	# -4.75

# MixedNumbers are Numerics
n = MixedNumber("3 3/4")
n.truncate						# 3
n.round							# 4
n.numerator						# 15
2 * n							# 7 1/2
# ...
```

## Contributing

1. Fork it ( https://github.com/tpadjen/mixed_number/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
