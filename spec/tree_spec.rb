require 'spec_helper'
require_relative '../tree'

RSpec.describe Tree do 

  let(:tree) { Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

  context "creation of a Tree" do 
    context "without an argument" do 
      it 'returns a nil root' do 
        tree = Tree.new()
        expect(tree.root).to be_nil
      end
    end

    context "with an argument" do 
      it "return a Node object for the root value" do 
        tree
        expect(tree.root).to be_an_instance_of(Node)
      end
    end
  end

  describe '#delete' do 
    context 'when the node to delete has no childeren' do 
      it 'deletes the node without rearenging the tree' do 
        pending
      end
    end
  end
end