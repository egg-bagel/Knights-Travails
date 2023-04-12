class Square
  attr_accessor :parent, :coordinates

  def initialize
    @coordinates = []
    @parent = []
  end

end

class Board
  attr_accessor :board_array

  def initialize
    @board_array = build_board
  end

  def build_board
    board_array = []

    i = 0
    while i < 8
      j = 0
      while j < 8 
        square = Square.new
        square.coordinates = [i, j]
        board_array.push(square)
        j += 1
      end
      i += 1
    end

    return board_array
  end

  def print_board_array
    p @board_array
  end

end

class Knight
  
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def print_board
    p @board
  end

  def knight_moves(start_point, end_point, board = @board)

    start_square = coordinates_to_square(start_point)
    destination_square = coordinates_to_square(end_point)

    queue = [start_square]
    next_queue = []
    visited = []
    moves = 0

    while !queue.empty?
      queue.each do |square|
        if square.coordinates == end_point
          puts "Reached the end point #{end_point} from the start point #{start_point} in #{moves} moves"
          puts "The path is #{build_path(destination_square, start_square)}"
          return moves

        else
          visited.push(square)
          possible_moves = all_possible_moves(square.coordinates)
          possible_moves.each do |move| 
            next_square = coordinates_to_square(move)
            unless visited.include?(next_square)
              unless next_queue.include?(next_square)
                next_square.parent = square.coordinates
                next_queue.push(next_square)
              end
            end

          end
        end
      end

      queue = next_queue.clone
      next_queue.clear

      moves += 1
    end

  end

  #Takes a set of coordinates and links them to a Square object on the board
  #that can take a parent attribute
  def coordinates_to_square(coordinates, board = @board)
    i = 0
    while i < 64
      if board.board_array[i].coordinates == coordinates
        new_square = board.board_array[i]
      end
      i += 1
    end
    return new_square
  end

  #Builds the path once the destination has been found.
  def build_path(destination_square, start_square)
    reversed_path_array = [destination_square.coordinates]
    last_square_coordinates = destination_square.parent
    until last_square_coordinates == start_square.coordinates
      reversed_path_array.push(last_square_coordinates)
      parent_square = coordinates_to_square(last_square_coordinates)
      last_square_coordinates = parent_square.parent
    end
    reversed_path_array.push(start_square.coordinates)
    path_array = reversed_path_array.reverse
    return path_array
  end


  #Finds all possible moves from any point on the board
  def all_possible_moves(start_point)
    x = start_point[0]
    y = start_point[1]
    moves_array = []

    if (x - 2) >= 0
      moves_array.push([x - 2, y + 1]) if (y + 1) <= 7
      moves_array.push([x - 2, y - 1]) if (y - 1) >= 0
    end

    if (x - 1) >= 0
      moves_array.push([x - 1, y + 2]) if (y + 2) <= 7
      moves_array.push([x - 1, y - 2]) if (y - 2) >= 0
    end

    if (x + 1) <= 7
      moves_array.push([x + 1, y + 2]) if (y + 2) <= 7
      moves_array.push([x + 1, y - 2]) if (y - 2) >= 0
    end

    if (x + 2) <= 7
      moves_array.push([x + 2, y + 1]) if (y + 1) <= 7
      moves_array.push([x + 2, y - 1]) if (y - 1) >= 0
    end

    return moves_array

  end

end

knight = Knight.new
knight.knight_moves([6, 4], [3, 2])