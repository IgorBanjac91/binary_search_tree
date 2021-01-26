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
      return "No node found with the give value #{value}" if root.right.nil?
      find(value, root.right)
    else
      return "No node found with the give value #{value}" if root.left.nil?
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


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9])


puts "-----------------------\n\n\n"
tree.pretty_print
puts "\n\n-----------------------"


p tree.height(9)


# tree_1 = Tree.new([1, 2, 3, 4, 6, 7, 8, 9])

# puts "-----------------------\n\n\n"
# tree_1.pretty_print
# puts "\n\n-----------------------"
