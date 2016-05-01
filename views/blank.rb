require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

module View
  class Blank
    def self.show
      blank = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "")
            doc.meta "http-equiv" => "refresh", "content" => "0"
          end

          doc.body View::Setting.body  do
            View::Setting.main_navbar(doc)
            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "", body: "")
            end
          end
        end
      end
      [blank.to_html]
    end
  end
end
