//
//  FLAGMAPPERApp.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-19.
//

import SwiftUI

@main
struct FLAGMAPPERApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var dataManager: DataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
//            MapView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environmentObject(dataManager)
        }
    }
}
