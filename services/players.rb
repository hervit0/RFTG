class Players
  def self.number(request)
    request.POST.values.first.to_i
  end

  def self.names(request)
    names = request.POST.to_a.map do |x|
      {"name" => x[1], "status" => :not_discarded}
    end
    File.write("names.yml", names.to_yaml)
  end

  def self.present
    player_index, player_name = next_player
  end

  def self.discard
    player_index, player_name, names = next_player
    new_names = names.map.with_index do |x, i|
      i == player_index ? x.merge("status" => :discarded) : x
    end
    File.write("names.yml", new_names.to_yaml)

    action = if names.map{ |x| x["status"] }.count(:not_discarded) == 1
               "choose_phases"
             else
               "present_player"
             end
    [action, player_name]
  end
end

def next_player
  names = YAML.load(File.read("names.yml"))
  status = names.map{ |x| x["status"] }
  player_index = status.index(:not_discarded)
  player_name = names[player_index]["name"]
  [player_index, player_name, names]
end

