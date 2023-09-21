//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Ana Marojevic on 2023-09-13.
//

import UIKit

enum GameOption {
case PlayerVsPlayer
case PlayerVsComputer
}

class GameViewController: UIViewController {
    
    //by default we are playing player vs player
    var gameOption: GameOption = .PlayerVsPlayer


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
    
   var playerOne: Player?
   var playerTwo: Player?
    
    var game = Game()
    
    
  
    

    override func viewDidLoad() {
        print("Current game option is: \(gameOption)")
        if gameOption == .PlayerVsComputer{
            print("inside the computer mode")
            game.isPlayingWithComputer = true
            playerTwo = Player(name: "Computer")
        }
        
       setName()
     updateScore()
        
        
    }
    
   
    //SETTING AN ICON ON THE BOARD .setting an image takes in the number of a tag and the current player who is placing it
    func setSymbol(tagNr: Int,currentPlayer: Int){
        
        //if the currentplayer is player one then place an xmark othervise place circle
        let playerOneOrTwo = currentPlayer == game.playerOne ? "xmark" : "circle"
        
        // connect the image with a tag
        let symbol = view.viewWithTag(tagNr) as? UIImageView
        symbol?.image = UIImage(systemName: playerOneOrTwo)
    }
    
    //RESETING GAME
    func resetGame(){
        
        game.reset()
        
        var something = 0
        
                for tag in 1...9 {
                    
                    if let symbol = view.viewWithTag(tag) as? UIImageView {
                        //index that is diviadable with 2 will have rect 4, others will have rect 5
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
        
        // we going to always check what is happening in the game and if there was a valid move
        let (gameMoment, validMove, currentPlayer) = game.setTag(atIndex: tag)
        print("Player \(currentPlayer) set tag at index \(tag), resulting game moment: \(gameMoment)")
        
        let currentPLayer = game.currentPLayer
        
         if validMove {
             setSymbol(tagNr: tag, currentPlayer: currentPLayer)
           }
        GameMoments(gameMoment, forPlayer: currentPlayer)
        

           
        
        print("tag nr : \(tag)")
        }
    
    //SETTING WHOS TURN IS IT ON SCREEN
    func setName(){
        if let player1Name = playerOne?.name,
           let player2Name = playerTwo?.name{
            if game.currentPLayer == 1 {
                lblPlayersTurn.text = "\(player1Name) 's turn"
            }else {
                lblPlayersTurn.text = "\(player2Name) 's turn"
            }
            
        } else{print("error")}
        
    }
    
    //UPDATING SCORE ON SCREEN
    func updateScore(){
        if let playerOneName = playerOne?.name,
           let playerTwoName = playerTwo?.name{
            
            player1Count.text = "\(playerOneName) score : \(game.countWinPlayer1)"
            player2Count.text = "\(playerTwoName) score : \(game.countWinPlayer2)"
        }
    }
    
    //COMPUTER MOVE
    func computerMove(){
        print("starting a move")
        var move:Int? = nil
        var attempts = 0
        while move == nil && attempts < 10{
            if let suggestedMove = game.computerMoves(),
                      !game.isSpotOccupied(atIndex: suggestedMove) {
                       move = suggestedMove
                   }
                   attempts += 1
        }
        guard let validMove = move else{
            print("comp cant move")
            return
        }
        //if computers moves set a symbol
//        if let move = game.computerMoves(){
//            print("computer move:\(move)")
            setSymbol(tagNr: validMove, currentPlayer: game.currentPLayer)
            
        //check if his move is a win ,draw ,continue , valid move and his turn
            let(gameMoment,_,_) = game.setTag(atIndex: validMove)
        
            print("game moment after the move",gameMoment)
            GameMoments(gameMoment, forPlayer: game.currentPLayer)
        }
    
    
    //MAKING A SWITCH FUNC FOR BOTH GAME OPTION SO I DONT REPEAT MYSELF
    func GameMoments(_ gameMoment: Game.GameMoments,forPlayer currentPlayer:Int){
        switch gameMoment{
        case .win:
            print("Player \(currentPlayer) has won")
            game.playerCount(currentPlayer)
            
            //if the winning player is nr 1 then the winner is playerOne otherwise the winner is playerTwo
            let winningPlayer = (currentPlayer == 1) ? playerOne : playerTwo
            
            //set the winner name on screen
            //let winningPlayer: Player? shortage for  if currentPlayer == 1 {
            //                nameWinner = player1?.name
            if let winnerName = winningPlayer?.name {
                lblWin.text = "\(winnerName) wins"
            }
            lblWin.isHidden = false
            
            updateScore()
          
           //2 SECONDS UNTILL SCREEN RESETS FOR THE GAME
            self.view.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
                  self.resetGame()
             }
            
        case .draw:
            print("The game ended in a draw")
            lblWin.text = "Draw"
            self.view.layoutIfNeeded()
            updateScore()
            lblWin.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
                  self.resetGame()
              }
      
        case.continueGame:
            print("The game continues with player \(currentPlayer)'s turn")
            game.switchPlayers()
            setName()
            
            // if we are playing with computer and its computers turn then let him take some time for making move and make him to do a move
            if game.isPlayingWithComputer && game.currentPLayer == game.playerTwo{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.computerMove()
                  
                  }
            }
            
           
        }
    }
        
}

   
    

