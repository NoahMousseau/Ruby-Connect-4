#Connect-4

#Player class for keeping track of stats
class Player
    #Creating instance variables to use for player records
    def initializePlayer
        @winCount = 0
        @turnNumber = 0
    end
    
    #Resetting player stats
    def resetPlayer
        @winCount = 0;
        @turnNumber = 0;
    end
end

#Board size
rows = 6
columns = 7
#Board creation
#For accessing gameBoard, gameBoard[2][3] would be element in 3rd row and 4th columns
gameBoard = Array.new(rows) {Array.new(columns, 0)}

#Var to save user input
userInput = 0

#Functions to bring up various menus
def mainMenu() 
    puts "Connect-4!"
    puts "To play Connect-4, enter 1"
    puts "To see controls, enter 2"
    puts "To exit program, enter 3"
    userInput = gets.chomp
    puts "--------------------------"
    #Decide what path program continues on
    if userInput.to_i == 1
        playerDecisionMenu()
    elsif userInput.to_i == 2
        controlsMenu()
    elsif userInput.to_i == 3
        exit
    end
end

def controlsMenu() 
    puts "Win conditions:"
    puts "4 in a row, column, or diagonally"
    puts "Decide if Player 1 or Player 2 goes first"
    puts "Press return to return to main menu"
    gets
    #Return to main menu
    mainMenu()
end

def playerDecisionMenu()

end

def gameMenu() 

    userInput = gets.chomp
end

def gameOverMenu() 

    userInput = gets.chomp
end

#Entry point into start of program
puts "Connect-4!"
puts "To play Connect-4, enter 1"
puts "To see controls, enter 2"
puts "To exit program, enter 3"

#Initial user decision
userInput = gets.chomp
puts "--------------------------"
if userInput.to_i == 1
    playerDecisionMenu()
elsif userInput.to_i == 2
    controlsMenu()
elsif userInput.to_i == 3
    exit
end