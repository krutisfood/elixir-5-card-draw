defmodule DealerTest do
  use ExUnit.Case

  test "the deck has 52 cards in total" do
    assert Enum.count(Dealer.deck) == 52
  end

  test "all 52 cards are unique" do
    unique_cards = Enum.uniq(Dealer.deck)
    assert Enum.count(unique_cards) == Enum.count(Dealer.deck)
  end
end
