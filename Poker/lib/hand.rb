class Hand 
  attr_reader :cards
  
  def initialize(cards)
    @cards = cards
  end

  def compare(other_hand)
    first_hand = find_best_hand(self)
    second_hand = find_best_hand(other_hand)

    if first_hand > second_hand 
      return self
    elsif second_hand > first_hand
      return other_hand
    
    else                    # Tiebreaker
      tiebreaker(self,other_hand,first_hand)
    end
  end

  def highcardtiebreaker(hand1, hand2)
    hand1vals = Array.new
    hand2vals = Array.new
    hand1.cards.each do |card|
      hand1vals << card.value
    end
    hand2.cards.each do |card|
      hand2vals << card.value
    end
    hand1vals.sort!
    hand2vals.sort!
    i = 0
    equals = true
    bigger_hand = nil
    while i < 5 && equals
      equals = hand1vals[i] == hand2vals[i]
      if hand1vals[i] != hand2vals[i]
        bigger_hand = (hand1vals[i] > hand2vals[i] ? hand1 : hand2)
      end
      i += 1
    end
    return bigger_hand if bigger_hand 
    return nil
  end

  def valuescounter(hand)
    hashvalues = Hash.new(0)
    hand.cards.each do |card|
      hashvalues[card.value] += 1
    end
    return hashvalues
  end


  def onepairtiebreaker(hand1,hand2)
    hand1counter = valuescounter(hand1)
    hand2counter = valuescounter(hand2)
    
    hand1_value = hand1counter.select { |key, value| value == 2 }
    hand2_value = hand2counter.select { |key, value| value == 2 }

    if hand1_value.keys[0] > hand2_value.keys[0]
      return hand1
    elsif hand2_value.keys[0] > hand1_value.keys[0]
      return hand2
    else
      hand1vals = Array.new
      hand2vals = Array.new
      hand1.cards.each do |card|
        hand1vals << card.value
      end
      hand2.cards.each do |card|
        hand2vals << card.value
      end
      hand1vals.delete(hand1_value.keys[0])
      hand2vals.delete(hand2_value.keys[0])
      hand1vals.sort!
      hand2vals.sort!
      i = 0
      bigger_hand = nil
      equals = true
      while i < 3 && equals
        equals = hand1vals[i] == hand2vals[i]
        if hand1vals[i] != hand2vals[i]
          bigger_hand = (hand1vals[i] > hand2vals[i] ? hand1 : hand2)
        end
        i += 1
      end
      return bigger_hand if bigger_hand 
      return nil
    end
  end

  def twopairtiebreaker(hand1,hand2)
    hand1counter = valuescounter(hand1)
    hand2counter = valuescounter(hand2)
    
    hand1_value = hand1counter.select { |key, value| value == 2 } # { 13:2, 6:2 } in this case hand 1 has a pair of kings and 6's
    hand2_value = hand2counter.select { |key, value| value == 2 }

    hand1keys = hand1_value.keys.sort
    hand2keys = hand2_value.keys.sort

    if hand1keys[-1] != hand2keys[-1]
      if hand1keys[-1] > hand2keys[-1]
        return hand1
      elsif hand2keys[-1] > hand1keys[-1]
        return hand2
      end
    elsif hand1keys[-2] != hand2keys[-2]
      if hand1keys[-2] > hand2keys[-2]
        return hand1
      elsif hand2keys[-2] > hand1keys[-2]
        return hand2
      end
    else
      hand1vals = Array.new
      hand2vals = Array.new
      hand1.cards.each do |card|
        hand1vals << card.value
      end
      hand2.cards.each do |card|
        hand2vals << card.value
      end
      hand1vals.delete(hand1_value.keys[0])
      hand2vals.delete(hand2_value.keys[0])
      hand1vals.sort!
      hand2vals.sort!
      if hand1vals[0] != hand2vals[0]
        return (hand1vals[i] > hand2vals[i] ? hand1 : hand2)
      end
      nil
    end
  end



  def threekindtiebreaker(hand1,hand2)
    hand1counter = valuescounter(hand1)
    hand2counter = valuescounter(hand2)
    
    hand1_value = hand1counter.select { |key, value| value == 3 }
    hand2_value = hand2counter.select { |key, value| value == 3 }

    if hand1_value.keys[0] > hand2_value.keys[0]
      return hand1
    elsif hand2_value.keys[0] > hand1_value.keys[0]
      return hand2
    else
      hand1vals = Array.new
      hand2vals = Array.new
      hand1.cards.each do |card|
        hand1vals << card.value
      end
      hand2.cards.each do |card|
        hand2vals << card.value
      end
      hand1vals.delete(hand1_value.keys[0])
      hand2vals.delete(hand2_value.keys[0])
      hand1vals.sort!
      hand2vals.sort!
      i = 0
      bigger_hand = nil
      equals = true
      while i < 2 && equals
        equals = hand1vals[i] == hand2vals[i]
        if hand1vals[i] != hand2vals[i]
          bigger_hand = (hand1vals[i] > hand2vals[i] ? hand1 : hand2)
        end
        i += 1
      end
      return bigger_hand if bigger_hand 
      return nil
    end
  end


  def straight_tiebreaker(hand1,hand2)
    card_values_1 = Array.new
    card_values_2 = Array.new
    hand1.cards.each do |card|
      card_values_1 << card.value
    end
    hand2.cards.each do |card|
      card_values_2 << card.value
    end
    card_values_1 = ace_checker(card_values_1.sort!)
    card_values_2 = ace_checker(card_values_2.sort!)
    if card_values_1[-1] != card_values_2[-1]
      return (card_values_1[-1] > card_values_2[-1] ? hand1 : hand2)
    end
    nil
  end

  def ace_checker(hand_arr)
    if hand_arr[0] == 1
      if hand_arr[1] == 2
        return hand_arr
      else
        hand_arr << 14
        hand_arr.shift
        return hand_arr
      end
    end
  end

  def flush_tiebreaker(hand1, hand2)
    highcardtiebreaker(hand1,hand2)
  end

  def full_house_tiebreaker(hand1,hand2)
    hand1counter = valuescounter(hand1)
    hand2counter = valuescounter(hand2)
    
    pair1 = hand1counter.select { |key, value| value == 2 } # { 13:2, 6:2 } in this case hand 1 has a pair of kings and 6's
    threekind1 = hand1counter.select { |key,value| value == 3 }
    pair2 = hand2counter.select { |key, value| value == 2 }
    threekind2 = hand2counter.select { |key,value| value == 3 }

    if threekind1.keys[0] != threekind2.keys[0]
      if threekind1.keys[0] > threekind2.keys[0]
        return hand1
      elsif threekind2.keys[0] > threekind1.keys[0]
        return hand2
      end
    elsif pair1.keys[0] != pair2.keys[0]
      if pair1.keys[0] > pair2.keys[0]
        return hand1
      elsif pair2.keys[0] > pair1.keys[0]
        return hand2
      end
    else
      nil
    end
  end

  def tiebreaker(hand1, hand2, rank)

    case rank

    when 0
      return highcardtiebreaker(hand1, hand2)
    when 1
      return onepairtiebreaker(hand1,hand2)
    when 2 
      return twopairtiebreaker(hand1,hand2)
    when 3
      return threekindtiebreaker(hand1,hand2)
    when 4
      return straight_tiebreaker(hand1,hand2)
    when 5
      return flush_tiebreaker(hand1, hand2)
    when 6
      return full_house_tiebreaker(hand1,hand2)
    when 7
    when 8

    end

  end


  def find_best_hand(hand)
    if straight_flush?(hand)
      return 8
    elsif four_of_a_kind?(hand)
      return 7
    elsif full_house?(hand)
      return 6
    elsif flush?(hand)
      return 5
    elsif straight?(hand)
      return 4
    elsif three_of_a_kind?(hand)
      return 3
    elsif two_pair?(hand)
      return 2
    elsif one_pair?(hand)
      return 1
    else
      return 0
    end
  end

  def flush?(hand)
    suits = Hash.new(0)
    hand.cards.each do |card|
      suits[card.suit] += 1
    end
    suits.values.include? (5)
  end

  def straight?(hand)
    values = Array.new
    hand.cards.each do |card|
      values << card.value
    end
    values.sort!
    values.each_with_index do |val, idx|
      if values[0] == 1       # once serted, if we have an ace they will be at index 0
        if values[1] != 2     # check that we don't want to use them as our low car
          values << 14        # add it instead as our high card value = 14
          values.shift
        end                   # and proceed with straight checking as usual
      end
      if idx!= 0 
        return false if val-1 != values[idx-1]  
      end
    end
    true
  end

  def straight_flush?(hand)
    flush?(hand) && straight?(hand)
  end

  def kind_checker(hand, number)
    values_hash = Hash.new(0)
    hand.cards.each do |card|
      values[card.value] += 1
    end
    values_hash.values.include?(number)
  end

  def four_of_a_kind?(hand)
    kind_checker(hand, 4)
  end

  def three_of_a_kind?(hand)
    kind_checker(hand, 3)
  end

  def one_pair?(hand)
    kind_checker(hand, 2)
  end

  def full_house(hand)
    one_pair?(hand) && three_of_a_kind?(hand)
  end

  def two_pair?(hand)
    values_hash = Hash.new(0)
    hand.cards.each do |card|
      values[card.value] += 1
    end
    values_hash.values.select { |value| value == 2}.length == 2
  end

end