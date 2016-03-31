require 'yaml'

STACK = YAML.load(File.read("RFTG_cards.yml"))
NUMBER_PLAYERS = 2

def distribute_cards(cards, number_players)
	hands_players = cards.sample(number_players * 6).each_slice(6).to_a
	stack_after_distribution = cards - hands_players.flatten
	[hands_players, stack_after_distribution]
end

#distribute_cards(STACK, NUMBER_PLAYERS)
