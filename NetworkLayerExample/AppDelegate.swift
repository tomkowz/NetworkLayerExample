import Network
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        NetworkLayerConfiguration.setup()
//        Demo.performSignUp()
        return true
    }
}

// Not working because there is no real server configured in
// `NetworkLayerConfiguration` class.
class Demo {
    
    class func performSignUp() {
        let user = UserItem(firstName: "Tomasz", lastName: "Szulc",
                            email: "mail@szulctomasz.com",
                            phoneNumber: "+48788434094")
        let signUpOp = SignUpOperation(user: user, password: "?8TMx6avi6}2xw&7")
        signUpOp.success = { item in
            print("User id is \(item.uniqueId)")
        }
        
        signUpOp.failure = { error in print(error.localizedDescription) }
        NetworkQueue.shared.addOperation(signUpOp)
    }
    
    class func performSignIn() {
        let signInOp = SignInOperation(email: "mail@szulctomasz.com", password: "?8TMx6avi6}2xw&7")
        signInOp.success = { item in
            print("token = \(item.token)")
            print("user id = \(item.uniqueId)")
        }
        
        signInOp.failure = { error in print(error.localizedDescription) }
        NetworkQueue.shared.addOperation(signInOp)
    }
}
