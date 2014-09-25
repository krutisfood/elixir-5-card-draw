defmodule Dealer do
  def deck do
    values = Stream.cycle(2..14) |> Enum.take 52
    suits = Stream.cycle([:hearts,:diamonds,:spades,:clubs]) |> Enum.take 52
    deck = values |> Enum.zip suits
  end

  def shuffle(deck) do
    Enum.shuffle deck
  end

  def deal(no_players, deck) do
    no_cards_required = no_players * 5
    deck |> Enum.take(no_cards_required) |> Enum.chunk 5
  end

  # straight flush
  def name_hand([{a,s}, {b,s}, {c,s}, {d,s}, {e,s}]) when a == (b+1) and b == (c+1) and c == (d+1) and d == (e+1), do: :straight_flush
  def name_hand([{a,s}, {b,s}, {c,s}, {d,s}, {e,s}]) when a == 14 and b == 5 and b == (c+1) and c == (d+1) and d == (e+1), do: :straight_flush

  # four of a kind
  def name_hand([{a,_}, {a,_}, {a,_}, {a,_}, {_,_}]), do: :four_of_a_kind 

  #  full house
  def name_hand([{a,_}, {a,_}, {a,_}, {b,_}, {b,_}]), do: :full_house
  def name_hand([{a,_}, {a,_}, {b,_}, {b,_}, {b,_}]), do: :full_house

  #  flush
  def name_hand([{_,a}, {_,a}, {_,a}, {_,a}, {_,a}]), do: :flush

#  straight
#  three_of_a_kind
#  two_pair
#  one_pair

  # high card
  def name_hand(_), do: :high_card

  def declares_defeats(winner, hand2) do
    winner |> name_hand |> hand_rank
    hand2 |> name_hand |> hand_rank

    compare_types
    compare_kickers(winner, hand2)
  end

  def compare_kickers([ hand1_card | rest_of_hand1 ], [ hand2_card | rest_of_hand2 ]) do
    cond do
      hand1_card |> is_higher_than(hand2_card) ->
        true
      true ->
        compare_kickers(rest_of_hand1, rest_of_hand2)
    end
  end

  def compare_kickers([], []) do
    false
  end

  def is_higher_than({value_card1, suit1}, {value_card2, suit2}) do
    IO.puts "Checking if #{value_card1} > #{value_card2}"
    value_card1 > value_card2
  end

  # if hand1_rank > hand2_rank
  #   return hand1 wins
  # else if hand2_rank > hand1_rank
  #   return hand2 wins
  # else
  #   compare kickers (compare all five starting from left?)
  def write_which_kicker_wins do
     IO.puts "Nobody knows"
  end
end
