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
    
    var game = Game()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setSymbol(tagNr: Int){
      
        let playerOneOrTwo = game.currentPLayer == game.playerOne ? "xmark"
        : "circle"
        let symbol = view.viewWithTag(tagNr) as? UIImageView
        symbol?.image = UIImage(systemName: playerOneOrTwo)
    }
   
   
    @IBAction func onPress(_ sender: UITapGestureRecognizer) {
    guard let tag = sender.view?.tag else {return}
        
        if game.setTag(atIndex: tag){
            setSymbol(tagNr: tag)
        }
        

      print("tag nr : \(tag)")
        
    }
    
   
    
}
