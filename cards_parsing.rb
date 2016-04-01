require 'yaml'

line = File.readlines("cards.txt").map{ |n| n.chomp }

card_boundaries = [-1] + line.map.with_index{ |x, i| x == "" ? i : nil}.compact + [line.length]

def new_card(cards, first_property_index, last_property_index)
  new_card = cards.select.with_index do |_,i|
    (i > first_property_index) && (i < last_property_index)
  end
  
	new_card.map do |property|
		if property[0..1] == "T:"
			property = [
				["T:" + (property[2] == "1" ? "world" : "development")],
				["C:" + property[4]],
				["Y:" + property[6]]
			]
		else
			property
  	end
	end.flatten
end

boundary_pairs = card_boundaries.zip(card_boundaries.drop(1))[0..-2]
cards = boundary_pairs.map do |first, last|
  new_card(line, first, last)
end

MAPPING = {
  "N:" => "name",
  "T:" => "type",
	"C:" => "cost",
	"Y:" => "victory_points",
  "E:" => "extension",
  "G:" => "goodtype",
  "F:" => "flags",
  "P:" => "phases",
  "V:" => "values"
}

def properties(card)
  card.reduce({}) do |acc, property|
    first_two_letters = property[0..1]
    key = MAPPING[first_two_letters]
#    if first_two_letters == "T:"
#      type_properties =  property.split(":").drop(1)#.each_with_index{ |x,i| acc.merge(MAPPING_TYPE[i] => x)}
#      MAPPING_TYPE.length.times do |x|
#				acc.merge(MAPPING_TYPE[x] = type_properties[x])
#      end    
#    else
		if (first_two_letters == "C:") || (first_two_letters == "Y:")
			acc.merge(key => property.split(first_two_letters).reject(&:empty?)[0].to_i)
		else 
			acc.merge(key => property.split(first_two_letters).reject(&:empty?)[0])
    end
  end
end

def detailed_type_property(type_property)
  type_property["type"].split(":").map.with_index do |x,i|
    key = MAPPING_TYPE[i]
    if i == 0
      x == "1" ? {key => "world"} : {key => "development"}
    else
      {key => x}
    end
  end
end

cards_with_properties = cards.map{ |x| properties(x) }
#p cards_with_properties.class#.values_at("type")
cards_development = cards_with_properties.map do |x|
	if x.values_at("type")[0] == "development" 
		x.reject{ |key, value| (key == "type") || (key == "extension") || (key == "goodtype") || (key == "flags") || (key == "phases") || (key == "values") }
	end	
end.compact

p cards_development
#p cards_development[0].reject{|k,v| (k == "extension") || (k == "phases") }

cards_development_yaml = File.write("cards.yml", cards_development.to_yaml)

# KEEP THESE LINES FOR FUTUR:
#cards_with_properties = cards.map{ |x| properties(x) }
#cards_with_properties_yaml = File.write("RFTG_cards.yml", cards_with_properties.to_yaml)
