require_relative '00_tree_node.rb'

class KnightPathFinder
  attr_reader :root_node

  KNIGHT_POS = [
    [1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-1, 2],
    [-1, -2],
    [-2, 1],
    [-2, -1]
  ]
  def initialize(position)
    @starting_position = position
    @root_node = nil
    @visited_positions = [position]
    build_move_tree
  end

  def build_move_tree
    queue = []
    @root_node = PolyTreeNode.new(@starting_position)
    queue << @root_node
    until queue.empty?
      node = queue.shift

      new_move_positions(node.value).each do |possible_position|
        new_node = PolyTreeNode.new(possible_position)
        queue << new_node
        node.add_child(new_node)
      end
    end
  end

  def self.valid_moves(position)
    valid_moves = []
    x, y = position
    potential_locations = KNIGHT_POS.map do |move|
      [move.first + x, move.last + y]
    end

    potential_locations.each_with_index do |location, index|
      if location.first.between?(0, 7) && location.last.between?(0, 7)
        valid_moves << location
      end
    end

    valid_moves
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos)

    new_positions.reject! { |pos| @visited_positions.include?(pos) }
    # add new positions to visited
    @visited_positions += new_positions

    new_positions
  end

  def find_path(end_pos)
    node = @root_node.bfs(end_pos)
    path = []
    until node.nil?
      path << node.value
      node = node.parent
    end

    path.reverse
  end

  def run(desired)
    print find_path(desired)
  end
end
