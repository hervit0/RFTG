require_relative 'welcome.rb'
require_relative 'names.rb'
require_relative 'discard.rb'

class Body
  attr_reader :env
  def initialize(env)
    @env = env
  end

  def select

  end
end
