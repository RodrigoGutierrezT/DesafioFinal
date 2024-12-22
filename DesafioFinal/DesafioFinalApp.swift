//
//  DesafioFinalApp.swift
//  DesafioFinal
//
//  Created by Rodrigo on 21-12-24.
//

import SwiftData
import SwiftUI

@main
struct DesafioFinalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MyHero.self)
    }
}
