//
//  StartViewController.swift
//  XO-game
//
//  Created by Nikkru on 23.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var mainView: GameMainView { return self.view as! GameMainView }
    
    private let gameboard = Gameboard()
    
    private lazy var referee = Referee(gameboard: gameboard)
    
    private var currentState: GameStateProtocol! {
        didSet { self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.goToFirstState()

    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func loadView() {
        
       
        
        self.view = GameMainView(frame: UIScreen.main.bounds)

        mainView.gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
//            self.mainView.gameboardView.placeMarkView(XView(), at: position)
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
            self.goToNextState() }
        }
    }
    
    private func goToFirstState() {
        
        self.currentState = PlayerInputState(
            player: .first,
            gameViewController: self,
            gameboard: gameboard,
            gameboardView: mainView.gameboardView
        )
    }
    private func goToNextState() {
        
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        if let playerInputState = currentState as? PlayerInputState {
            self.currentState = PlayerInputState(
                player: playerInputState.player.next,
                gameViewController: self,
                gameboard: gameboard,
                gameboardView: mainView.gameboardView
            )
        }
    }
}
