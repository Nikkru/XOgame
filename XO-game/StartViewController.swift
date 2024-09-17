//
//  StartViewController.swift
//  XO-game
//
//  Created by Nikkru on 30.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    var mainView: StartMainView { return self.view as! StartMainView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .darkGray
        
        mainView.onAddComputerButtonAction = { [weak self] in
            self?.gameModeSelection()
        }
        mainView.onAddHumanButtonAction = { [weak self] in
            self?.gameModeSelection()
        }
    }
    
    override func loadView() {
        self.view = StartMainView(frame: UIScreen.main.bounds)
    }
    
    func gameModeSelection() {
        let rootViewController = GameViewController()
        mainView.choiceHumanButton.isTouchInside
        ? (rootViewController.playMode = .human)
        : (rootViewController.playMode = .computer)
//        rootViewController.modalPresentationStyle = .fullScreen
        present(rootViewController, animated: true, completion: nil)
    }
}
