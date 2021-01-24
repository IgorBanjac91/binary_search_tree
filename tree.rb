require './node'
require 'pp'

class Tree
  attr_accessor :root
  def initialize(array = nil)
    @root = build_tree(array)
  end

  def build_tree(arr)
    return nil if arr.nil?
    arr.sort!.uniq!
    return Node.new(value: arr[0]) if arr.size == 1
    if arr.size == 2
     return Node.new( value: arr[0], left: nil, right: Node.new(value: arr[1]) )
    end
    middle = (arr.size + 1)/2 - 1
    left  = arr[0..middle -1]
    right = arr[middle + 1..-1]
    Node.new( value: arr[middle], left: build_tree(left), right: build_tree(right) )
  end

  def delete(elm, root = @root)
    if elm > root.value || elm == root.value
      if root.right.value == elm || root.value == elm
        if root.right.right && root.right.left
         
        elsif root.right.right.nil? && root.right.left
          return root.right = root.right.left
        elsif root.right.right && root.right.left.nil?
          return root.right = root.right.right
        else
          return root.right = nil
        end
      end
      delete(elm, root.right)
    else
      if root.left.value == elm 
        if root.left.right && root.left.left

        elsif root.left.right.nil? && root.left.left
          return root.left = root.left.left
        elsif root.left.right && root.left.left.nil?
          return root.left = root.left.right
        else
          return root.left = nil
        end
      end
      delete(elm, root.left)
    end
  end

  def insert

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

tree.delete(2)

puts "-----------------------\n\n\n"
tree.pretty_print
puts "\n\n-----------------------"



