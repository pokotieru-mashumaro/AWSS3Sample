//
//  AWSS3SampleApp.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/22.
//

import SwiftUI

@main
struct AWSS3SampleApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
