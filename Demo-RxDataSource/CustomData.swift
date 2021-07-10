//
//  CustomData.swift
//  Demo-RxDataSource
//
//  Created by NishiokaKohei on 02/08/2019.
//  Copyright © 2019 Takumi. All rights reserved.
//

import Differentiator
import Foundation

struct CustomData {
    var anInt: Int
    var aString: String
    var aCGPoint: CGPoint
}

extension CustomData: IdentifiableType, Equatable {
    var identity: Int {
        return anInt
    }
    typealias Identity = Int
}
