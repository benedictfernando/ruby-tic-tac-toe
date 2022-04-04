
class Player
    attr_reader :move

    def initialize(move)
        @move = move
    end
end

class Board
    def initialize
        @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        @player1turn = true
    end

    def start_game(player_one, player_two)

        # welcome players
        puts "Welcome to Tic-tac-toe Game! :)\n" + "Win by completing three " +
        "of your marks horizontally, vertically, or diagonally.\n" +
        "Note: Please choose a cell between 1 - 9, inclusively."

        until (winner_is != nil || all_cells_are_filled_up)
            print_cells
            print "Player ##{@player1turn ? 1 : 2} move:\n> "
            
            while move = gets.chomp.to_i
                if move < 1 or move > 9
                    puts "Only input cell number between 1 - 9 inclusively."
                    print "> "
                elsif @cells[move - 1].is_a? String
                    puts "Cell is already occupied. Please choose another one."
                    print "> "
                else break end
            end

            move -= 1
            if @player1turn then @cells[move] = player_one.move
            else @cells[move] = player_two.move end

            if winner_is != nil
                farewell_user("Player ##{@player1turn ? 1 : 2} wins!")
            elsif all_cells_are_filled_up then farewell_user("Tie!")
            else @player1turn = !@player1turn end 
        end
    end

    private

    def print_cells
        puts
        for index in 0...@cells.length do
            print @cells[index]
            if (index + 1) % 3 == 0 then puts "\n- - -" else print "|" end
        end
        puts
    end

    def winner_is
        tl = @cells[0]; t = @cells[1]; tr = @cells[2]
        l = @cells[3]; m = @cells[4]; r = @cells[5]
        bl = @cells[6]; b = @cells[7]; br = @cells[8]

        # for trios with 'middle' one as their common cell
        if (tl == m && m == br || t == m && m == b || 
            tr == m && m == bl || r == m && m == l) then return m
    
        # for trios with 'top-left' one as their common cell
        elsif (tl == t && t == tr || tl == l && l == bl) then return tl
    
        # for trios with 'bottom-right' one as their common cell
        elsif (br == r && r == tr || br == b && b == bl) then return br

        # end conditionals
        end
    end

    def all_cells_are_filled_up
        @cells.select { |cell| cell.is_a? String }.length == @cells.length
    end

    def farewell_user(message)
        print_cells
        puts "#{message}\nMany thanks for playing Tic-tac-toe with us! :)"
    end 
end

player_one = Player.new('x')
player_two = Player.new('o')
main_board = Board.new
main_board.start_game(player_one, player_two)
