//
//  MMTWidgetAttributes.swift
//  TestProject
//
//  Created by Ritik Sharma on 30/06/23.
//

import Foundation
import ActivityKit

struct MMTWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
