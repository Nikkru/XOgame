//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Nikkru on 29.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class ComputerInputState: InputStateProtocol {
    
    var isCompleted = false
    
    let player: Player
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Player,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView) {
        
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    //       MARK: - Генерация хода компьютера
    private func calcPositions() -> GameboardPosition? {
        
        if let emptyPosition = gameboard?.getPositions()
            .map({ $0.enumerated()
                    .filter { $0.element == nil }
                    .map { $0.offset }
            }),
           let column = emptyPosition
            .enumerated()
            .filter({ !$0.element.isEmpty })
            .map({ $0.offset })
            .randomElement(),
           let row = emptyPosition[column].randomElement()
        {
            return GameboardPosition(column: column, row: row)
        }
        return nil
    }
    
    func begin() {
        
        switch self.player {
        case .first:
            self.gameViewController?.mainView.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.mainView.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.mainView.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.mainView.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.mainView.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition?) {
        
        let markView: MarkView
        
        switch self.player {
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        }
        guard let position = calcPositions() else { return }
        
        //          проверка места на доске на возможность на размещение вью игрока
        guard let gameboardView = self.gameboardView,
              gameboardView.canPlaceMarkView(at: position) else { return }
        gameboard?.setPlayer(player, at: position)
        self.gameboardView?.placeMarkView(markView, at: position)
        
        self.isCompleted = true
    }
}
