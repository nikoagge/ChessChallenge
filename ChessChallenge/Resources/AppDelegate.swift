//
//  AppDelegate.swift
//  ChessChallenge
//
//  Created by Nikos Aggelidis on 6/7/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ChessBoardViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
