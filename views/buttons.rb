module View
  class Button
    def self.confirm(doc, value:)
      doc.div :class => "form-group" do
        doc.div :class => "col-sm-10" do
          doc.input :type => "submit", :class => "btn btn-default", :value => value
        end
      end
    end

    def self.confirm_form(doc, value:)
      doc.div :class => "form-group" do
        doc.div :class => "col-sm-offset-2 col-sm-10" do
          doc.input :type => "submit", :class => "btn btn-default", :value => value
        end
      end
    end
  end
end
