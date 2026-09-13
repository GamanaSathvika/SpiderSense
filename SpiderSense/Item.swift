//
//  Item.swift
//  SpiderSense
//
//  Created by Gamana Sathvika on 13/09/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
