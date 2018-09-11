//
//  AppDelegate.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .blackTranslucent
        UISearchBar.appearance().keyboardAppearance = .dark
        UISearchBar.appearance().tintColor = .white
        
        let newWindow = UIWindow(frame: UIScreen.main.bounds)

        window = newWindow

        appCoordinator = AppCoordinator(withWindow: newWindow)
        appCoordinator?.start()
        
        return true
    }
    
}
