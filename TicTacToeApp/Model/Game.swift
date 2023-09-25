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
    
    enum GameMoments {
        case win
        case draw
        case continueGame
    }
    
    enum GameOption {
    case PlayerVsPlayer
    case PlayerVsComputer
    }
    
    //by default we are playing player vs player
    var gameOption: GameOption = .PlayerVsPlayer
   
    //SWITCH PLAYERS
    func switchPlayers (){
        if currentPLayer == 1{
            currentPLayer = 2
        }else{
            currentPLayer =  1
        }
    }
    
    //CHECKING TAG
    //settag is taking in index which is tag and it returns- if there was a win/draw, a valid move and currentplayer
    func setTag(atIndex index: Int) -> (GameMoments,Bool,Int){
        
        //minus one to not choose an index that has no place
        let index = index - 1
        
        if isSpotOccupied(atIndex: index){
            return (.continueGame, false, currentPLayer)
        }
        
    
        //CHECKING BOUNDRIES
        guard index >= 0 && index < board.count && board[index] == 0 else {
            print("Invalid move at index \(index)")
            //no win, no valid move for the current player
            return (.continueGame,false,currentPLayer)
        }
        
        //currentPlayer has set pressed a tag on the board
        board[index] = currentPLayer
       
        
        if CheckforWin(){
            // if there is a win there was a win, valid move for the currentplayer
            return (.win,true,currentPLayer)
        }
        //if there is no win OR valid move by currentplayer
        if !board.contains(0){
            return (.draw, true, currentPLayer)
        }
        
        //game is played
        return (.continueGame,true,currentPLayer)
    }
    
   
    
    
    //WINNING OPTIONS
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
    
    //RESET BOARD, PLAYER
    func reset(){
        board = [0,0,0,0,0,0,0,0,0]
        currentPLayer = 1
    }
    
    //COUNTING
    func playerCount(_ player:Int){
        if player == 1 {
            countWinPlayer1 += 1
        }else {
            countWinPlayer2 += 1
        }
    }
    
    //CHECK ALL AVAILABLE MOVES
    func availableMoves()-> [Int]{
        var moves: [Int] = []
        
        //enumareted check the whole board which spots are avaible. if there are empty spots it ads the index to the array
        for (index,spot) in board.enumerated(){
            if spot == 0 {
                moves.append(index)
            }
        }
        return moves
    }
    
    //COMPUTER PLAYER
    func computerMoves() -> Int? {
        //computer will need to know the avaliable moves to be able to random select a spot that is not occupied
        let freeSpots = availableMoves()
        
        guard !freeSpots.isEmpty else{
            return nil
        }
        //randomelement randomly selects an empty spot
        return freeSpots.randomElement()
       
        
    }
    
    //CHECK FOR SPOT
    func isSpotOccupied(atIndex index: Int) -> Bool {
       // cheking so that the spot is not empty.this is more spesific
        return board[index] != 0
    }
    
 
        
    
}
