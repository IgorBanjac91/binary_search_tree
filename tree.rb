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
          if root.value == elm
            node_to_remove = root
            cont = root
            subs = root
          else
            node_to_remove = root.right   #later do the case when the elm is = to the root
            cont = root.right
            subs = root.right
          end

          until cont.left.nil?
            if cont.left.value > node_to_remove.value
              cont = cont.left
            else
              cont = cont.right
            end
          end 
          p node_to_remove.value
          p cont.value
          node_to_remove.value = cont.value
          p subs.right.value 
          until subs.right.value == elm
            p subs.right.left
            if subs.right.left.value == cont.value
              subs.right.left = nil
              return
            end
            subs = subs.right
          end
          return subs.right = cont.right
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
          value = root.left
          cont = root.left
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

tree.delete(5)

puts "-----------------------\n\n\n"
tree.pretty_print
puts "\n\n-----------------------"


tree_1 = Tree.new([1, 2, 3, 4, 6, 7, 8, 9])

puts "-----------------------\n\n\n"
tree_1.pretty_print
puts "\n\n-----------------------"
