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
    
    //we need a boolean to know if we are playing with a computer or not
    var isPlayingWithComputer:Bool = false
    
    var board = [0,0,0,0,0,0,0,0,0]
    
    var countWinPlayer1 = 0
    var countWinPlayer2 = 0
   
    
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
    
    func reset(){
        board = [0,0,0,0,0,0,0,0,0]
        currentPLayer = 1
    }
    
    func playerCount(_ player:Int){
        if player == 1 {
            countWinPlayer1 += 1
        }else {
            countWinPlayer2 += 1
        }
    }
    
    func computerMoves() -> Int? {
        print("Determining computer's move...")
        //enumareted say on which index the players has placed its icon, which indexes are empty. It looks at the whole board
        // compactmap checks if there is an empty spot, takes his index if so if not it ignores is
        //randomelement randomly selects an empty spot
        let freeMoves = board.enumerated().compactMap{$1 == 0 ? $0 : nil}
        return freeMoves.randomElement()
        
    }
    
    func isSpotOccupied(atIndex index: Int) -> Bool {
        // Assuming you have a representation of your board as an array called board
        // where empty spots are represented by 0, player 1 by 1, and player 2 by 2
        return board[index] != 0
    }
        
    
}
