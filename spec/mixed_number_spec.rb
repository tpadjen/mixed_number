require "mixed_number"

describe MixedNumber do

	context 'Creating' do
	  
		it 'should have a private constructor' do
			expect(MixedNumber.respond_to?(:new)).to be(false)
		end

		it 'should be a Numeric' do
		  expect(MixedNumber(1)).to be_a(Numeric)
		end

	end
  
	context 'Operators : ' do

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

			it 'a BigDecimal' do
			  expect(MixedNumber(BigDecimal( 1.5,  16))).to eq( 3.0/2)
			  expect(MixedNumber(BigDecimal(-1.5,  16))).to eq(-3.0/2)
			  expect(MixedNumber(BigDecimal(1.0/3, 16))).to be_within(0.000001).of(1.0/3)
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
			  ["", "1 1 2/3", "1/2 1", "a", "a/b", "a 3/4", "1 2 / 3", "1 -2/3", "1 2/-3", "word", "1 1221"].each do |mixed|
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
			  expect(MixedNumber("  2/10").to_s).to eq("1/5")
			  expect(MixedNumber("1 0/10").to_s).to eq("1")
			  expect(MixedNumber("  0/10").to_s).to eq("0")
			end

		end

		context 'to BigDecimal' do
		  
			it 'converts' do
			  expect(MixedNumber().to_d).to be_a(BigDecimal)
			end

			it 'is accurate' do
			  expect(MixedNumber(  4.0/3).to_d).to be_within(0.0000001).of(4.0/3)
			  expect(MixedNumber("1 1/3").to_d).to be_within(0.0000001).of(4.0/3)
			end

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

	context 'Converting to MixedNumbers' do

	  context 'Strings : ' do
	    
	  	it 'has a conversion method' do
	  	  expect("1/3").to respond_to(:to_m)
	  	  expect("1/3").to_not respond_to(:to_mixed)
	  	end

	  	it 'can convert to a mixed number' do
	  	  expect("1/2".to_m).to be_a(MixedNumber)
	  	  expect("1/2".to_m).to eq(MixedNumber(1.0/2))
	  	end

	  end

	  context 'Fixnums : ' do
	    
	  	it 'has a conversion method' do
	  	  expect(1).to respond_to(:to_m)
	  	  expect(1).to respond_to(:to_mixed)
	  	end

	  	it 'can convert to a mixed number' do
	  	  expect(1.to_m).to be_a(MixedNumber)
	  	  expect(1.to_m).to eq(MixedNumber(1))
	  	  expect(1.to_mixed).to be_a(MixedNumber)
	  	  expect(1.to_mixed).to eq(MixedNumber(1))
	  	end

	  end

	  context 'Floats : ' do
	    
	  	it 'has a conversion method' do
	  	  expect(1.5).to respond_to(:to_m)
	  	  expect(1.5).to respond_to(:to_mixed)
	  	end

	  	it 'can convert to a mixed number' do
	  	  expect(1.5.to_m).to be_a(MixedNumber)
	  	  expect(1.5.to_m).to eq(MixedNumber(1.5))
	  	  expect(1.5.to_mixed).to be_a(MixedNumber)
	  	  expect(1.5.to_mixed).to eq(MixedNumber(1.5))
	  	end

	  end

	  context 'Rationals : ' do
	    
	  	it 'has a conversion method' do
	  	  expect(Rational(2, 4)).to respond_to(:to_m)
	  	  expect(Rational(2, 4)).to respond_to(:to_mixed)
	  	end

	  	it 'can convert to a mixed number' do
	  	  expect(Rational(2, 4).to_m).to be_a(MixedNumber)
	  	  expect(Rational(2, 4).to_m).to eq(MixedNumber(0.5))
	  	  expect(Rational(2, 4).to_mixed).to be_a(MixedNumber)
	  	  expect(Rational(2, 4).to_mixed).to eq(MixedNumber(0.5))
	  	end

	  end

	  context 'BigDecimals : ' do
	    
	  	it 'has a conversion method' do
	  	  expect(BigDecimal(0.8, 4)).to respond_to(:to_m)
	  	  expect(BigDecimal(0.8, 4)).to respond_to(:to_mixed)
	  	end

	  	it 'can convert to a mixed number' do
	  	  expect(BigDecimal(0.8, 4).to_m).to be_a(MixedNumber)
	  	  expect(BigDecimal(0.8, 4).to_m).to eq(MixedNumber(0.8))
	  	  expect(BigDecimal(0.8, 4).to_mixed).to be_a(MixedNumber)
	  	  expect(BigDecimal(0.8, 4).to_mixed).to eq(MixedNumber(0.8))
	  	end

	  end

	end

end