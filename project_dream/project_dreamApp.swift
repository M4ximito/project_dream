//
//  project_dreamApp.swift
//  project_dream
//
//  Created by mac on 14.06.23.
//

import SwiftUI

@main
struct project_dreamApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
