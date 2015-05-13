require "mixed_number"

describe MixedNumber do
  
	context 'Numeric : ' do
	  
		it 'should be a Numeric' do
		  expect(MixedNumber.new).to be_a(Numeric)
		end

		context 'abs' do
		  it 'finds the absolute value' do
		    expect(MixedNumber.new("-3 2/4").abs).to eq(3.5)
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
		    expect(MixedNumber.new(1) + Rational(1, 2)).to eq(1.5)
		    expect(MixedNumber.new("2 2/5") + 1.5).to eq(3.9)
		  end

		  it 'fails to add to something non-coercable' do
		    expect{MixedNumber.new(1) + " sidfisdjf "}.to raise_error(TypeError)
		    expect{" sidfisdjf " + MixedNumber.new(1)}.to raise_error(TypeError)
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

end