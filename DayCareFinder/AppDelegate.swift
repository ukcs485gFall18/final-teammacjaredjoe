//
//  AppDelegate.swift
//  DayCareFinder
//
//  Created by Jared Payne on 9/2/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain public class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DayCareFinder")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
