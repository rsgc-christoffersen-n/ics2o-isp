//: Playground - noun: a place where people can play

import Cocoa
import Foundation




//I believe that when we run the playground that the top number of the winner doesn't move so lets say I start with the ace of spades as my first card the ace of spades keeps getting played (because it will probably win) which is not what you want you want it to do you want both the cards at the top to go to the bottom of the winners deck


//Another thing I wanted to mention was that I can only append 1 card at a time so when im trying to do the append method with the three cards that follow goes to the winner if there is a war it takes a lot of variables

//Lastly when I have a double tie I figued since we cannot have it repreating just to shuffle the decks after a double tie. I will be in at lunch with you sorry I could not today I had other conflicts

//Also whenever I run a tie then it keeps running ties

















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

//Play with the enumeration a bit to see what it gives us
Suit.hearts.hashValue
Suit.hearts.rawValue
Suit.diamonds.hashValue
Suit.diamonds.rawValue
Suit.spades.hashValue
Suit.spades.rawValue
Suit.clubs.hashValue
Suit.clubs.rawValue

// Create a new datatype to represent a playing card
struct Card {
    
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
for suit in 0...3 {
    for value in 1...13 {
        var myCard = Card(value: value, suit: suit)
        deck.append(myCard)
    }
}

// lets look at the deck
deck[20]



// Iterate over the deck of cards
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

// Iterate over the player's hand
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
// Iterate over the computer's hand
print("=====================================")
print("All cards in the CPU's hand are...")
for (value, card) in computerHand.enumerated() {
    print("Card \(value) in computers's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}



//This loop will repeat until the player either loses or wins by having all or no cards

while playerHand.count > 0 && playerHand.count < 52 {
    // Randomly select a card from the player's deck and assign it to a variable named 'currentPlayerCard'
    
    var playerCardPosition = 0//Int(arc4random_uniform(UInt32(playerHand.count)))
    
    var currentPlayerCard = playerHand[playerCardPosition]
    
    // Randomly select a card from the computer's deck  and assign it to a variable named 'currentComputerCard'
    var computerCardPosition = 0//Int(arc4random_uniform(UInt32(computerHand.count)))
    
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
    
    
    // Compare the two cards and print a message saying "Computer won" or "Player won" as appropriate
    if currentPlayerCard.value > currentComputerCard.value {
        // player wins
        playerHand.append(currentComputerCard)
        playerHand.append(currentPlayerCard)
        playerHand.remove(at: playerCardPosition)
        computerHand.remove(at: computerCardPosition)
        
    } else if currentPlayerCard.value < currentComputerCard.value {
        //computer wins
        computerHand.append(currentPlayerCard)
        computerHand.append(currentComputerCard)
        playerHand.remove(at: playerCardPosition)
        computerHand.remove(at: computerCardPosition)
        
    } else {
        
        //removing the card the was already compair (and caused a war)
        var playerWarHand : [Card] = [currentPlayerCard]
        var computerWarHand : [Card] = [currentComputerCard]
        playerHand.remove(at: 0)
        computerHand.remove(at: 0)
        
        // do both players have at least more then 0 cards so that they can play a war
        if playerHand.count == 0 {
            //player loses
            print("You Lose")
            break
            
        } else if computerHand.count == 0 {
            //computer loses
            print("You Win")
            break
            
        } else {
            //its war
            
            // building players war hand
            while playerWarHand.count < 4 || playerHand.count==1 {
                playerWarHand.append(playerHand[0])
                playerHand.remove(at: 0)
                
            }
            //building computers war hand
            while computerWarHand.count < 4 || computerHand.count==1 {
                computerWarHand.append(computerHand[0])
                computerHand.remove(at: 0)
                
                
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
            //Who won this war?
            
            if playerHand[0].value > computerHand[0].value {
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

//end of the game if one deck reachs 0
if playerHand.count == 0 {
    print("You Lose")
} else if computerHand.count == 0 {
    print("You Win")
}







