require "mixed_number"

describe MixedNumber do
  
	context 'Numeric : ' do
	  
		it 'should be a Numeric' do
		  expect(MixedNumber.new).to be_a(Numeric)
		end

		context 'abs' do
		  it 'finds the absolute value' do
		    expect(MixedNumber.new("-3 2/4").abs).to eq(3.5)
		    expect(MixedNumber.new( "3 2/4").abs).to eq(3.5)
		  end
		end

		context 'abs2' do
		  it 'finds the square of the value' do
		    expect(MixedNumber.new(" 3"    ).abs2).to eq(9)
		    expect(MixedNumber.new("-3"    ).abs2).to eq(9)
		    expect(MixedNumber.new("-3 2/4").abs2).to eq(49.0/4)
		  end
		end

		context '<=>' do
		  it 'compares' do
		    expect(MixedNumber.new(  0) <=>   1).to be(-1)
		    expect(MixedNumber.new(  1) <=> 1/2).to be( 1)
		    expect(MixedNumber.new(1.5) <=> 1.5).to be( 0)
		  end
		end

		context '+' do
		  it 'adds' do
		    expect(MixedNumber.new(0) + MixedNumber.new(1)).to eq(1)
		    expect(0 + MixedNumber.new(1)).to eq(1)
		    expect(MixedNumber.new(1) + Rational(1, 2)).to eq(1.5)
		    expect(MixedNumber.new("2 2/5") + 1.5).to eq(3.9)
		  end

		  it 'concatenates' do
		    expect(MixedNumber.new("2 2/4") + " hello").to eq("2 1/2 hello")
		    expect("hello " + MixedNumber.new("2 2/4")).to eq("hello 2 1/2")
		  end

		  it 'fails to add to something non-coercable' do
		    expect{MixedNumber.new(1) + Object.new}.to raise_error(TypeError)
		  end
		end

		context '-' do
		  it 'subtracts' do
		    expect(MixedNumber.new(0) - MixedNumber.new(1)).to eq(-1)
		    expect(0 - MixedNumber.new(1)).to eq(-1)
		    expect(MixedNumber.new(1) - Rational(1, 2)).to eq(0.5)
		    expect(MixedNumber.new("2 2/5") - 1.7).to eq(7.0/10)
		  end

		  it 'fails to subtract from something non-coercable' do
		    expect{MixedNumber.new(1) - Object.new}.to raise_error(TypeError)
		  end
		end

		context '/' do
		  it 'divides' do
		    expect(MixedNumber.new(4) / MixedNumber.new(2)).to eq(2)
		    expect(4 / MixedNumber.new(2)).to eq(2)
		    expect(MixedNumber.new(1) / Rational(1, 2)).to eq(2)
		    expect(MixedNumber.new("2 1/2") / 2).to eq(1.25)
		  end

		  it 'fails to divide something non/coercable' do
		    expect{MixedNumber.new(1) / Object.new}.to raise_error(TypeError)
		  end
		end

		context '*' do
		  it 'multiplies' do
		    expect(MixedNumber.new(4) * MixedNumber.new(2)).to eq(8)
		    expect(4 * MixedNumber.new(2)).to eq(8)
		    expect(MixedNumber.new(3) * Rational(1, 2)).to eq(1.5)
		    expect(MixedNumber.new("2 1/2") * 2).to eq(5)
		  end

		  it 'fails to multiply something non/coercable' do
		    expect{MixedNumber.new(1) * Object.new}.to raise_error(TypeError)
		  end
		end

		context '**' do
		  it 'exponentiates' do
		    expect(MixedNumber.new(4) ** MixedNumber.new(2)).to eq(16)
		    expect(4 ** MixedNumber.new(2)).to eq(16)
		    expect(MixedNumber.new(3) ** Rational(1, 2)).to eq(3**0.5)
		    expect(MixedNumber.new("2 1/2") ** 2).to eq(2.5**2)
		  end

		  it 'fails to exponentiate something non/coercable' do
		    expect{MixedNumber.new(1) ** Object.new}.to raise_error(TypeError)
		  end
		end

		context '==' do
		  it 'compares equality' do
		    expect(MixedNumber.new(4) == MixedNumber.new(2)).to eq(false)
		    expect(MixedNumber.new(4) == MixedNumber.new(4)).to eq(true)
		    expect(4 == MixedNumber.new(4)).to eq(true)
		    expect(4 == MixedNumber.new(2)).to eq(false)
		    expect(MixedNumber.new(2) == 4).to eq(false)
		    expect(MixedNumber.new(4) == 4).to eq(true)
		  end
		end

		context '-@' do
		  it 'negates' do
		    expect(-MixedNumber.new(4)).to eq(-4)
		    expect(-MixedNumber.new(-4)).to eq(4)
		  end
		end

		context '+@' do
		  it 'positivity' do
		    expect(+MixedNumber.new(4)).to eq(4)
		    expect(+MixedNumber.new(-4)).to eq(-4)
		  end
		end

		context 'angle' do
		  it 'angles' do
		    expect(MixedNumber.new(4).angle).to be(0)
		    expect(MixedNumber.new(-4).angle).to be(Math::PI)
		  end
		end

		context 'arg' do
		  it 'args' do
		    expect(MixedNumber.new(4).arg).to be(0)
		    expect(MixedNumber.new(-4).arg).to be(Math::PI)
		  end
		end

		context 'ceil' do
		  it 'finds the next highest integer' do
		    expect(MixedNumber.new(   1).ceil).to eq( 1)
		    expect(MixedNumber.new( 1.2).ceil).to eq( 2)
		    expect(MixedNumber.new(-1.2).ceil).to eq(-1)
		    expect(MixedNumber.new(-1.0).ceil).to eq(-1)
		  end
		end

		context 'floor' do
		  it 'finds the previous highest integer' do
		    expect(MixedNumber.new(   1).floor).to eq( 1)
		    expect(MixedNumber.new( 1.2).floor).to eq( 1)
		    expect(MixedNumber.new(-1.2).floor).to eq(-2)
		    expect(MixedNumber.new(-1.0).floor).to eq(-1)
		  end
		end

		context 'conj' do
		  it 'conjugates' do
		  	mixed = MixedNumber.new(1)
		    expect(mixed.conj).to eq(mixed)
		    expect(mixed.conjugate).to eq(mixed)
		  end
		end

		context 'imag' do
		  it 'finds imaginary part' do
		  	mixed = MixedNumber.new(1)
		    expect(mixed.imag).to eq(0)
		    expect(mixed.imaginary).to eq(0)
		  end
		end

		context 'div' do
		  it 'divides to an integer' do
		    expect(MixedNumber.new(   1).div(2)).to eq( 0)
		    expect(MixedNumber.new(-1.0).div(2)).to eq(-1)
		    expect(MixedNumber.new( 2.2).div(2)).to eq( 1)
		    expect(MixedNumber.new(-2.2).div(2)).to eq(-2)
		  end
		end

		context 'divmod' do
		  it 'finds quotient and modulus' do
		    expect(MixedNumber.new(   1).divmod(2)).to eq([ 0,  1])
		    expect(MixedNumber.new(-1.0).divmod(2)).to eq([-1,  1])
		    expect(MixedNumber.new( 2.2).divmod(2)).to eq([ 1,  0.2])
		    expect(MixedNumber.new(-2.2).divmod(2)).to eq([-2,  9.0/5])
		  end
		end

		context 'eql?' do
		  it 'performs type and value equality comparison' do
		    expect(MixedNumber.new(1).eql?(MixedNumber.new(2.0/2))).to be(true)
		    expect(MixedNumber.new(1).eql?(MixedNumber.new(2.0/4))).to be(false)
		    expect(MixedNumber.new(1).eql?(2.0/2)).to be(false)
		    expect(MixedNumber.new(1).eql?(2.0/4)).to be(false)
		  end
		end

	end

	context 'Parsing : ' do

		context 'valid input :' do

			it 'defaults to zero' do
			  expect(MixedNumber.new).to eq(0)
			end
		  
			it 'a Fixnum' do
			  expect(MixedNumber.new(  1)).to eq(  1)
			  expect(MixedNumber.new(135)).to eq(135)
			  expect(MixedNumber.new( -1)).to eq( -1)
			end

			it 'a Rational' do
			  expect(MixedNumber.new(Rational( 1,  2))).to eq( 0.5)
			  expect(MixedNumber.new(Rational( 1, -2))).to eq(-0.5)
			  expect(MixedNumber.new(Rational(-1,  2))).to eq(-0.5)
			  expect(MixedNumber.new(Rational(-1, -2))).to eq( 0.5)
			end

			it 'a Float' do
			  expect(MixedNumber.new( 1.5)).to eq( 3.0/2)
			  expect(MixedNumber.new(-1.5)).to eq(-3.0/2)
			end

			context 'Strings : ' do
			  it 'a whole number' do
			    expect(MixedNumber.new( "1")).to eq( 1)
			    expect(MixedNumber.new("-1")).to eq(-1)
			  end

			  it 'a fraction' do
			    expect(MixedNumber.new(" 1/2")).to eq( 0.5)
			    expect(MixedNumber.new("-1/2")).to eq(-0.5)
			  end

			  it 'a mixed number' do
			    expect(MixedNumber.new(" 1 2/3")).to eq( 5.0/3)
			    expect(MixedNumber.new("-1 2/3")).to eq(-5.0/3)
			  end

			  it 'trims input' do
			    expect(MixedNumber.new( " 1 2/3\t\t")).to eq( 5.0/3)
			    expect(MixedNumber.new(" -1 2/3\t\t")).to eq(-5.0/3)
			  end

			  it 'ignores extra space between whole and fractional part' do
			  	expect(MixedNumber.new( "1 \t2/3")).to eq( 5.0/3)
			  	expect(MixedNumber.new("-1 \t2/3")).to eq(-5.0/3)
			  end

			end

		end

		context 'invalid input : ' do
		  
			it 'raises an error when dividing by zero' do
			  expect{MixedNumber.new("1 2/0")}.to raise_error(ZeroDivisionError)
			  expect{MixedNumber.new(  "2/0")}.to raise_error(ZeroDivisionError)
			end

			it 'raises an error when not formatted like a mixed number' do
			  ["", "1 1 2/3", "1/2 1", "a", "a/b", "a 3/4", "1 2 / 3", "1 -2/3", "1 2/-3", "word"].each do |mixed|
			  	expect{MixedNumber.new(mixed)}.to raise_error(MixedNumber::MixedNumberFormatError)
			  end
			end

		end

	end

	context 'Conversion : ' do
	  
		context 'to String' do
		  
			it 'reduces to the closest whole number' do
			  expect(MixedNumber.new("2 2/10").to_s).to eq("2 1/5")
			  expect(MixedNumber.new("3/15").to_s).to eq("1/5")
			  expect(MixedNumber.new("35/15").to_s).to eq("2 1/3")
			  expect(MixedNumber.new(1.5).to_s).to eq("1 1/2")
			end

			it 'works with negative numbers' do
			  expect(MixedNumber.new("-2 2/10").to_s).to eq("-2 1/5")
			  expect(MixedNumber.new("-3/15").to_s).to eq("-1/5")
			  expect(MixedNumber.new("-35/15").to_s).to eq("-2 1/3")
			  expect(MixedNumber.new(-1.5).to_s).to eq("-1 1/2")
			end

			it 'is the same explicit and implicit' do
			  mixed = MixedNumber.new("-3 8/4")
			  expect(mixed.to_s).to eq(mixed.to_str) 
			end

			it 'removes zero parts' do
			  expect(MixedNumber.new("2/10").to_s).to eq("1/5")
			  expect(MixedNumber.new("1 0/10").to_s).to eq("1")
			end

		end

	end

	context 'Parts' do
	  
		it 'finds the whole part' do
		  expect(MixedNumber.new(2).whole).to eq(2)
		  expect(MixedNumber.new("2 1/2").whole).to eq(2)
		  expect(MixedNumber.new("1/2").whole).to eq(0)
		end

		it 'finds the fractional part' do
		  expect(MixedNumber.new(2).fraction).to eq(0)
		  expect(MixedNumber.new("2 1/2").fraction).to eq(0.5)
		  expect(MixedNumber.new("1/2").fraction).to eq(0.5)
		  expect(MixedNumber.new("1 99999/100000").fraction).to eq(Rational(99999, 100000))
		  expect(MixedNumber.new(1 + Math::PI).fraction.to_f).to be_within(0.0000001).of(Math::PI - 3) 
		end

	end

end