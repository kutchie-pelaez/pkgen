import UIKit
import UI

public final class SceneDelegate: UIResponder {

    private var window: UIWindow?
}

// MARK: - UISceneDelegate

extension SceneDelegate: UISceneDelegate {

    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { fatalError() }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ExampleViewController()
        window.makeKeyAndVisible()

        self.window = window
    }
}
