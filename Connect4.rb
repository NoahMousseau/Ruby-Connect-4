#Connect-4

#Player class for keeping track of stats
class Player
    #Accessor method creation
    attr_accessor :playerName, :winCount, :turnNumber
    #Creating instance variables to use for player records
    @winCount = 0
    @playerName = ""
    
    #Resetting player stats
    def resetPlayer()
        @winCount = 0
    end
end

#Variable to determine which player goes first
$goesFirst = 0
#Variable to determine if game has been won
$gameWon = 0
#Declaration of two Player objects
@player1 = Player.new
@player2 = Player.new
@player1.winCount = 0
@player2.winCount = 0
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
    puts "--------------------------"
    loop do
        #Display main menu options
        puts "Connect-4!"
        puts "To play Connect-4, enter 1"
        puts "To see controls, enter 2"
        puts "To set up a game, enter 3"
        puts "To view current score, enter 4"
        puts "To exit program, enter 5"
        
        userInput = gets.chomp.to_i
        puts "--------------------------"
        
        case userInput
        when 1
          gameMenu()
          break
        when 2
          controlsMenu()
        when 3
          decisionMenu()
        when 4
          currentScore()
        when 5
          exit
        else
          puts "Invalid input, please enter a valid choice."
        end
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
    #After setting up player details, return to the main menu
    mainMenu()
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

#Function to reset game board
def resetGameBoard()
    #Iterate through each row
    @gameBoard.each_with_index do |row, rowIndex|
        #Iterate through each column
        row.each_with_index do |cell, colIndex|
            #Set the value of the current cell to 0
            @gameBoard[rowIndex][colIndex] = 0
        end
    end
end


#Function and menu to run game
def gameMenu() 
    
    #Win number variable
    winNumber = 0
    #Variable to count the number of turns taken and decide who goes first
    if $goesFirst == 1
        turnCount = 1
    else
        turnCount = 2
    end
    #Variable to track if game has been won
    gameWin = 0
    #Array to track column counts
    colCountArr = Array.new(7, 0)
    #Begin game
    while gameWin == 0
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

            #Check for a winner
            winner = checkBoard(@gameBoard, rowPlacement, userCol, "X")
            if winner == 1
                @player1.winCount += 1
                gameWin = 1
                winNumber = 1
            end

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

            #Check for a winner
            winner = checkBoard(@gameBoard, rowPlacement, userCol, "O")
            if winner == 2
                @player2.winCount += 1
                gameWin = 2
                winNumber = 2
            end

            #Increment turnCount
            turnCount = turnCount + 1
        end
    end
    #Reset game board
    resetGameBoard()
    #Bring up game over menu
    gameOverMenu(winNumber)
end

#Function to check game board for win conditions after every turn
def checkBoard(board, row, column, uString)
    #Win conditions
    rowWin = false
    colWin = false
    diaWin = false
    #Continuity counters
    rowCount = 0
    colCount = 0
    diaCount = 0
    #Column win check
    for r in 0...5 do
        if board[r][column] == uString
            rowCount += 1
        elsif board[r][column] != uString
            rowCount =0
        end
        #Test for column win condition
        if uString == "X"
            if rowCount == 4
                return 1
            end
        elsif uString == "O"
            if rowCount == 4
                return 2
            end
        end
    end
    #Row win check
    for c in 0...6 do
        if board[row][c] == uString
            colCount += 1
        elsif board[row][c] != uString
            colCount =0
        end
        #Test for Row win condition
        if uString == "X"
            if colCount == 4
                return 1
            end
        elsif uString == "O"
            if colCount == 4
                return 2
            end
        end
    end
    # Diagonal win check (top-left to bottom-right)
    for i in -3..3 do
        if (row + i >= 0 && row + i + 3 < 6) && (column + i >= 0 && column + i + 3 < 7)
            if (board[row + i][column + i] == uString &&
                board[row + i + 1][column + i + 1] == uString &&
                board[row + i + 2][column + i + 2] == uString &&
                board[row + i + 3][column + i + 3] == uString)
                return (uString == "X") ? 1 : 2
            end
        end
    end

    # Diagonal win check (top-right to bottom-left)
    for i in -3..3 do
        if (row - i >= 0 && row - i - 3 < 6) && (column + i >= 0 && column + i + 3 < 7)
            if (board[row - i][column + i] == uString &&
                board[row - i - 1][column + i + 1] == uString &&
                board[row - i - 2][column + i + 2] == uString &&
                board[row - i - 3][column + i + 3] == uString)
                return (uString == "X") ? 1 : 2
            end
        end
    end


    #If no winner, return 0
    return 0
end

def gameOverMenu(winNumber) 
    if winNumber == 1
        puts "Congratulations #{@player1.playerName}, you have won this round!"
    elsif winNumber == 2
        puts "Congratulations #{@player2.playerName}, you have won this round!"
    end
    #Decide end user input
    userDecision = gameOverDecision()
    if userDecision == 1
        currentScore()
    elsif userDecision == 2
        mainMenu()
    end
end

#Menu and user interface to decide where program goes
def gameOverDecision()
    #While loop to track menu
    while true
        #Get user input and decision after the game ends
        puts "To see the current score, enter 1"
        puts "To return to the main menu immediately, enter 2"
        gameOverInput = gets.chomp
        intGameOverInput = gameOverInput.to_i
        #Decide what is returned
        if intGameOverInput == 1
            return 1
        elsif intGameOverInput == 2
            return 2
        else
            puts "Invalid input, please enter a valid option."
        end
    end
end

#Display current score
def currentScore()
    puts "Current score:"
    puts "Player 1 (#{@player1.playerName}): #{@player1.winCount}"
    puts "Player 2 (#{@player2.playerName}): #{@player2.winCount}"
    puts "To continue back to the main menu, press return"
    gets
    mainMenu()
end

#Entry point into start of program
mainMenu()