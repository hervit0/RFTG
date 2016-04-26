class Display
  def self.hand(doc, hand, discard_parameter:)
    doc.div :class => "row", :style => "display: inline" do
      hand.map.with_index do |card, i|
        panel(doc, card, i, discard: discard_parameter)
      end
    end
  end
end

def display_card(doc, card)
  mapping = ["name", "cost", "victory_points"]
  mapping.map do |x|
    doc.ul :class => "list-group" do
      doc.li :class => "list-group-item" do
        doc.text "#{x.capitalize.gsub("_", " ")}:"
        doc.span :class => "badge" do
          doc.text card[x]
        end
      end
    end
  end
end

def panel(doc, card, i, discard:)
  doc.div :class => "col-md-4" do
    doc.div :class => "panel panel-primary", :style => "max-width:400px" do
      doc.div :class => "panel-heading" do
        doc.div :class => "panel-title" do
          doc.h3 "Card #{i + 1}", :style => "margin-top:0px; margin-bottom:0px"
        end
      end
      doc.div :class => "panel-body" do
        display_card(doc, card)
        if discard == "enabled"
          doc.label :class => "checkbox-inline" do
            doc.input :type => "checkbox", :name => "checkbox#{i + 1}", :value => "#{i + 1}"
            doc.p "Discard card #{i + 1}"
          end
        end
      end
    end
  end
end
