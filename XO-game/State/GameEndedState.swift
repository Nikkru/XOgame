//
//  GameEndedState.swift
//  XO-game
//
//  Created by Nikkru on 24.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class GameEndedState: GameStateProtocol {
    
    var isCompleted = false
    let winner: Player?
    
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() {
        
        self.gameViewController?.mainView.winnerLabel.isHidden = false
        
        if let winner = winner {
            self.gameViewController?.mainView.winnerLabel.text = self.winnerName(from: winner) + " win"
        } else {
            self.gameViewController?.mainView.winnerLabel.text = "No winner"
        }
        self.gameViewController?.mainView.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.mainView.secondPlayerTurnLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition?) {}
    
    private func winnerName(from winner: Player) -> String {
        
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        }
    }
    
}
