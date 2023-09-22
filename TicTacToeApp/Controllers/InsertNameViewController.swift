//
//  InsertNameViewController.swift
//  TicTacToeApp
//
//  Created by Ana Marojevic on 2023-09-13.
//

import UIKit

class InsertNameViewController: UIViewController {
 
    @IBOutlet weak var txtFieldInsertName: UITextField!
    let navigateToGame1 = "navigate"
    
    let navigateToGameIcon = "iconNavigate"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == navigateToGame1{
            
            let destinationVC = segue.destination as! GameViewController
            destinationVC.gameOption = .PlayerVsComputer
            if let txtName1 = txtFieldInsertName.text{
                print("setting name for player one : \(txtName1)")
                destinationVC.playerOne = Player(name: txtName1)
            }
        }
        
        
    }
   
}
