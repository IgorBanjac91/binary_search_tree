require 'spec_helper'
require_relative '../node'

RSpec.describe Node do 
  context '#initialzie' do 
    context  'when not specified' do 
      it 'creates a node with left, right and value set to nil' do
        node = Node.new
        expect(node).to have_attributes(left: nil, right: nil, value: nil)
      end
    end

    context 'when is specified' do 
      it 'sets each left and right with a Node object' do 
        input = { left:  Node.new,
                  right: Node.new }
        node = Node.new(input)
        expect(node).to have_attributes( left:  be_an_instance_of(Node), 
                                        right: be_an_instance_of(Node), 
                                        value: be_nil)
      end
    end
  end
end
