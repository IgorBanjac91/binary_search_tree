class Node
  include Comparable
  attr_accessor :left, :value, :right
  
  def <=>(other)
    
  end
  
  def initialize(input = {})
    @left = input.fetch(:left, nil)
    @right = input.fetch(:right, nil)
    @value = input.fetch(:value, nil)
  end
end