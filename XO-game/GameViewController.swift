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

    private var humanOreComputer = true
    private var currentState: GameStateProtocol! {
        didSet { self.currentState.begin()
        }
    }
    var playMode: PlayMode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInputStates()
        startNewGame()
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
        
        mainView.onAddGameButtonAction = { [weak self] in
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
        
        delayWithSeconds(0.5) {
            
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
    //        ход компьютера
            if let currentInputState = self.currentState as? InputStateProtocol {
                self.currentState = self.inputStates[currentInputState.player.next]
                self.currentState.isCompleted = false
                if self.currentState is ComputerInputState {
                    self.mainView.gameboardView.onSelectPosition = nil
                    
                    self.currentState.addMark(at: nil)
                    if self.currentState.isCompleted {
                        self.goToNextState()
                    }
                } else {
                    self.mainView.gameboardView.onSelectPosition = { [weak self] position in
                        guard let self = self else { return }
                        self.currentState.addMark(at: position)
                        if self.currentState.isCompleted {
                            self.goToNextState()
                        }
                    }
                }
            }
        }
  
    }
    
    func addRestartButtonAction() {
        MarkView.stepsCount = 0
        mainView.gameboardView.clear()
        gameboard.clear()
//        goToFirstState()
        startNewGame()
    }
}

extension GameViewController {
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
