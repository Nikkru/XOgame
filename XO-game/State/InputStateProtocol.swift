//
//  InputStateProtocol.swift
//  XO-game
//
//  Created by Nikkru on 29.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol InputStateProtocol: GameStateProtocol {
    var player: Player { get }
}
