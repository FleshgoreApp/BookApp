//
//  BookAppApp.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI
import Firebase

@main
struct BookApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - AppDelegate

final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let backButtonImage = UIImage(named: "backButtonImage")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        
        FirebaseApp.configure()
        RemoteConfigManager.sharedInstance.setup()
        return true
    }
}
