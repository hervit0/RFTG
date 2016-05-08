require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

module View
  class Phase
    def self.choose
      choose = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "RFTG - Choose")
          end

          doc.body View::Setting.body  do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "Plan for battle ?", body: "Choose your action for the next turn.")

            end
          end
        end
      end
      [choose.to_html]
    end
  end
end
