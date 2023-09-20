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
    
    var countWin = 0
    
    func switchPlayers (){
        if currentPLayer == 1{
            currentPLayer = 2
        }else{
            currentPLayer =  1
        }
    }
    //settag is taking in index which is tag and it returns- if there was a win/draw, a valid move and currentplayer
    func setTag(atIndex: Int) -> (GameMoments,Bool,Int){
        
        //minus one to not choose an index that has no place
        let index = atIndex - 1
        
        //cheking boundries
        guard index >= 0 && index < board.count && board[index] == 0 else {
            print("Invalid move at index \(index)")
            //no win, no valid move for the current player
            return (.continueGame,false,currentPLayer)
        }
        
        //currentPlayer has set pressed a tag on the board
        board[index] = currentPLayer
       
        
        //if there is no win, valid move by currentplayer
        if !board.contains(0){
            return (.draw, true, currentPLayer)
        }
        
        
        if CheckforWin(){
            // if there is a win there was a win, valid move for the currentplayer
            return (.win,true,currentPLayer)
        }
       
        //game is played
        return (.continueGame,true,currentPLayer)
    }
    
    enum GameMoments {
        case win
        case draw
        case continueGame
    }
    
    func CheckforWin() -> Bool{
        
        let winOption = [
            [0,1,2],
            [3,4,5],
            [6,7,8],
            [0,4,8],
            [2,4,6],
            [0,3,6],
            [1,4,7],
            [2,5,8]
        ]
        return winOption.contains(where: {
            board[$0[0]] != 0 && board[$0[0]] == board[$0[1]] && board[$0[1]] == board[$0[2]]
        })
    }
        
    
}
