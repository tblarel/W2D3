require 'tddprojects'

describe "#my_uniq" do
  subject(:array) { [1, 2, 1, 3, 3] }
  it "removes duplicate elements" do
    expect(array.my_uniq).to eq([1, 2, 3])
  end
end

describe "#two_sum" do 
  subject(:array) { [-1, 0, 2, -2, 1] }
  it "finds all pairs summed to zero" do
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end
end

describe "#my_transpose" do
  subject(:array) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }  
  it "transposes the array" do
    expect(array.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end
end


describe "#stock_picker" do
  subject(:array) { [50,30,60,80,90,20] }
  it "outputs most profitable days to buy & sell" do
    expect(stock_picker(array)).to eq([1,4])
  end
end

# Disc 1 = [1,2,3]
# Disc 2 = []
# Disc 3 = []

describe Towers do 
  subject(:towers) { Towers.new }

  describe "#move" do
    it "moves the discs appropriately" do
      towers.move(1,2)
      expect(towers.discs[0]).to eq([2, 3])
      expect(towers.discs[1]).to eq([1])
    end

    it "doesn't allow incorrect move" do
      towers.move(1,2)
      expect { towers.move(1,2) }.to raise_error(ArgumentError)
    end

    it "doesn't allow moving from empty piles" do
      expect { towers.move(3, 1) }.to raise_error(ArgumentError)
    end
  end

  describe "#won?" do
    it "is true when all discs have been moved to pile 3" do
      towers.move(1,3)
      towers.move(1,2)
      towers.move(3,2)
      towers.move(1,3)
      towers.move(2,1)
      towers.move(2,3)
      towers.move(1,3)  
      expect(towers.won?).to be true 
    end
    it "is false when game has been won" do
      expect(towers.won?).to be false
      towers.move(1,3)
      towers.move(1,2)
      expect(towers.won?).to be false
    end

  end

end