//
//  Game.swift
//  TicTacToeApp
//
//  Created by Ana Marojevic on 2023-09-14.
//

import Foundation

class Game {
    
    var playerOne = 1
    
    var playerTwo = 2
    
    var currentPLayer = 1
    
    //we need a boolean to know if the game has started
    var isPlaying = false
    
    var board = [0,0,0,0,0,0,0,0,0]
    
    func switchPlayers (){
        if currentPLayer == 1{
            currentPLayer = 2
        }else{
            currentPLayer =  1
        }
    }
    
    func setTag(atIndex: Int) -> Bool{
        let index = atIndex - 1
        guard atIndex >= 0 && atIndex < board.count && board[atIndex] == 0 else {
            print("Invalid move at index \(index)")
            return false
        }
        board[atIndex] = currentPLayer
        switchPlayers()
        return true
    }
    
    
}
