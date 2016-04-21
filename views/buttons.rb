class Button
  def self.confirm(doc, value:)
    doc.input :type => "submit", :class => "btn btn-lg btn-primary", :value => value
  end
end
