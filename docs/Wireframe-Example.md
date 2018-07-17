### Wireframe-Example

This simple example contains two view controllers with a button.
One has a blue and one has a green background color.
If you press the button of one controller, a controller with the other color ist presented on a navigation controller

You can find the source code for this Example in the [VISPER-Wireframe-Example](https://github.com/barteljan/VISPER/tree/master/Example/VISPER-Wireframe-Example) target.

#### Create a View Feature

Let's start with a BlueFeature.
It's a [ViewFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/ViewFeature.html) class that creates a blue view controller:


````swift
import VISPER

class BlueFeature: ViewFeature {
    
    var routePattern: String = "/Blue"
    var priority: Int = 0
    
    // return a routing option to show how this controller should be presented
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
    
    // create a blue controller which will be created when the "blue" route is called
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .blue
        return controller
    }
    
  
}
````

A [ViewFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/ViewFeature.html) consists of two key functions
[makeController(routeResult:)](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/ControllerProvider.html#/s:11VISPER_Core18ControllerProviderP04makeC0So06UIViewC0CAA11RouteResult_p05routeH0_tKF) 
and [option(routeResult:)](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/RoutingOptionProvider.html#/s:11VISPER_Core21RoutingOptionProviderP6optionAA0cD0_pSgAA11RouteResult_p05routeH0_tF).
and two key properties [routePattern](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/ViewFeature.html#/s:16VISPER_Wireframe11ViewFeatureP12routePatternSSvp) and [priority](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/ViewFeature.html#/s:16VISPER_Wireframe11ViewFeatureP8prioritySivp).

#### The routePattern property

The route pattern property returns a String which is matched by the wireframe to resolve a UIViewController to present. 

#### The priority property

The priority property describes in which order the wireframe calls the feature to resolve which UIViewController should be presented.
The heigher the priority, the earlier is a Feature called. A good default value is 0.

#### The makeController(routeResult:) function

The [makeController(routeResult:)](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/ControllerProvider.html#/s:11VISPER_Core18ControllerProviderP04makeC0So06UIViewC0CAA11RouteResult_p05routeH0_tKF) function returns a UIViewController when an URL which has been routed on our Wireframe matches the routePattern of BlueFeature.

You would call it in your application like that:

````swift
func callBlueFeature(wireframe: Wireframe) throws {
    try wireframe.route(url: URL(string: "/Blue")!)
}
````

#### The option(routeResult:) function

The [option(routeResult:)](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/RoutingOptionProvider.html#/s:11VISPER_Core21RoutingOptionProviderP6optionAA0cD0_pSgAA11RouteResult_p05routeH0_tF) function defines how your controller is presented by the wireframe.
Actually it returns a [DefaultRoutingOptionPush](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/DefaultRoutingOptionPush.html) which indicates the wireframe to push it's controllers on a wireframe.

There are several other options already included in VISPER to present a ViewController some of them are:

* [DefaultRoutingOptionModal](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/DefaultRoutingOptionModal.html) - Presents the controller as a modal. You can configure it's UIModalPresentationStyle and UIModalTransitionStyle as a property of the option instance
* [DefaultRoutingOptionReplaceTopVC](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/DefaultRoutingOptionReplaceTopVC.html) - Replaces the top view controller of your navigation controller with the controller returned by BlueFeature.
* [DefaultRoutingOptionRootVC](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/DefaultRoutingOptionRootVC.html) - Set the rootController of your navigation controller with the controller returnded by BlueFeature.


#### Configure a WireframeApplication in your AppDelegate
But how do we get a [Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/Wireframe.html) and a [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html) to route to our BlueFeature? 

Let's start with your AppDelegate:

````swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
                self.window = window
        
        //
        //we will add some code here soon
        //
        
        self.window?.makeKeyAndVisible()
        return true
    }

}
````

Add a visperApp property create a DefaultWireframeAppFactory and make a new app.

````swift
import VISPER

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApp: WireframeApp?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let factory = DefaultWireframeAppFactory()
        let visperApp = factory.makeApp()
        self.visperApp = visperApp
        
        self.window?.makeKeyAndVisible()
        return true
    }

}
````

Now add a UINavigationController on top of your window, and add ist to your application

````swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    
    let factory = DefaultWireframeAppFactory()
    let visperApp = factory.makeApp()
    self.visperApp = visperApp
    
    let navigationController = UINavigationController()
    visperApp.add(controllerToNavigate: navigationController)
    window.rootViewController = navigationController
    
    self.window?.makeKeyAndVisible()
    return true
    
}
````

Add an instance of our BlueFeature and route to it's route

````swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    
    let factory = DefaultWireframeAppFactory()
    let visperApp = factory.makeApp()
    self.visperApp = visperApp
    
    let navigationController = UINavigationController()
    visperApp.add(controllerToNavigate: navigationController)
    window.rootViewController = navigationController
    
    let blueFeature = BlueFeature()
    try! visperApp.add(feature: blueFeature)
    
    try! visperApp.wireframe.route(url: URL(string: blueFeature.routePattern)!)
    
    self.window?.makeKeyAndVisible()
    return true
}
````

If you run your project now, your app will initially show the blue UIViewController provided by our BlueFeature.

#### Route to an other controller

To route to an other controller, we need to extend our BlueFeature and add a wireframe dependency and a button which routes to a new controller if it is tapped.

 ````swift
 class BlueFeature: ViewFeature {
     
     var routePattern: String = "/Blue"
     var priority: Int = 0
     let wireframe: Wireframe
     
     init(wireframe: Wireframe){
         self.wireframe = wireframe
     }
     
     // return a routing option to show how this controller should be presented
     func makeOption(routeResult: RouteResult) -> RoutingOption {
         return DefaultRoutingOptionPush()
     }
     
     
     // create a blue controller which will be created when the "blue" route is called
     func makeController(routeResult: RouteResult) throws -> UIViewController {
         
         let controller = UIViewController()
         controller.view.backgroundColor = .blue
         
         let button = UIButton(type: .custom)
         
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("Tab here to enter a new world", for: .normal)
         
         controller.view.addSubview(button)
         
         button.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
         button.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
         
         button.addTarget(self, action: #selector(nextWorld), for: .touchUpInside)
         
         return controller
     }
     
     @objc func nextWorld() {
         try! self.wireframe.route(url: URL(string: "/Green")!)
     }
   
 }
 ````

 If you are now running your app and tap on your button a error is thrown since no feature with the route pattern green has been found. 

 
 ````swift 
 VISPER_Wireframe.DefaultWireframeError.noRoutePatternFoundFor(url: /Green, parameters: [:])
 ````

We need a second Feature to fix this error:

````swift
class GreenFeature: ViewFeature {
    
    var routePattern: String = "/Green"
    var priority: Int = 0
    let wireframe: Wireframe
    
    init(wireframe: Wireframe){
        self.wireframe = wireframe
    }
    
    // return a routing option to show how this controller should be presented
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
    
    // create a green controller which will be created when the "green" route is called
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        let controller = UIViewController()
        controller.view.backgroundColor = .green
        
        let button = UIButton(type: .custom)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tab here to enter a new world", for: .normal)
        
        controller.view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(nextWorld), for: .touchUpInside)
        
        return controller
    }
    
    @objc func nextWorld() {
        try! self.wireframe.route(url: URL(string: "/Blue")!)
    }
    
}
````

If we add an instance of GreenFeature in the AppDelegate to our App the error is gone:

 ````swift
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         
         let window = UIWindow(frame: UIScreen.main.bounds)
         self.window = window
         
         let factory = DefaultWireframeAppFactory()
         let visperApp = factory.makeApp()
         self.visperApp = visperApp
         
         let navigationController = UINavigationController()
         visperApp.add(controllerToNavigate: navigationController)
         window.rootViewController = navigationController
         
         let blueFeature = BlueFeature(wireframe: visperApp.wireframe)
         try! visperApp.add(feature: blueFeature)
         
         let greenFeature = GreenFeature(wireframe: visperApp.wireframe)
         try! visperApp.add(feature: greenFeature)
         
         try! visperApp.wireframe.route(url: URL(string: blueFeature.routePattern)!)
         
         self.window?.makeKeyAndVisible()
         return true
     }

 ````
 
 If you like colorful controllers it might be a good exercise to write a new ColoredControllerFeature, which takes a routePattern, a Color and a RouteURL as dependencies.
 Use it to replace our two redundant FeatureClasses by two instances of type ColoredControllerFeature. 