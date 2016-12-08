import SpriteKit

class GameScene : SKScene {
        
    override func didMove(to view: SKView) {
            backgroundColor = SKColor.black
    }
        
}
    
// Create a card structure and assign a value (0-51) to each card in the deck
//Randomly select 26 cards for Player 1 and 26 cards for CPU and puts it into a bucket
//Create randomizer which randomly selects cards from each deck (that connects to the button)
//Create code which takes the card that is lost and the card that was won and puts them on the bottom of winners deck
//When one person has no more cards left have strings apear like "game over" or "P1 wins"
//After a few seconds have the game be able to start over
