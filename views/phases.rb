require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

class Phase
  def self.choose
    choose = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Choose")
        end

        doc.body Setting.body  do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "Plan for battle ?", body: "Choose your action for the next turn.")

            Setting.title_h2(doc, "Actions to perform")
            actions = ["Explore", "Develop", "Settle", "Consume", "Produce"]
            doc.div :class => "btn-group", "data-toggle" => "buttons" do
              actions.map do |x|
                doc.div :class => "col-md-9" do
                  doc.label :class => "btn btn-default" do
                    doc.h5 "#{x}"
                    doc.input :type => "radio", :name => "options", :id => "#{x}", :autocomplete => "off"
                  end
                end
              end
            end

            Setting.title_h2(doc, "Your hand")
            Setting.title_h2(doc, "Your tableau")

          end
        end
      end
    end
    [choose.to_html]
  end
end
