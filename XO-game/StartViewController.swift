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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {

    }

    override func loadView() {
        self.view = GameMainView(frame: UIScreen.main.bounds)

        mainView.gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.mainView.gameboardView.placeMarkView(XView(), at: position)
        }
    }
}
