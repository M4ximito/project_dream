    import UIKit
    import CoreData
    import SwiftUI

    class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let sleepTrackerView = SleepTrackerView()
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UIHostingController(rootView: sleepTrackerView)
            window?.makeKeyAndVisible()
            
            // Добавьте любой необходимый код конфигурации вашего приложения здесь
            
            return true
        }
        
        func applicationWillTerminate(_ application: UIApplication) {
            // Сохраните данные, если это необходимо
            self.saveContext()
        }
        
        // MARK: - Core Data stack

        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "project_dream")
            container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Не удалось загрузить стек Core Data: \(error)")
                }
            }
            return container
        }()

        // MARK: - Core Data Saving support

        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
}
