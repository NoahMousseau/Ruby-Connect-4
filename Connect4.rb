#Connect-4

#Player class for keeping track of stats
class Player
    #Accessor method creation
    attr_accessor :playerName, :winCount, :turnNumber
    #Creating instance variables to use for player records
    def initializePlayer
        @winCount = 0
        @playerName = ""
        @playerNumber = 0
    end
    
    #Resetting player stats
    def resetPlayer
        @winCount = 0;
    end
end

#Variable to determine which player goes first
$goesFirst = 0
#Variable to determine if game has been won
$gameWon = 0
#Declaration of two Player objects
@player1 = Player.new
@player2 = Player.new
#Board size
rows = 6
columns = 7
#Board creation
#For accessing gameBoard, gameBoard[2][3] would be element in 3rd row and 4th columns
@gameBoard = Array.new(rows) {Array.new(columns, 0)}

#Var to save user input
userInput = 0

#Functions to bring up various menus
#Menu to allow game to be restarted after a round has been played, but after the game over screen
def mainMenu() 
    puts "Connect-4!"
    puts "To play Connect-4, enter 1"
    puts "To see controls, enter 2"
    puts "To exit program, enter 3"
    userInput = gets.chomp
    puts "--------------------------"
    #Decide what path program continues on
    if userInput.to_i == 1
        
    elsif userInput.to_i == 2
        controlsMenu()
    elsif userInput.to_i == 3
        exit
    end
end

#Menu to bring up controls and rules of game
def controlsMenu() 
    puts "Win conditions:"
    puts "4 in a row, column, or diagonally"
    puts "Decide if Player 1 or Player 2 goes first"
    puts "Press return to return to main menu"
    gets
    #Return to main menu
    mainMenu()
end

#Menu to decide if player 1 or 2 goes first
def decisionMenu()
    puts "Welcome to Connect-4!"
    puts "Choose a name for player 1:"
    @player1.playerName = gets.chomp
    puts "Choose a name for player 2:"
    @player2.playerName = gets.chomp
    puts "Decide which player goes first:"
    $goesFirst = gets.chomp.to_i
    puts "--------------------------"
end

#Menu to display the gameBoard
def displayBoard(board)
    #Display the gameBoard with row numbers
    (0..5).reverse_each do |row_index|
        #Display each column in the reversed order
        board[row_index].each do |cell|
            print "#{cell} "
        end
        puts  #Move to the next line for the next row
    end
end


#Function and menu to run game
def gameMenu() 
    #Variable to count the number of turns taken and decide who goes first
    if $goesFirst == 1
        turnCount = 1
    else
        turnCount = 2
    end
    #Array to track column counts
    colCountArr = Array.new(7, 0)
    #Begin game
    while $gameWon == 0
        if turnCount % 2 == 1
            #Asks Player 1 for a row and column
            puts "#{@player1.playerName}, choose a column:"
            puts ""
            displayBoard(@gameBoard)

            #Gets a user input and checks if it is valid. If not restarts request for user input
            validInput = 0
            while validInput == 0
                #Splits user input between row and column
                userColInput = gets.chomp.to_i
                userCol = userColInput - 1
                #Checks if user input is valid
                if colCountArr[userCol] < 6
                    #Variable to verify a player token was placed
                    placedVerifier = 0
                    #Iterate through rows in a given column
                    for i in 0..5
                        if @gameBoard[i][userCol] == 0 && placedVerifier == 0
                            rowPlacement = colCountArr[userCol]
                            @gameBoard[rowPlacement][userCol] = "X"
                            colCountArr[userCol] = colCountArr[userCol] + 1
                            placedVerifier = 1
                        end
                    end
                    validInput = 1
                else
                    puts "Column is full, choose another:"
                end
            end
            
            #Display board showing user input
            displayBoard(@gameBoard)
            #Orient game screen
            puts""
            puts"--------------------------"
            #Increment turnCount
            turnCount = turnCount + 1
        elsif turnCount % 2 == 0
            #Asks Player 2 for a row and column
            puts "#{@player2.playerName}, choose a column:"
            puts ""
            #Display board before any move is taken
            displayBoard(@gameBoard)

            #Gets a user input and checks if it is valid. If not restarts request for user input
            validInput = 0
            while validInput == 0
                #Splits user input between row and column
                userColInput = gets.chomp.to_i
                userCol = userColInput - 1
                #Checks if user input is valid
                if colCountArr[userCol] < 6
                    #Variable to verify a player token was placed
                    placedVerifier = 0
                    #Iterate through rows in a given column
                    for i in 0..5
                        if @gameBoard[i][userCol] == 0 && placedVerifier == 0
                            rowPlacement = colCountArr[userCol]
                            @gameBoard[rowPlacement][userCol] = "O"
                            colCountArr[userCol] = colCountArr[userCol] + 1
                            placedVerifier = 1
                        end
                    end
                    validInput = 1
                else
                    puts "Column is full, choose another:"
                end
            end
            
            #Display board showing user input
            displayBoard(@gameBoard)
            #Orient game screen
            puts""
            puts"--------------------------"
            #Increment turnCount
            turnCount = turnCount + 1
        end
    end
    #Bring up game over menu
    gameOverMenu()
end

def gameOverMenu() 
    gets
end

#Entry point into start of program
puts "Connect-4!"
puts "To play Connect-4, enter 1"
puts "To see controls, enter 2"
puts "To exit program, enter 3"

#Initial user decision
userInput = gets.chomp
puts "--------------------------"
intUserInput = userInput.to_i
if intUserInput == 1
    #Calls decisionMenu, decides who goes first and returns
    decisionMenu()
    gameMenu()
elsif intUserInput == 2
    controlsMenu()
elsif intUserInput == 3
    exit
end