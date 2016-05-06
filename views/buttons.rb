module View
  class Button
    def self.confirm(doc, value:)
      doc.div :class => "form-group" do
        doc.div :class => "col-sm-10" do
          doc.input :type => "submit", :class => "btn btn-success", :value => value
        end
      end
    end

    def self.confirm_form(doc, value:)
      doc.div :class => "form-group" do
        doc.div :class => "col-sm-offset-2 col-sm-10" do
          doc.input :type => "submit", :class => "btn btn-success", :value => value        end
      end
    end

    def self.go_back(doc)
      doc.input :type => "submit", :class => "btn btn-danger", :value => "Go back", :onClick => "history.go(-1);return true"

    end

    def self.number_players(doc, players_number:)
      doc.div :class => "form-group" do
        doc.label "Number of players:", :class => "col-sm-2 control-label", :style => "padding-top:6px"
        doc.div :class => "col-sm-10" do

          players_number.times do |i|
            doc.div :class => "col-md-3" do
              doc.div :class => "panel panel-default" do

                doc.div :class => "panel-heading", :style => "display:flex; align-items:center; justify-content:center" do
                  doc.div :class => "panel-title" do
                    doc.h4 "#{i + 1} player#{i == 0 ? "" : "s"}"
                    doc.label :class => "radio-inline", :style => "display:flex; align-items:center; justify-content:center; padding-bottom:3rem" do
                      doc.input :type => "radio", :name => "optradio", :value => "#{i + 1}"
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
