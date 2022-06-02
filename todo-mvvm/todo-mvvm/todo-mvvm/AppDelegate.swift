import UIKit
import AppMain

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let mainContainer: MainContainer = MainContainer()
    let rootNavigation: UINavigationController = UINavigationController()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = rootNavigation
        
        rootNavigation.isNavigationBarHidden = true
        rootNavigation.pushViewController(mainContainer.makeMainViewController(), animated: true)
        return true
    }
}

