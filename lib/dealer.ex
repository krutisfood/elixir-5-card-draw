defmodule Dealer do

  def deck do
    values = Stream.cycle(2..14) |> Enum.take 52
    suits = Stream.cycle([:hearts,:diamonds,:spades,:clubs]) |> Enum.take 52
    deck = values |> Enum.zip suits
  end

  def deal_one_from(deck) do
    deck |> Enum.take 1
  end

  def deal_hands(no_players, deck) do
    deal_one_from deck
    # terminate when all plays have seven cards...
  end
end
