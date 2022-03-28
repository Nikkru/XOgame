//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Nikkru on 23.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PlayerInputState: GameStateProtocol {
    
    private(set) var isCompleted = false
    
    let player: Player
    
    private(set) weak var gameViewController: StartViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Player,
         gameViewController: StartViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView) {
        
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
//    MARK:- настройка UI
    public func begin() {
        
        switch self.player {
            
        case .first:
            self.gameViewController?.mainView.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.mainView.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.mainView.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.mainView.secondPlayerTurnLabel.isHidden = false }
        
        self.gameViewController?.mainView.winnerLabel.isHidden = true }
    
//    MARK:- выставляет соответствующую отметку на игровом поле — крестик для первого игрока и нолик для второго
    public func addMark(at position: GameboardPosition) {
        
//          проверка места на доске на возможность на размещение вью игрока
        guard let gameboardView = self.gameboardView,
              gameboardView.canPlaceMarkView(at: position) else { return }
        
        let markView: MarkView
        
        switch self.player {
            
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        }
        
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(markView, at: position)
        self.isCompleted = true
    }
}
