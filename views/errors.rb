require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

module View
  class Error
    def self.badrequest(message)
      error = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "RFTG - Errors")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)
            doc.div Setting.container do
              Setting.jumbotron(doc, head: "Bad request !", body: message)
              Button.go_back(doc)
              Picture.error(doc)
            end
          end
        end
      end
      [error.to_html]
    end
  end
end
