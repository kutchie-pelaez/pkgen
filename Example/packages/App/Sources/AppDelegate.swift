import UIKit
import Services
import Constants

public final class AppDelegate: UIResponder { }

// MARK: UIApplicateionDelegate

extension AppDelegate: UIApplicationDelegate {

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ExampleService.preformSomeWork(with: Constants.APIKeys.someKey)

        return true
    }
}
