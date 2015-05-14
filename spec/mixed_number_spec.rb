require "mixed_number"

describe MixedNumber do

	context 'Creating' do
	  
		it 'should have a private constructor' do
			expect(MixedNumber.respond_to?(:new)).to be(false)
		end

	end
  
	context 'Numeric : ' do
	  
		it 'should be a Numeric' do
		  expect(MixedNumber(1)).to be_a(Numeric)
		end

		context 'abs' do
		  it 'finds the absolute value' do
		    expect(MixedNumber("-3 2/4").abs).to eq(3.5)
		    expect(MixedNumber( "3 2/4").abs).to eq(3.5)
		  end
		end

		context 'abs2' do
		  it 'finds the square of the value' do
		    expect(MixedNumber(" 3"    ).abs2).to eq(9)
		    expect(MixedNumber("-3"    ).abs2).to eq(9)
		    expect(MixedNumber("-3 2/4").abs2).to eq(49.0/4)
		  end
		end

		context '<=>' do
		  it 'compares' do
		    expect(MixedNumber(  0) <=>   1).to be(-1)
		    expect(MixedNumber(  1) <=> 1/2).to be( 1)
		    expect(MixedNumber(1.5) <=> 1.5).to be( 0)
		  end
		end

		context '+' do
		  it 'adds' do
		    expect(MixedNumber(0) + MixedNumber(1)).to eq(1)
		    expect(0 + MixedNumber(1)).to eq(1)
		    expect(MixedNumber(1) + Rational(1, 2)).to eq(1.5)
		    expect(MixedNumber("2 2/5") + 1.5).to eq(3.9)
		  end

		  it 'concatenates' do
		    expect(MixedNumber("2 2/4") + " hello").to eq("2 1/2 hello")
		    expect("hello " + MixedNumber("2 2/4")).to eq("hello 2 1/2")
		  end

		  it 'fails to add to something non-coercable' do
		    expect{MixedNumber(1) + Object.new()}.to raise_error(TypeError)
		  end
		end

		context '-' do
		  it 'subtracts' do
		    expect(MixedNumber(0) - MixedNumber(1)).to eq(-1)
		    expect(0 - MixedNumber(1)).to eq(-1)
		    expect(MixedNumber(1) - Rational(1, 2)).to eq(0.5)
		    expect(MixedNumber("2 2/5") - 1.7).to eq(7.0/10)
		  end

		  it 'fails to subtract from something non-coercable' do
		    expect{MixedNumber(1) - Object.new()}.to raise_error(TypeError)
		  end
		end

		context '/' do
		  it 'divides' do
		    expect(MixedNumber(4) / MixedNumber(2)).to eq(2)
		    expect(4 / MixedNumber(2)).to eq(2)
		    expect(MixedNumber(1) / Rational(1, 2)).to eq(2)
		    expect(MixedNumber("2 1/2") / 2).to eq(1.25)
		  end

		  it 'fails to divide something non/coercable' do
		    expect{MixedNumber(1) / Object.new()}.to raise_error(TypeError)
		  end
		end

		context '*' do
		  it 'multiplies' do
		    expect(MixedNumber(4) * MixedNumber(2)).to eq(8)
		    expect(4 * MixedNumber(2)).to eq(8)
		    expect(MixedNumber(3) * Rational(1, 2)).to eq(1.5)
		    expect(MixedNumber("2 1/2") * 2).to eq(5)
		  end

		  it 'fails to multiply something non/coercable' do
		    expect{MixedNumber(1) * Object.new()}.to raise_error(TypeError)
		  end
		end

		context '**' do
		  it 'exponentiates' do
		    expect(MixedNumber(4) ** MixedNumber(2)).to eq(16)
		    expect(4 ** MixedNumber(2)).to eq(16)
		    expect(MixedNumber(3) ** Rational(1, 2)).to eq(3**0.5)
		    expect(MixedNumber("2 1/2") ** 2).to eq(2.5**2)
		  end

		  it 'fails to exponentiate something non/coercable' do
		    expect{MixedNumber(1) ** Object.new()}.to raise_error(TypeError)
		  end
		end

		context '==' do
		  it 'compares equality' do
		    expect(MixedNumber(4) == MixedNumber(2)).to eq(false)
		    expect(MixedNumber(4) == MixedNumber(4)).to eq(true)
		    expect(4 == MixedNumber(4)).to eq(true)
		    expect(4 == MixedNumber(2)).to eq(false)
		    expect(MixedNumber(2) == 4).to eq(false)
		    expect(MixedNumber(4) == 4).to eq(true)
		  end
		end

		context '-@' do
		  it 'negates' do
		    expect(-MixedNumber(4)).to eq(-4)
		    expect(-MixedNumber(-4)).to eq(4)
		  end
		end

		context '+@' do
		  it 'positivity' do
		    expect(+MixedNumber(4)).to eq(4)
		    expect(+MixedNumber(-4)).to eq(-4)
		  end
		end

		context 'angle' do
		  it 'angles' do
		    expect(MixedNumber(4).angle).to be(0)
		    expect(MixedNumber(-4).angle).to be(Math::PI)
		  end
		end

		context 'arg' do
		  it 'args' do
		    expect(MixedNumber(4).arg).to be(0)
		    expect(MixedNumber(-4).arg).to be(Math::PI)
		  end
		end

		context 'ceil' do
		  it 'finds the next highest integer' do
		    expect(MixedNumber(   1).ceil).to eq( 1)
		    expect(MixedNumber( 1.2).ceil).to eq( 2)
		    expect(MixedNumber(-1.2).ceil).to eq(-1)
		    expect(MixedNumber(-1.0).ceil).to eq(-1)
		  end
		end

		context 'floor' do
		  it 'finds the previous highest integer' do
		    expect(MixedNumber(   1).floor).to eq( 1)
		    expect(MixedNumber( 1.2).floor).to eq( 1)
		    expect(MixedNumber(-1.2).floor).to eq(-2)
		    expect(MixedNumber(-1.0).floor).to eq(-1)
		  end
		end

		context 'conj' do
		  it 'conjugates' do
		  	mixed = MixedNumber(1)
		    expect(mixed.conj).to eq(mixed)
		    expect(mixed.conjugate).to eq(mixed)
		  end
		end

		context 'imag' do
		  it 'finds imaginary part' do
		  	mixed = MixedNumber(1)
		    expect(mixed.imag).to eq(0)
		    expect(mixed.imaginary).to eq(0)
		  end
		end

		context 'div' do
		  it 'divides to an integer' do
		    expect(MixedNumber(   1).div(2)).to eq( 0)
		    expect(MixedNumber(-1.0).div(2)).to eq(-1)
		    expect(MixedNumber( 2.2).div(2)).to eq( 1)
		    expect(MixedNumber(-2.2).div(2)).to eq(-2)
		  end
		end

		context 'divmod' do
		  it 'finds quotient and modulus' do
		    expect(MixedNumber(   1).divmod(2)).to eq([ 0,  1])
		    expect(MixedNumber(-1.0).divmod(2)).to eq([-1,  1])
		    expect(MixedNumber( 2.2).divmod(2)).to eq([ 1,  0.2])
		    expect(MixedNumber(-2.2).divmod(2)).to eq([-2,  9.0/5])
		  end
		end

		context 'eql?' do
		  it 'performs type and value equality comparison' do
		    expect(MixedNumber(1).eql?(MixedNumber(2.0/2))).to be(true)
		    expect(MixedNumber(1).eql?(MixedNumber(2.0/4))).to be(false)
		    expect(MixedNumber(1).eql?(2.0/2)).to be(false)
		    expect(MixedNumber(1).eql?(2.0/4)).to be(false)
		  end
		end

		context 'integer?' do
		  it 'checks for integers' do
		    expect(MixedNumber(1  ).integer?).to be(false)
		    expect(MixedNumber(1.0).integer?).to be(false)
		    expect(MixedNumber("2 1/2").integer?).to be(false)
		    expect(MixedNumber("2 4/4").integer?).to be(false)
		  end
		end

		context 'magnitude' do
		  it 'finds the absolute value' do
		    expect(MixedNumber("-3 2/4").magnitude).to eq(3.5)
		    expect(MixedNumber( "3 2/4").magnitude).to eq(3.5)
		  end
		end

		context 'modulo' do
		  it 'modulates' do
		    expect(MixedNumber(5).modulo(2)).to eq(5-2*(5.0/2).floor)
		  end
		end

		context 'nonzero?' do
		  it 'returns self or nil' do
		    one  = MixedNumber(1)
		    zero = MixedNumber(0)
		    expect(one.nonzero?).to be(one)
		    expect(zero.nonzero?).to be(nil)
		  end
		end

		context 'phase' do
		  it 'phases' do
		    expect(MixedNumber( 4).phase).to be(0)
		    expect(MixedNumber(-4).phase).to be(Math::PI)
		  end
		end

		context 'polar' do
		  it 'polarizes' do
		    one = MixedNumber(1)
		  	expect(one.polar).to eq([one.abs, one.arg])
		  end
		end

		context 'real' do
		  it 'is self' do
		    one = MixedNumber(1)
		  	expect(one.real).to eq(one)
		  end
		end

		context 'real?' do
		  it 'is true' do
		    one = MixedNumber(1)
		  	expect(one.real?).to eq(true)
		  end
		end

		context 'rect' do
		  it 'rectangularizes' do
		    one = MixedNumber(1)
		  	expect(one.rect).to 			 eq([one, 0])
		  	expect(one.rectangular).to eq([one, 0])
		  end
		end

		context 'remainder' do
		  it 'finds the remainder' do
		    expect(MixedNumber(33).remainder(10)).to eq(3)
		  end
		end

		context 'round' do
		  it 'rounds' do
		    expect(MixedNumber(1  ).round).to eq(1)
		    expect(MixedNumber(1.2).round).to eq(1)
		    expect(MixedNumber(1.5).round).to eq(2)
		    expect(MixedNumber(1.6).round).to eq(2)
		  end
		end

		context 'truncate' do
		  it 'truncates' do
		    expect(MixedNumber(1  ).truncate).to eq(1)
		    expect(MixedNumber(1.2).truncate).to eq(1)
		  end
		end

		context 'zero?' do
		  it 'finds zero' do
		    expect(MixedNumber(0).zero?).to be(true)
		    expect(MixedNumber(1).zero?).to be(false)
		  end
		end

	end

	context 'Parsing : ' do

		context 'valid input :' do

			it 'defaults to zero' do
			  expect(MixedNumber()).to eq(0)
			end
		  
			it 'a Fixnum' do
			  expect(MixedNumber(  1)).to eq(  1)
			  expect(MixedNumber(135)).to eq(135)
			  expect(MixedNumber( -1)).to eq( -1)
			end

			it 'a Rational' do
			  expect(MixedNumber(Rational( 1,  2))).to eq( 0.5)
			  expect(MixedNumber(Rational( 1, -2))).to eq(-0.5)
			  expect(MixedNumber(Rational(-1,  2))).to eq(-0.5)
			  expect(MixedNumber(Rational(-1, -2))).to eq( 0.5)
			end

			it 'a Float' do
			  expect(MixedNumber( 1.5)).to eq( 3.0/2)
			  expect(MixedNumber(-1.5)).to eq(-3.0/2)
			end

			context 'Strings : ' do
			  it 'a whole number' do
			    expect(MixedNumber( "1")).to eq( 1)
			    expect(MixedNumber("-1")).to eq(-1)
			  end

			  it 'a fraction' do
			    expect(MixedNumber(" 1/2")).to eq( 0.5)
			    expect(MixedNumber("-1/2")).to eq(-0.5)
			  end

			  it 'a mixed number' do
			    expect(MixedNumber(" 1 2/3")).to eq( 5.0/3)
			    expect(MixedNumber("-1 2/3")).to eq(-5.0/3)
			  end

			  it 'trims input' do
			    expect(MixedNumber( " 1 2/3\t\t")).to eq( 5.0/3)
			    expect(MixedNumber(" -1 2/3\t\t")).to eq(-5.0/3)
			  end

			  it 'ignores extra space between whole and fractional part' do
			  	expect(MixedNumber( "1 \t2/3")).to eq( 5.0/3)
			  	expect(MixedNumber("-1 \t2/3")).to eq(-5.0/3)
			  end

			end

		end

		context 'invalid input : ' do
		  
			it 'raises an error when dividing by zero' do
			  expect{MixedNumber("1 2/0")}.to raise_error(ZeroDivisionError)
			  expect{MixedNumber(  "2/0")}.to raise_error(ZeroDivisionError)
			end

			it 'raises an error when not formatted like a mixed number' do
			  ["", "1 1 2/3", "1/2 1", "a", "a/b", "a 3/4", "1 2 / 3", "1 -2/3", "1 2/-3", "word"].each do |mixed|
			  	expect{MixedNumber(mixed)}.to raise_error(MixedNumber::MixedNumberFormatError)
			  end
			end

		end

	end

	context 'Conversion : ' do
	  
		context 'to String' do
		  
			it 'reduces to the closest whole number' do
			  expect(MixedNumber("2 2/10").to_s).to eq("2 1/5")
			  expect(MixedNumber("3/15").to_s).to eq("1/5")
			  expect(MixedNumber("35/15").to_s).to eq("2 1/3")
			  expect(MixedNumber(1.5).to_s).to eq("1 1/2")
			end

			it 'works with negative numbers' do
			  expect(MixedNumber("-2 2/10").to_s).to eq("-2 1/5")
			  expect(MixedNumber("-3/15").to_s).to eq("-1/5")
			  expect(MixedNumber("-35/15").to_s).to eq("-2 1/3")
			  expect(MixedNumber(-1.5).to_s).to eq("-1 1/2")
			end

			it 'is the same explicit and implicit' do
			  mixed = MixedNumber("-3 8/4")
			  expect(mixed.to_s).to eq(mixed.to_str) 
			end

			it 'removes zero parts' do
			  expect(MixedNumber("2/10").to_s).to eq("1/5")
			  expect(MixedNumber("1 0/10").to_s).to eq("1")
			end

		end

		it 'to integer' do
		  expect(MixedNumber(1).to_i).to be_a(Fixnum)
		  expect(MixedNumber(1).to_i).to eq(1)
		end

		it 'to float' do
		  expect(MixedNumber(1).to_f).to be_a(Float)
		  expect(MixedNumber(1).to_f).to eq(1.0)
		end

		it 'to rational' do
		  expect(MixedNumber(1).to_r).to be_a(Rational)
		  expect(MixedNumber(1).to_r).to eq(Rational(1, 1))
		end

	end

	context 'Parts' do
	  
		it 'finds the whole part' do
		  expect(MixedNumber(2).whole).to eq(2)
		  expect(MixedNumber("2 1/2").whole).to eq(2)
		  expect(MixedNumber("1/2").whole).to eq(0)
		end

		it 'finds the fractional part' do
		  expect(MixedNumber(2).fraction).to eq(0)
		  expect(MixedNumber("2 1/2").fraction).to eq(0.5)
		  expect(MixedNumber("1/2").fraction).to eq(0.5)
		  expect(MixedNumber("1 99999/100000").fraction).to eq(Rational(99999, 100000))
		  expect(MixedNumber(1 + Math::PI).fraction.to_f).to be_within(0.0000001).of(Math::PI - 3) 
		end

	end

end