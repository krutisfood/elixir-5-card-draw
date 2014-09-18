defmodule DealerTest do
  use ExUnit.Case

  test "the deck has 52 cards in total" do
    assert Enum.count(Dealer.deck) == 52
  end

  test "all 52 cards are unique" do
    unique_cards = Enum.uniq(Dealer.deck)
    assert Enum.count(unique_cards) == Enum.count(Dealer.deck)
  end

  test "name of straight flush matches royal flush" do
    royal_flush = [{14,:hearts},{13,:hearts},{12,:hearts},{11,:hearts},{10,:hearts}]
    assert Dealer.name_hand(royal_flush) == :straight_flush
  end

  test "name of normal straight is not straight flush" do
    straight = [{14,:hearts},{13,:clubs},{12,:hearts},{11,:hearts},{10,:hearts}]
    refute Dealer.name_hand(straight) == :straight_flush
  end

  test "normal flush is not straight flush" do
    straight = [{2,:hearts},{13,:hearts},{12,:hearts},{11,:hearts},{10,:hearts}]
    refute Dealer.name_hand(straight) == :straight_flush
  end

  test "names low straight flush correctly" do 
    low_straight_flush = [{14,:hearts},{5,:hearts},{4,:hearts},{3,:hearts},{2,:hearts}]
    assert Dealer.name_hand(low_straight_flush) == :straight_flush
  end

  test "names four of a kind" do
    four_of_a_kind = [{14,:hearts},{14,:clubs},{14,:spades},{14,:diamonds},{2,:hearts}]
    assert Dealer.name_hand(four_of_a_kind) == :four_of_a_kind
  end

  test "names aces full of kings a full house" do
    aces_full_of_kings = [{14,:hearts},{14,:clubs},{14,:spades},{13,:diamonds},{13,:hearts}]
    assert Dealer.name_hand(aces_full_of_kings) == :full_house
  end

  test "names kings full of aces a full house" do
    aces_full_of_kings = [{14,:hearts},{14,:clubs},{13,:spades},{13,:diamonds},{13,:hearts}]
    assert Dealer.name_hand(aces_full_of_kings) == :full_house
  end

  test "names hand full of hearts as flush" do
    heart_flush = [{14,:hearts},{8,:hearts},{5,:hearts},{3,:hearts},{1,:hearts}]
    assert Dealer.name_hand(heart_flush) == :flush
  end

  # Test some draws
  test "ace high flush beats jack high flush" do
    ace_high_flush = [{14,:hearts},{8,:hearts},{5,:hearts},{3,:hearts},{1,:hearts}]
    jack_high_flush = [{11,:clubs},{8,:clubs},{5,:clubs},{3,:clubs},{1,:clubs}]
    assert ace_high_flush |> Dealer.says_beats jack_high_flush
  end

  # Test some draws
  test "eight high flush does not beat jack high flush" do
    eight_high_flush = [{8,:hearts},{7,:hearts},{5,:hearts},{3,:hearts},{1,:hearts}]
    jack_high_flush = [{11,:clubs},{8,:clubs},{5,:clubs},{3,:clubs},{1,:clubs}]
    refute eight_high_flush |> Dealer.says_beats jack_high_flush
  end


  # Test dealing
  test "deal six players returns six hands of five cards" do
    six_players = 6
    no_cards_required = six_players * 5
    #deck = fake_deck
    deck = Dealer.deck |> Enum.shuffle

    dealt_hands = Dealer.deal(six_players, deck)

    for hand <- dealt_hands do
      assert Enum.count(hand) == 5
    end

    # Couldn't get this working
    #has_five_cards? = fn(hand) ->
      #assert Enum.count(hand) == 5
    #end
    #dealt_hands |> Enum.all?(has_five_cards?/2)

    number_of_hands = dealt_hands |> Enum.count
    assert number_of_hands == six_players
  end
end
