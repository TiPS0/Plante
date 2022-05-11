//
//  PlanteApp.swift
//  Plante
//
//  Created by Tipso on 15/4/2565 BE.
//

import SwiftUI
import Firebase

@main
struct PlanteApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
