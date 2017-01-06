import Cocoa
import Foundation

// Create an enumeration for the suits of a deck of cards
enum Suit : String {
    
    case hearts     = "❤️"
    case diamonds   = "♦️"
    case spades     = "♠️"
    case clubs      = "♣️"
    
    // Given a value, returns the suit
    static func glyph(forHashValue : Int) -> String {
        switch forHashValue {
        case 0 :
            return Suit.hearts.rawValue
        case 1 :
            return Suit.diamonds.rawValue
        case 2 :
            return Suit.spades.rawValue
        case 3 :
            return Suit.clubs.rawValue
        default:
            return Suit.hearts.rawValue
        }
    }
    
}


// Create a new datatype to represent the structure of a playing card
struct Card {
    //Each card has a suit and a value
    var value : Int
    var suit : Int
    
    // Initializer accepts arguments to set up this instance of the struct
    init(value : Int, suit : Int) {
        self.value = value
        self.suit = suit
    }
    
}

// Initalize a deck of cards
var deck : [Card] = []      // creates an empty deck
//This is a loop that creates every card in the deck
for suit in 0...3 {
    for value in 1...13 {
        var myCard = Card(value: value, suit: suit)
        deck.append(myCard)
    }
}

// Creates a string describing the suit and value for each card created in the loop above
for card in deck {
    print("Suit is \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}

// Initialize hands
//create empty array for player hand and computer hand
var playerHand : [Card] = []
var computerHand : [Card] = []


// "Shuffle" the deck and give half the cards to the player
while deck.count > 26 {
    
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    // Copy the card in this position to the player's hand
    playerHand.append(deck[position])
    
    // Remove the card from the deck for this position
    deck.remove(at: position)
    
}

// Writes a statement for every card in the players hand
print("=====================================")
print("All cards in the player's hand are...")
for (value, card) in playerHand.enumerated() {
    print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}



// "Shuffle" the deck and give half the cards to the computer
while deck.count > 0 {
    
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    // Copy the card in this position to the computer's hand
    computerHand.append(deck[position])
    
    // Remove the card from the deck for this position
    deck.remove(at: position)
    
}
// Writes a statement for every card in the computers hand
print("=====================================")
print("All cards in the CPU's hand are...")
for (value, card) in computerHand.enumerated() {
    print("Card \(value) in computers's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}



//This loop will repeat until the player either loses or wins by having all or no cards

while playerHand.count > 0 && playerHand.count < 52 {
    // Selects the top card from the player's deck and assignss it to a variable named 'currentPlayerCard'
    
    var playerCardPosition = 0
    
    var currentPlayerCard = playerHand[playerCardPosition]
    
    // Selects the top card from the computer's deck and assigns it to a variable named 'currentComputerCard'
    var computerCardPosition = 0
    
    var currentComputerCard = computerHand[computerCardPosition]
    
    // Iterate over the player's hand
    print("=====================================")
    print("All cards in the player's hand are...")
    for (value, card) in playerHand.enumerated() {
        print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
    }
    
    // Iterate over the computer's hand
    print("=====================================")
    print("All cards in the CPU's hand are...")
    for (value, card) in computerHand.enumerated() {
        print("Card \(value) in computers's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
    }
    
    
    //Compares the top card of both decks and sees who won or if there is a tie
    if currentPlayerCard.value > currentComputerCard.value {
        // In the case that the players card won takes the two cards and puts them at the bottom of the players deck
        playerHand.append(currentComputerCard)
        playerHand.append(currentPlayerCard)
        playerHand.remove(at: playerCardPosition)
        computerHand.remove(at: computerCardPosition)
        
    } else if currentPlayerCard.value < currentComputerCard.value {
        //In the case that the computer wins it takes both cards and puts them at the bottom of the computers deck
        computerHand.append(currentPlayerCard)
        computerHand.append(currentComputerCard)
        playerHand.remove(at: playerCardPosition)
        computerHand.remove(at: computerCardPosition)
        
    } else {
        //If the cards did not win or lose they tied
        
        //Creating War Hands
        var playerWarHand : [Card] = []
        var computerWarHand : [Card] = []
    
        
        // Checks to see that both players after removing a card have enough cards to do a war
        if playerHand.count == 1 {
            //player loses
            print("You don't have enough cards for a war")
            break
            
        } else if computerHand.count == 1 {
            //computer loses
            print("CPU doesn't have enough cards for a war")
            break
            
        } else {
            
            // building players war hand
            while playerWarHand.count < 4 || playerHand.count==1 {
                playerWarHand.append(playerHand[0])
                playerHand.remove(at: 0)
                
            }
            //building computers war hand
            while computerWarHand.count < 4 || computerHand.count==1 {
                computerWarHand.append(computerHand[0])
                computerHand.remove(at: 0)
                
                //This is just to show us the war hands and regular hands after the war hand is built.
            }
            print("=====================================")
            print("All cards in the player's war hand are...")
            for (value, card) in playerWarHand.enumerated() {
                print("Card \(value) in player's war hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
            }
            
            print("=====================================")
            print("All cards in the Computer's war hand are...")
            for (value, card) in computerWarHand.enumerated() {
                print("Card \(value) in computer's war hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
            }
            
            print("=====================================")
            print("All cards in the player's hand are...")
            for (value, card) in playerHand.enumerated() {
                print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
            }
            
            print("=====================================")
            print("All cards in the CPU's hand are...")
            for (value, card) in computerHand.enumerated() {
                print("Card \(value) in computers's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
            }
            //Checks to see who won the war by compairing the last card left in the player/computer hands
            
            if playerHand[0].value > computerHand[0].value {
                //If player wins war
                //Give cards from both war hands to player
                playerHand.append(contentsOf: playerWarHand)
                playerHand.append(contentsOf: computerWarHand)
                playerWarHand = []
                computerWarHand = []
                playerHand.append(computerHand[0])
                playerHand.append(playerHand[0])
                computerHand.remove(at: 0)
                playerHand.remove(at: 0)
                
            } else if computerHand[0].value > playerHand[0].value {
                //If computer wins war
                //Give cards from both war hands to computer
                computerHand.append(contentsOf: playerWarHand)
                computerHand.append(contentsOf: computerWarHand)
                playerWarHand = []
                computerWarHand = []
                computerHand.append(computerHand[0])
                computerHand.append(playerHand[0])
                computerHand.remove(at: 0)
                playerHand.remove(at: 0)
                
                
            } else {
                //It is another war
                print("It is time for another war")
                break
                
                
                
            }
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    
}

//End of the game if one deck reachs 0
if playerHand.count == 0 {
    print("You Lose")
} else if computerHand.count == 0 {
    print("You Win")
}







