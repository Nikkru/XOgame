//
//  StartViewController.swift
//  XO-game
//
//  Created by Nikkru on 23.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

enum PlayMode { case human, computer }

class GameViewController: UIViewController {
    
    var mainView: GameMainView { return self.view as! GameMainView }
    private let gameboard = Gameboard()
    private lazy var referee = Referee(gameboard: gameboard)
    private var inputStates: [Player: InputStateProtocol] = [:]

    private var currentState: GameStateProtocol! {
        didSet { self.currentState.begin()
        }
    }
    var playMode: PlayMode? = .computer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInputStates()
        startNewGame()
//        goToFirstState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func loadView() {
        
        self.view = GameMainView(frame: UIScreen.main.bounds)
        
        mainView.gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState() }
        }
        
        mainView.onAddGameAction = { [weak self] in
            self?.addRestartButtonAction()
        }
    }
    
    private func setHumanHumanStates() {
        
        inputStates[Player.first] = PlayerInputState(
            player: Player.first,
            gameViewController: self,
            gameboard: gameboard,
            gameboardView: mainView.gameboardView)
        inputStates[Player.second] = PlayerInputState(
            player: Player.second,
            gameViewController: self,
            gameboard: gameboard,
            gameboardView: mainView.gameboardView)
    }
    
    private func setHumanComputerStates() {
        
        inputStates[Player.first] = PlayerInputState(
            player: Player.first,
            gameViewController: self,
            gameboard: gameboard,
            gameboardView: mainView.gameboardView)
        inputStates[Player.second] = ComputerInputState(
            player: Player.second,
            gameViewController: self,
            gameboard: gameboard,
            gameboardView: mainView.gameboardView)
    }
    
    private func setInputStates() {
        if playMode == .computer {
            setHumanComputerStates()
        } else {
            setHumanHumanStates()
        }
    }
    
    private func startNewGame() {
        mainView.gameboardView.clear()
        gameboard.clear()
        goToFirstState()
        
        mainView.gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        
        currentState = inputStates[.first]
        currentState.isCompleted = false
    }
    private func goToNextState() {
        
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        //  проверка условия для ничейного результата
        if GameboardSize.fieldsCount == MarkView.stepsCount {
            let gameEnded = GameEndedState(winner: nil, gameViewController: self)
            gameEnded.begin()
            return
        }
        
        if let currentInputState = currentState as? InputStateProtocol {
            currentState = inputStates[currentInputState.player.next]
            currentState.isCompleted = false
            if currentState is ComputerInputState {
                mainView.gameboardView.onSelectPosition = nil
                currentState.addMark(at: nil)
                if currentState.isCompleted {
                    goToNextState()
                }
            } else {
                mainView.gameboardView.onSelectPosition = { [weak self] position in
                    guard let self = self else { return }
                    self.currentState.addMark(at: position)
                    if self.currentState.isCompleted {
                        self.goToNextState()
                    }
                }
            }
        }
//        if let playerInputState = currentState as? PlayerInputState {
//            self.currentState = PlayerInputState(
//                player: playerInputState.player.next,
//                gameViewController: self,
//                gameboard: gameboard,
//                gameboardView: mainView.gameboardView
//            )
//        }
    }
    
    func addRestartButtonAction() {
        
        mainView.gameboardView.clear()
        gameboard.clear()
        goToFirstState()
    }
}
