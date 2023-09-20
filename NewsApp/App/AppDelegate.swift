//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit
import FirebaseCore
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var language = UserDefaults.standard.string(forKey: "language") ?? "en"
    
    // coredata veritabanı erişimi
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsModel")
        
        container.loadPersistentStores(completionHandler: { description, error in
            if let e = error {
                print(e.localizedDescription)
            }
        })
        return container
    }()
    
    //veritabanı değişikliklerini kaydetmek için
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        language = UserDefaults.standard.string(forKey: "language") ?? "en"
        
        if let userInterfaceStyle = UserDefaults.standard.string(forKey: "userInterfaceStyle") {
            if userInterfaceStyle == "dark" {
                window?.overrideUserInterfaceStyle = .dark
            } else {
                window?.overrideUserInterfaceStyle = .light
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

