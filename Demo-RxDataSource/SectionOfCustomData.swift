//
//  SectionOfCustomData.swift
//  Demo-RxDataSource
//
//  Created by NishiokaKohei on 02/08/2019.
//  Copyright © 2019 Takumi. All rights reserved.
//

import Differentiator
import Foundation

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData

    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}

extension SectionOfCustomData: AnimatableSectionModelType {
    var identity: String {
        return header
    }

    typealias Identity = String
}
