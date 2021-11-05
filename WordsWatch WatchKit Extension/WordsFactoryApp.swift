//
//  WordsFactoryApp.swift
//  WordsWatch WatchKit Extension
//
//  Created by National Team on 05.11.2021.
//

import SwiftUI

@main
struct WordsFactoryApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
