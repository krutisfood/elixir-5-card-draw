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
    six_players = 6
    no_cards_required = six_players * 5
    deck |> Enum.take(no_cards_required) |> Enum.chunk 5
  end

  # straight flushes
  def name_hand([{a,s}, {b,s}, {c,s}, {d,s}, {e,s}]) when a == (b+1) and b == (c+1) and c == (d+1) and d == (e+1), do: :straight_flush
  def name_hand([{a,s}, {b,s}, {c,s}, {d,s}, {e,s}]) when a == 14 and b == 5 and b == (c+1) and c == (d+1) and d == (e+1), do: :straight_flush

  # four of a kind
  def name_hand([{a,_}, {a,_}, {a,_}, {a,_}, {_,_}]), do: :four_of_a_kind 

#  full_house
#  flush
#  straight
#  three_of_a_kind
#  two_pair
#  one_pair
#  high_card

  def name_hand(_), do: :high_card

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
