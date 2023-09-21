//
//  Write2NamesViewController.swift
//  TicTacToeApp
//
//  Created by Ana Marojevic on 2023-09-13.
//

import UIKit

class Write2NamesViewController: UIViewController {

    @IBOutlet weak var txtFieldname2: UITextField!
    @IBOutlet weak var txtFieldName1: UITextField!
    
    let navigateToGame = "NavigateToGame"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == navigateToGame{
                  
      let destinationVC = segue.destination as! GameViewController
      if let txtName1 = txtFieldName1.text,let txtName2 = txtFieldname2.text{
          
          destinationVC.playerOne = Player(name: txtName1)
          destinationVC.playerTwo = Player(name: txtName2)
      }
           
            
           
        }
    }
    

}
