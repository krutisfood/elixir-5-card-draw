defmodule DealerTest do
  use ExUnit.Case

  # Test Deck
  test "the deck has 52 cards in total" do
    assert Enum.count(Dealer.deck) == 52
  end

  test "all 52 cards are unique" do
    unique_cards = Enum.uniq(Dealer.deck)
    assert Enum.count(unique_cards) == Enum.count(Dealer.deck)
  end

  # Test hand names
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

  test "names a series of consecutive numbers with different suits a straight" do
    straight = [{14,:hearts},{13,:clubs},{12,:hearts},{11,:hearts},{10,:hearts}]
    assert Dealer.name_hand(straight) == :straight
  end

  test "names an ace low series of consecutive numbers with different suits a straight" do
    ace_low_straight = [{14,:hearts},{5,:spades},{4,:hearts},{3,:hearts},{2,:hearts}]
    assert Dealer.name_hand(ace_low_straight) == :straight
  end

  test "names a hand with first three cards the same value three of a kind" do
    three_of_a_kind = [{14,:hearts},{14,:spades},{14,:clubs},{3,:hearts},{2,:hearts}]
    assert Dealer.name_hand(three_of_a_kind) == :three_of_a_kind
  end

  test "names a hand with second third and fourth cards the same value three of a kind" do
    three_of_a_kind = [{14,:hearts},{11,:spades},{11,:clubs},{11,:hearts},{2,:hearts}]
    assert Dealer.name_hand(three_of_a_kind) == :three_of_a_kind
  end

  test "names a hand with third, fourth and fifth cards the same value three of a kind" do
    three_of_a_kind = [{14,:hearts},{12,:spades},{11,:clubs},{11,:hearts},{11,:spades}]
    assert Dealer.name_hand(three_of_a_kind) == :three_of_a_kind
  end

  test "names a hand with first two cards one value and second two cards another two pair" do
    two_pair = [{14,:hearts},{14,:spades},{12,:clubs},{12,:hearts},{2,:hearts}]
    assert Dealer.name_hand(two_pair) == :two_pair
  end

  test "names a hand with first two cards one value and last two cards another two pair" do
    two_pair = [{14,:hearts},{14,:spades},{13,:clubs},{12,:hearts},{12,:spades}]
    assert Dealer.name_hand(two_pair) == :two_pair
  end

  test "names a hand with first two cards the same a pair" do
    pair = [{14,:hearts},{14,:spades},{13,:clubs},{12,:hearts},{1,:spades}]
    assert Dealer.name_hand(pair) == :pair
  end

  test "names a hand with second and third cards the same value as a pair" do
    pair = [{14,:hearts},{13,:spades},{13,:clubs},{12,:hearts},{1,:spades}]
    assert Dealer.name_hand(pair) == :pair
  end

  test "names a hand with third and fourth cards the same value as a pair" do
    pair = [{14,:hearts},{13,:spades},{12,:clubs},{12,:hearts},{1,:spades}]
    assert Dealer.name_hand(pair) == :pair
  end

  test "names a hand with fourth and fifth cards the same value as a pair" do
    pair = [{14,:hearts},{13,:spades},{12,:clubs},{1,:hearts},{1,:spades}]
    assert Dealer.name_hand(pair) == :pair
  end


  # Test hand rank comparison
  test "jack high straight flush beats ace high flush" do
    jack_high_straight_flush = [{11,:clubs},{10,:clubs},{9,:clubs},{8,:clubs},{7,:clubs}]
    ace_high_flush = [{14,:hearts},{13,:hearts},{12,:hearts},{11,:hearts},{6,:hearts}]
    assert jack_high_straight_flush |> Dealer.declares_defeats ace_high_flush
  end

  test "jack high straight flush beats aces full of kings " do
    jack_high_straight_flush = [{11,:clubs},{10,:clubs},{9,:clubs},{8,:clubs},{7,:clubs}]
    aces_full_of_kings = [{14,:hearts},{14,:clubs},{14,:spades},{13,:diamonds},{13,:hearts}]
    assert jack_high_straight_flush |> Dealer.declares_defeats aces_full_of_kings
  end

  test "jack high flush beats ace high straight" do
    ace_high_straight = [{14,:hearts},{13,:clubs},{12,:hearts},{11,:hearts},{10,:hearts}]
    jack_high_flush = [{11,:clubs},{8,:clubs},{5,:clubs},{3,:clubs},{1,:clubs}]
    assert jack_high_flush |> Dealer.declares_defeats ace_high_straight
  end

  test "ace high straight beats three of a kind" do
    ace_high_straight = [{14,:hearts},{13,:clubs},{12,:hearts},{11,:hearts},{10,:hearts}]
    three_of_a_kind = [{11,:clubs},{11,:spades},{11,:hearts},{3,:clubs},{1,:clubs}]
    assert ace_high_straight |> Dealer.declares_defeats three_of_a_kind
  end


  # Test some comparisons where hands have same rank, e.g. flush vs flush
  test "ace high flush beats jack high flush" do
    ace_high_flush = [{14,:hearts},{8,:hearts},{5,:hearts},{3,:hearts},{1,:hearts}]
    jack_high_flush = [{11,:clubs},{8,:clubs},{5,:clubs},{3,:clubs},{1,:clubs}]
    assert ace_high_flush |> Dealer.declares_defeats jack_high_flush
  end

  test "eight high flush does not beat jack high flush" do
    eight_high_flush = [{8,:hearts},{7,:hearts},{5,:hearts},{3,:hearts},{1,:hearts}]
    jack_high_flush = [{11,:clubs},{8,:clubs},{5,:clubs},{3,:clubs},{1,:clubs}]
    refute eight_high_flush |> Dealer.declares_defeats jack_high_flush
  end

  test "aces and twos beats jacks and tens" do
    aces_and_twos = [{14,:hearts},{14,:spades},{5,:hearts},{2,:hearts},{2,:clubs}]
    jacks_and_tens = [{11,:hearts},{11,:hearts},{10,:hearts},{10,:clubs},{1,:hearts}]
    assert aces_and_twos |> Dealer.declares_defeats jacks_and_tens
  end
   
  test "aces low straight is defeated by seven high straight" do
    ace_low_straight = [{14,:hearts},{5,:spades},{4,:hearts},{3,:hearts},{2,:clubs}]
    seven_high_straight = [{7,:hearts},{6,:hearts},{5,:hearts},{4,:clubs},{3,:spades}]
    refute ace_low_straight  |> Dealer.declares_defeats seven_high_straight
  end

  test "aces low straight flush is defeated by seven high straight flush" do
    ace_low_straight_flush = [{14,:hearts},{5,:spades},{4,:hearts},{3,:hearts},{2,:clubs}]
    seven_high_straight_flush = [{7,:hearts},{6,:hearts},{5,:hearts},{4,:clubs},{3,:spades}]
    refute ace_low_straight_flush |> Dealer.declares_defeats seven_high_straight_flush
  end



  # Test some draws
  test "equivalent two pair hands equal" do
    hand1 = [{14,:hearts},{14,:spades},{5,:hearts},{2,:hearts},{2,:clubs}]
    hand2 = [{14,:clubs},{14,:diamonds},{5,:clubs},{2,:diamonds},{2,:spades}]
    refute hand1 |> Dealer.declares_defeats hand2 
    refute hand2 |> Dealer.declares_defeats hand1
  end


  # Test dealing
  test "deal six players returns six hands of five cards" do
    six_players = 6
    #deck = fake_deck
    deck = Dealer.deck |> Enum.shuffle

    dealt_hands = Dealer.deal(six_players, deck)

    for hand <- dealt_hands do
      assert Enum.count(hand) == 5
    end

    number_of_hands = dealt_hands |> Enum.count
    assert number_of_hands == six_players
  end

  # Test dealing
  test "deal four players returns four hands of five cards" do
    four_players = 4
    #deck = fake_deck
    deck = Dealer.deck |> Enum.shuffle

    dealt_hands = Dealer.deal(four_players, deck)

    for hand <- dealt_hands do
      assert Enum.count(hand) == 5
    end

    number_of_hands = dealt_hands |> Enum.count
    assert number_of_hands == four_players
  end
end
