//
//  swiftUICoreDataIssueApp.swift
//  swiftUICoreDataIssue
//
//  Created by Joe Smith on 9/28/21.
//

import SwiftUI

@main
struct swiftUICoreDataIssueApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
