//
//  GameboardSize.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation
import UIKit

 struct GameboardSize {
    
     static let columns = 3
     static let rows = 3
   
//     вычисляемое значение игровой емкости поля
    static var fieldsCount: Int = {
         GameboardSize.columns * GameboardSize.rows
     }()
    
    private init() { }
}
