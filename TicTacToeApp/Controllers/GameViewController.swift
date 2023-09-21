//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Ana Marojevic on 2023-09-13.
//

import UIKit

class GameViewController: UIViewController {
    


    @IBOutlet weak var imgsq1: UIImageView!
    @IBOutlet weak var imgsq2: UIImageView!
    @IBOutlet weak var imgsq3: UIImageView!
    @IBOutlet weak var imgsq4: UIImageView!
    @IBOutlet weak var imgsq5: UIImageView!
    @IBOutlet weak var imgsq6: UIImageView!
    @IBOutlet weak var imgsq7: UIImageView!
    @IBOutlet weak var imgsq8: UIImageView!
    @IBOutlet weak var imgsq9: UIImageView!
    @IBOutlet weak var lblWin: UILabel!
    
    @IBOutlet weak var player2Count: UILabel!
    @IBOutlet weak var player1Count: UILabel!
    @IBOutlet weak var lblPlayersTurn: UILabel!
    
    @IBOutlet weak var btnExitGame: UIButton!
    var player1: Player?
   var player2: Player?
    
    var game = Game()
  
    

    override func viewDidLoad() {
        
       setName()
     updateScore()
    }
    
   
    //setting an image takes in the number of a tag and the current player who is placing it
    func setSymbol(tagNr: Int,currentPlayer: Int){
        
        //if the currentplayer is player one then place an xmark othervise place circle
        let playerOneOrTwo = currentPlayer == game.playerOne ? "xmark" : "circle"
        
        // connect the image with a tag
        let symbol = view.viewWithTag(tagNr) as? UIImageView
        symbol?.image = UIImage(systemName: playerOneOrTwo)
    }
    
    
    func resetGame(){
        game.reset()
        
        var something = 0
        
                for tag in 1...9 {
                    
                    if let symbol = view.viewWithTag(tag) as? UIImageView {
                        symbol.image = UIImage(named: something % 2 == 0 ? "Rectangle 4" : "Rectangle 5")
                        something += 1
          }

       }
        lblWin.text = ""
        updateScore()
        
    }
   
   
    @IBAction func onPress(_ sender: UITapGestureRecognizer) {
        //guard for cheking if there is a tag connected to the image
    guard let tag = sender.view?.tag else {return}
        
        let (gameMoment, validMove, currentPlayer) = game.setTag(atIndex: tag)
        
        let currentPLayer = game.currentPLayer
        
         if validMove {
             setSymbol(tagNr: tag, currentPlayer: currentPLayer)
           }

        switch gameMoment{
            
        case .win:
            
            game.playerCount(currentPlayer)
            
            let winningPlayer = (currentPlayer == 1) ? player1 : player2
            if let winnerName = winningPlayer?.name {
                lblWin.text = "\(winnerName) wins"
            }
            lblWin.isHidden = false
            

            updateScore()
          

            self.view.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
                  self.resetGame()
             }
           
            
            
        case .draw :
            lblWin.text = "Draw"
            self.view.layoutIfNeeded()
            updateScore()
            lblWin.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
                  self.resetGame()
              }
      
            
        case .continueGame :
            game.switchPlayers()
            setName()
        }
        print("tag nr : \(tag)")
        }
    
    func setName(){
        if let player1Name = player1?.name, let player2Name = player2?.name{
            if game.currentPLayer == 1 {
                lblPlayersTurn.text = "\(player1Name) 's turn"
            }else {
                lblPlayersTurn.text = "\(player2Name) 's turn"
            }
            
        }else{
            print("error")
        }
        
    }
    func updateScore(){
        if let player1Name = player1?.name, let player2Name = player2?.name{
            player1Count.text = "\(player1Name) score : \(game.countWinPlayer1)"
            player2Count.text = "\(player2Name) score : \(game.countWinPlayer2)"
        }
    }
    
        

      
        
    }

   
    

