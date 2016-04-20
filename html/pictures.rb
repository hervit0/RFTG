class Picture
  def self.alien(doc)
    doc.img :class => "img-thumbnail", :style => "width:auto; height:auto; max-width:300px", :src => 'http://i.livescience.com/images/i/000/049/468/original/aliens-ET.jpg'
  end

  def self.presentation(doc)
    doc.img :class => 'img-thumbnail', :style => "width: auto; height: auto; max-height: 300px", :src => "https://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Rftg_cover.jpg/220px-Rftg_cover.jpg"
  end

  def self.rules(doc)
    doc.img :class => "img-thumbnail", :style => "width:auto; height:auto; maxheight: 100px", :src => "http://breathingmeansmore.com/wp-content/uploads/2015/03/rules.png"
  end
end
