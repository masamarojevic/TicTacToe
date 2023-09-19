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
    
    var game = Game()
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
        game.board = [0,0,0,0,0,0,0,0,0]
        game.currentPLayer = 1
        for tag in 1...9 {
            if let symbol = view.viewWithTag(tag) as? UIImageView {
                symbol.image = nil
            }
                
        }
        lblWin.text = ""
    }
   
   
    @IBAction func onPress(_ sender: UITapGestureRecognizer) {
        //guard for cheking if there is a tag connected to the image
    guard let tag = sender.view?.tag else {return}
        
        let (gameMoment, validMove, currentPlayer) = game.setTag(atIndex: tag)
        
        let currentPLayer = game.currentPLayer
        
      
        
           if validMove {
             setSymbol(tagNr: tag, currentPlayer: currentPLayer)
           }
//
        switch gameMoment{
        case .win:
            lblWin.text = "Player \(currentPlayer) wins"
            self.view.layoutIfNeeded()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
//                   self.resetGame()
//               }
//          resetGame()
        case .draw :
            lblWin.text = "Draw"
            self.view.layoutIfNeeded()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
//                   self.resetGame()
//               }
//          resetGame()
        case .continueGame :
            game.switchPlayers()
        }
        print("tag nr : \(tag)")
        }
        

      
        
    }
    
   
    

