import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Utwórz instancję SleepTrackerView
        let sleepTrackerView = SleepTrackerView()
        
        // Utwórz okno i przypisz SleepTrackerView jako widok
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.rootViewController?.view = SleepTrackerViewScreen()
        window?.makeKeyAndVisible()
        
        return true
    }
}
