class Picture
  def self.alien(doc)
    doc.img :class => "img-thumbnail", :style => standard_size, :src => 'http://i.livescience.com/images/i/000/049/468/original/aliens-ET.jpg'
  end

  def self.presentation(doc)
    doc.img :class => 'img-thumbnail', :style => standard_size, :src => "https://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Rftg_cover.jpg/220px-Rftg_cover.jpg"
  end

  def self.rules(doc)
    doc.img :class => "img-thumbnail", :style => standard_size, :src => "http://breathingmeansmore.com/wp-content/uploads/2015/03/rules.png"
  end
end

def standard_size
  "width:auto; height:auto; max-width:200px; display:block; margin-left:auto; margin-right:auto"
end
