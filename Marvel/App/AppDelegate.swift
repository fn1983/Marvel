import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainViewController.instantiate()
        window?.makeKeyAndVisible()
        return true
    }
}
