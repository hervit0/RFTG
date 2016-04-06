require 'minitest/autorun'
require_relative 'stack.rb'

class StackTest < Minitest::Test
  def test_from_cards
    card1 = {"name"=>"Card 1", "quantity"=>1, "cost"=>0, "victory_points"=>1 }
    card2 = {"name"=>"Card 2", "quantity"=>2, "cost"=>0, "victory_points"=>1 }
    card3 = {"name"=>"Card 3", "quantity"=>1, "cost"=>2, "victory_points"=>3 }
    cards = [card1, card2, card3]

    stack = Stack.from_cards(cards)

    assert_equal "Card 3", stack.cards[3].name
    assert_equal 2, stack.cards[3].cost
    assert_equal 3, stack.cards[3].victory_points
    assert_equal 2, stack.cards.map{ |x| x.name }.count("Card 2")
    assert_equal 4, stack.cards.length
  end

  def test_draw
    card1 = Card.new(name: "card 1", id: 1, cost: 1, victory_points: 1)
    card2 = Card.new(name: "card 2", id: 2, cost: 1, victory_points: 1)
    card3 = Card.new(name: "card 3", id: 3, cost: 1, victory_points: 1)
    card4 = Card.new(name: "card 4", id: 4, cost: 1, victory_points: 1)
    cards = [card1, card2, card3, card4]

    stack = Stack.new(cards)

    new_stack1, drawn_cards1 = stack.draw(0)
    assert_equal [card1, card2, card3, card4], new_stack1.cards

    new_stack2, drawn_cards2 = stack.draw(4)
    assert_equal [], new_stack2.cards
  end
end
