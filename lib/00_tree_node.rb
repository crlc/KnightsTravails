require 'byebug'
class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(new_parent)
    if new_parent != nil
      @parent.children.delete(self) if @parent != nil
      @parent = new_parent
      new_parent.children << self unless new_parent.children.include?(self)
    else
      @parent.children.delete(self) if @parent != nil
      @parent = nil
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if self.children.include?(child)
      child.parent = nil
    else
      raise puts "That wasn't my child to begin with."
    end
  end

  def dfs(target_value)
    #debugger
    return self if target_value == @value
    node = nil
    children.each do |child|
      node = child.dfs(target_value)
      break unless node.nil?
    end

    node
  end


  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      if node.value == target_value
        break
      else
        node.children.each { |child| queue << child }
      end
      node = nil if queue.empty?
    end

    node
  end

end

 # n1 = PolyTreeNode.new("root1")
 # n2 = PolyTreeNode.new("root2")
 # n3 = PolyTreeNode.new("root3")
 #
 # n1.parent = n2
 # n2.parent = n3
 #
 # n3.dfs(n3.value)
