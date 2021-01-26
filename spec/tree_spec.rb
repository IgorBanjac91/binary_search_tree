require 'spec_helper'
require_relative '../tree'
require 'coderay'

RSpec.describe Tree do 

  let(:tree) { Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }
  let(:tree_one_node) { Tree.new([3]) }

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

    context "with only one node" do 
      it 'shold create a one node tree' do 
        expect { tree_one_node }.to_not raise_exception
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

  context 'Binary tree search traversal - Breadth-first , - Depth-first' do 
    describe '#level_order' do 
      it 'returns an array of node values traversing the tree in breadth-first level order' do 
        expect(tree.level_order).to eq([5, 2, 7, 1, 3, 6, 8, 4, 9])
      end

      it 'reutrns an array with a singol element if the tree has one node' do 
        expect(tree_one_node.level_order).to eq([3])
      end
    end

    describe '#preorder' do 
      it 'returns an arrray with the values of each node depth traversal preordered' do 
        expect(tree.preorder).to eq([5, 2, 1, 3, 4, 7, 6, 8, 9])
      end
    end

    describe '#inorder' do 
      it 'returns an arrray with the values of each node depth traversal inordered' do 
        expect(tree.inorder).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end

    describe '#postorder' do 
      it 'returns an arrray with the values of each node depth traversal postordered' do 
        expect(tree.postorder).to eq([1, 4, 3, 2, 6, 9, 8, 7, 5])
      end
    end
  end

  describe '#height' do # Its the number of edges from a node to a farest leaf
    it 'returns the height of the root node' do 
      expect(tree.height(5)).to eq(3)
    end

    it 'returns zero if the node is a leaf node' do 
      expect(tree.height(4)).to eq(0)
    end

    it 'returns the height of a node' do 
      expect(tree.height(3)).to eq(1)
    end
  end

  describe '#depth' do #Its the number of edges form a given node to the root
    it 'returns 0 if the node is the root' do 
      expect(tree.depth(5)).to eq(0)
    end
    
    it 'returns the depth that is the same as the height of the farest leaf' do 
      expect(tree.depth(4)).to eq(tree.height(5))
    end
    
    it 'returns the depth of a middle node' do 
      expect(tree.depth(3)).to eq(2)
    end

    it 'returns string that says that there is no elment in the binary tree' do
      expect(tree.depth(22)).to eq("No node found with the given value 22")
    end
  end

  describe '#balanced?' do
    it 'returns true if the tree is balanced' do 
      expect(tree.balanced?).to be true
    end

    it 'returns false if the tree is unbalanced' do 
      tree.insert(10)
      tree.insert(11)
      tree.insert(12)
      tree.insert(13)
      expect(tree.balanced?).to be false
    end
  end
end