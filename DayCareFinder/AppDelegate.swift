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
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<Credential>(entityName: "Credential")
        let credentials = try! context.fetch(request)
        if let credential = credentials.last {
            self.setCurrentUser(with: credential)
            self.setInitialStoryboard(as: UIStoryboard(name: "DayCares", bundle: nil))
        }
        else {
            self.setInitialStoryboard(as: UIStoryboard(name: "Users", bundle: nil))
        }
    }
    
    private func setCurrentUser(with credential: Credential) {
        let user = User()
        user.email = credential.email
        user.authenticationToken = credential.authenticationToken
        User.currentUser = user
    }
    
    private func setInitialStoryboard(as storyboard: UIStoryboard) {
        let viewController = storyboard.instantiateInitialViewController()!
        self.window!.rootViewController = viewController
        self.window!.makeKeyAndVisible()
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        if self.persistentContainer.viewContext.hasChanges {
            try! self.persistentContainer.viewContext.save()
        }
    }
}
