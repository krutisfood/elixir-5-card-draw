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
  def hand_rank([{a,s}, {b,s}, {c,s}, {d,s}, {e,s}]) when a == (b+1) and b == (c+1) and c == (d+1) and d == (e+1), do: 9
  def hand_rank([{a,s}, {b,s}, {c,s}, {d,s}, {e,s}]) when a == 14 and b == 5 and b == (c+1) and c == (d+1) and d == (e+1), do: 9

  # four of a kind
  def hand_rank([{a,_}, {a,_}, {a,_}, {a,_}, {_,_}]), do: 8

  #  full house
  def hand_rank([{a,_}, {a,_}, {a,_}, {b,_}, {b,_}]), do: 7
  def hand_rank([{a,_}, {a,_}, {b,_}, {b,_}, {b,_}]), do: 7

  #  flush
  def hand_rank([{_,a}, {_,a}, {_,a}, {_,a}, {_,a}]), do: 6

  # straight
  def hand_rank([{a,_}, {b,_}, {c,_}, {d,_}, {e,_}]) when a == (b+1) and b == (c+1) and c == (d+1) and d == (e+1), do: 5
  def hand_rank([{a,_}, {b,_}, {c,_}, {d,_}, {e,_}]) when a == 14 and b == 5 and b == (c+1) and c == (d+1) and d == (e+1), do: 5

  # three_of_a_kind
  def hand_rank([{a,_}, {a,_}, {a,_}, {_,_}, {_,_}]), do: 4 
  def hand_rank([{_,_}, {a,_}, {a,_}, {a,_}, {_,_}]), do: 4 
  def hand_rank([{_,_}, {_,_}, {a,_}, {a,_}, {a,_}]), do: 4 

  # two_pair
  def hand_rank([{a,_}, {a,_}, {b,_}, {b,_}, {_,_}]), do: 3 
  def hand_rank([{a,_}, {a,_}, {_,_}, {b,_}, {b,_}]), do: 3 

  # one_pair
  def hand_rank([{a,_}, {a,_}, {_,_}, {_,_}, {_,_}]), do: 2
  def hand_rank([{_,_}, {a,_}, {a,_}, {_,_}, {_,_}]), do: 2
  def hand_rank([{_,_}, {_,_}, {a,_}, {a,_}, {_,_}]), do: 2
  def hand_rank([{_,_}, {_,_}, {_,_}, {a,_}, {a,_}]), do: 2

  # high card
  def hand_rank(_), do: 1

  def name_hand(hand), do: name_hand_rank(hand_rank(hand))
  def name_hand_rank(rank) when rank == 9, do: :straight_flush
  def name_hand_rank(rank) when rank == 8, do: :four_of_a_kind
  def name_hand_rank(rank) when rank == 7, do: :full_house
  def name_hand_rank(rank) when rank == 6, do: :flush
  def name_hand_rank(rank) when rank == 5, do: :straight
  def name_hand_rank(rank) when rank == 4, do: :three_of_a_kind
  def name_hand_rank(rank) when rank == 3, do: :two_pair
  def name_hand_rank(rank) when rank == 2, do: :pair
  def name_hand_rank(_), do: :high_card


  def declares_defeats(winner, hand2), do: _declares_defeats({winner, hand_rank(winner)}, {hand2,hand_rank(hand2)})
  def _declares_defeats({_, winner_rank}, {_, hand2_rank}) when winner_rank > hand2_rank, do: true
  def _declares_defeats({winner, _}, {hand2, _}), do: compare_kickers(winner, hand2)

  def compare_kickers([ {card1_value,_} | _ ], [ {card2_value,_} | _ ]) when card1_value > card2_value , do: true
  def compare_kickers([ _ | rest_of_hand1 ], [ _ | rest_of_hand2 ]), do: compare_kickers(rest_of_hand1, rest_of_hand2)
  def compare_kickers([], []), do: false
end
