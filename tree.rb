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
            node_to_remove = root.right
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
          node_to_remove.value = cont.value
          until subs.right.value == elm
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

  def insert(value, root = @root)
    if value > root.value
      if root.right.nil?
        return root.right = Node.new(value: value)
      end
      insert(value, root.right)
    else
      if root.left.nil?
        return root.left = Node.new(value: value)
      end
      insert(value, root.left)
    end
  end

  def find(value, root = @root)
    return root if root.value == value
    if value > root.value
      return "No node found with the given value #{value}" if root.right.nil?
      find(value, root.right)
    else
      return "No node found with the given value #{value}" if root.left.nil?
      find(value, root.left)
    end
  end

  def level_order(root = @root, arr = [], queue = [@root])
    until queue.empty?
      root = queue.shift
      arr << root.value
      unless root.left.nil?
        queue << root.left
      end
      unless root.right.nil?
        queue << root.right
      end
    end
    arr 
  end

  def preorder(root = @root, arr = [])
    arr << root.value
    if root.left.nil?
      if root.right
        preorder(root.right, arr)
      end
      return arr
    end
    preorder(root.left, arr)
    preorder(root.right, arr)
  end

  def inorder(root = @root, arr = [])
    if root.left.nil?
      arr << root.value
      if root.right
        inorder(root.right, arr)
      end
      return arr
    end
    inorder(root.left, arr)
    arr << root.value
    inorder(root.right, arr)
  end

  def postorder(root = @root, arr = [])
    if root.left.nil?
      if root.right
        postorder(root.right, arr)
      end
      return arr << root.value
    end
    postorder(root.left, arr)
    postorder(root.right, arr)
    arr << root.value
  end

  def height(value, count = 0)
    node = find(value)
    if node.left.nil? && node.right.nil?
      return count 
    end
    if node.right.nil?
      height(node.left.value, count += 1)
    elsif node.left.nil?
      height(node.right.value, count += 1)
    else 
      count += 1
      [height(node.left.value, count), height(node.right.value, count)].max
    end
  end

  def depth(value, root = @root, count = 0)
    return find(value) unless find(value).instance_of? Node
    return count if root.value == value
    value > root.value ? depth(value, root.right, count += 1 ) : depth(value, root.left, count += 1)
  end

  def balanced?(root = @root)
    unless root.left.nil? && root.right.nil?
      return false unless (height(root.left.value) - height(root.right.value)).abs <= 1
      if root.right.nil? && root.left
        balanced?(root.left)
      end
      if root.left.nil? && root.right
        balanced?(root.right)
      end
    end
    return true
  end

  def rebalance
    lev_ord_arr = level_order
    @root = build_tree(lev_ord_arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end


new_tree = Tree.new(Array.new(15) { rand(1..100) })

puts "-----------------------\n\n\n"
new_tree.pretty_print
puts "\n\n-----------------------"

p new_tree.balanced?

p "Level order:  #{new_tree.level_order}"
p "Pre-order:    #{new_tree.preorder}"
p "Post-order:   #{new_tree.postorder}"
p "In-order:     #{new_tree.inorder}"

new_tree.insert(111)
new_tree.insert(112)
new_tree.insert(113)
new_tree.insert(114)
new_tree.insert(115)

p new_tree.balanced?

new_tree.rebalance

p new_tree.balanced?

p "Level order:  #{new_tree.level_order}"
p "Pre-order:    #{new_tree.preorder}"
p "Post-order:   #{new_tree.postorder}"
p "In-order:     #{new_tree.inorder}"

puts "-----------------------\n\n\n"
new_tree.pretty_print
puts "\n\n-----------------------"