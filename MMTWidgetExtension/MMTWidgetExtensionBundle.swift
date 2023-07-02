//
//  MMTWidgetExtensionBundle.swift
//  MMTWidgetExtension
//
//  Created by Ritik Sharma on 30/06/23.
//

import WidgetKit
import SwiftUI

@main
struct MMTWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        MMTWidgetExtension()
        MMTWidgetExtensionLiveActivity()
    }
}
