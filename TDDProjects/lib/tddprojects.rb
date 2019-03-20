require 'byebug'

class Array
  def my_uniq
    dedupped = Hash.new
    self.each do |val|
      dedupped[val] = true
    end
    dedupped.keys
  end

  def two_sum
    all_sums = Array.new
    each_index do |i1|
      each_index do |i2|
        all_sums << [i1, i2] if i2 > i1 && (self[i1] == -self[i2])
      end
    end
    all_sums
  end

  def my_transpose
    trans_arr = Array.new
    (0...self.length).each do |i|
      current_row = Array.new
      self.each do |row|
        current_row << row[i] 
      end
      trans_arr << current_row
    end
    trans_arr
  end

end

# [50,30,60,80,90,20]

def stock_picker(arr)

  all_sums = Array.new
  arr.each_index do |i1|
    arr.each_index do |i2|
      all_sums << [i1, i2] if i2 > i1
    end
  end
  highest_pair = [0,1]
  all_sums.each do |pair|
    i1,i2 = pair
    if (arr[i2] - arr[i1]) > (arr[highest_pair[1]] - arr[highest_pair[0]]) 
      highest_pair = [i1,i2]
    end
  end
  highest_pair
end

class Towers
  attr_reader :discs

  def initialize
    @discs = [[1, 2, 3], [], []]
  end

  def move(disc1, disc2)
    raise ArgumentError.new('The disk you are trying to move from is empty.') if discs[disc1-1].empty?
    raise ArgumentError.new('Disc you are moving is too big for destination.') if (discs[disc2-1].first && (discs[disc2-1].first < discs[disc1-1].first))
    self.discs[disc2-1].unshift(self.discs[disc1-1].shift)
  end

  def won?
    self.discs[0].empty? && (discs[1].length == 3 || discs[2].length == 3)
  end

end