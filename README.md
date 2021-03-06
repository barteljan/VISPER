# VISPER

[![Version](https://img.shields.io/cocoapods/v/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![License](https://img.shields.io/cocoapods/l/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![Platform](https://img.shields.io/cocoapods/p/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)

VISPER is a component based library, which helps you to develop modular apps based on the VIPER Pattern.
VISPER contains several components to create a flexibel architecture without losing too much time with VIPER.

The architecture of an typical app, build with VISPER, is shown in the image below.

Well ok ... we know that looks a bit complicated.

We created a seperate article to dig deeper into this topic. You can find it [here](docs/Architecture.md). 

![Architecture](docs/img/VISPER.png)

The easiest way to get good grasp of how VISPER can help you building an app, is by having a look at it's main components.

The most general component is the [App](#app) protocol, which helps you to compose your app of seperated modules 
called [Features](#features-and-featureobserver). Each Feature creates and configures a distinct part of your application.  

Since the presentation, creation and management of ViewControllers ist an important part of your application, 
there should be a seperate component responsible for the presentation and the lifecycle of your ViewControllers. 
This job is done by the [Wireframe](#wireframe).  

The [Wireframe](#wireframe) allows you to route to a specific ViewController by an simple URL (called Route).
It seperates the creation of a ViewController (done by a [ViewFeature](#wireframe)), 
from it's presentation (done by some weird guy named [RoutingPresenter](#wireframe)).

Since we fought too many fights against massive ViewControllers, we want our view to be quite stupid. 
This prepares the stage for the [Presenter](#wireframe). The wireframe requests all responsible [Presenters](#wireframe) 
from a [PresenterFeature](#wireframe) before presenting a ViewController. It gives them the possibillity to enrich that 
stupid thing with some data bindings and behaviour before it is actually presented. 

The next great challenge is controlling the state of your application. VISPER decides to do that in the interactor 
layer and supports you with an [Redux-Architecture](#visper-redux) to manage your appstate and it's state transitions.

You can trigger state change in a presenter by submitting an [Action](#changing-state) to an [ActionDispatcher](#changing-state) and observe the changing state on the other hand to update your views. More on that topic can be found [here](#visper-redux).

## Index

- [VISPER](#visper)
  * [Getting started](#getting-started)
    + [Getting started with the wireframe](#getting-started-with-the-wireframe)
    + [Adding a Presenter](#adding-a-presenter)
    + [Adding Redux](#adding-redux)
  * [Components](#components)
    + [App](#app)
    + [Features and FeatureObserver](#features-and-featureobserver)
    + [Wireframe](#wireframe)
    + [Routepatterns](#routepatterns)
    + [VISPER-Redux](#visper-redux)
      - [State](#state)
      - [AppReducer](#appreducer)
      - [ReduxApp](#reduxapp)
      - [Changing state](#changing-state)
      - [Reducer](#reducer)
        * [ReduceFuntion](#reducefuntion)
        * [FunctionalReducer](#functionalreducer)
        * [ActionReducerType](#actionreducertype)
        * [AsyncActionReducerType](#asyncactionreducertype)
      - [LogicFeature](#logicfeature)
      - [Observing state change](#observing-state-change)
      - [SubscriptionReferenceBag](#subscriptionreferencebag)
  * [Complete list of all available VISPER-Components](#complete-list-of-all-available-visper-components)

## Getting started 

Since VISPER is composed of several independent components which can be used seperatly, let's take it easy and start 
just with an WireframeApp, to get a grasp about how the the routing and the lifecycle of your ViewControllers works. 

We will extend this example with some redux stuff in the next steps. 

### Getting started with the wireframe

Start with creating a simple project which uses a UINavigationController. 

> SPOILER: VISPER can manage any container view controller of your choice, but since UINavigationController is preconfigured in the default 
> implementation it's easy to start with it.

Now create a WireframeApp in your AppDelegate:

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApp: WireframeApp!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let factory = DefaultWireframeAppFactory()
        let visperApp = factory.makeApp()
        self.visperApp = visperApp
        
        // the rest of your implementation will follow soon ;)    
    }

```

The DefaultWireframeAppFactory creates an WireframeApp which is already configured for use with an UINavigationController. 
If you want to know more about the Wireframe you can find this information [here](#wireframe), but let's finish the WireframeApp 
creation for the moment. 

In the next step you have to tell your WireframeApp which UINavigationController should be used for navigation and routing. 
We need just one line for that ....

```swift 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //just imagine we created your visperApp here
    
    let navigationController = UINavigationController()
    window.rootViewController = navigationController
    
    //tell visper to work with this UINavigationController
    visperApp.navigateOn(navigationController)
        
}

```

As you might guess, it's completly irrelevant where our UINavigationController lives, it would also be possible to put 
it in an UITabbarController or an UISplitViewController. VISPER will just use the last UINavigationController given to it 
by the visperApp.navigateOn(controller) method. 

It will not retain it for you! So if it becomes unretained, it will be gone and VISPER will complain about knowing no 
UINavigationController to use!  

Your WireframeApp is now initialised and eager to route, but it has no ViewController to create, so let's create a 
ViewFeature to create some action ... 

The controller can just be a POVC (Plain Old View Controller :sweat_smile: ), it doesn't have to know anything about VISPER.
So let's create one:

```swift 
class StartViewController: UIViewController {
 
    typealias ButtonTap = (_ sender: UIButton) -> Void
    
    weak var button: UIButton! {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    var buttonTitle: String? {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    var tapEvent: ButtonTap?
    
    override func loadView() {
        
        let view = UIView()
        self.view = view
        
        let button = UIButton()
        self.button = button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.tapped(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
    }
    
    @objc func tapped(sender: UIButton) {
        self.tapEvent?(sender)
    }
    
}
```

Ok let's not complain, this is a really stupid controller and it isn't even beautiful ...
but sometimes all you need is someone who can be shown around and is willing to help .... 

So let's just use him and put him into a ViewFeature.

> **SPOILER**: A ViewFeature is a protocol from the "VISPER_Wireframe"-Pod which has to be implemented to provide a ViewController to the wireframe.
> We have defined some typealiases in the VISPER-Pod to provide it with an "import VISPER" statement. 
> Thats's an dirty trick, but it allows you to use the "import VISPER" statement for every VISPER class or protocol even if it lives in one of our child pods.  


```swift
import VISPER

class StartFeature: ViewFeature {
    
    let routePattern: String
    
    // you can ignore the priority for the moment
    // it is sometimes needed when you want to "override"
    // an already added Feature
    let priority: Int = 0
    
    init(routePattern: String){
        self.routePattern = routePattern
    }
    
    // create a blue controller which will be created when the "blue" route is called
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        let controller = StartViewController()
        controller.buttonTitle = "Hello unknown User!"
        return controller
    }
    
    // return a routing option to show how this controller should be presented
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
}
```

As you might see there are two methods and a property which have to be implemented to provide a ViewController to the Wireframe.

Let's start with the routePattern. It is an String that describes the route used to match this controller.

That means the routePattern `var routePattern: String = "/start"` will be matched by the url `var url = URL(string: "/start")` ...
starts easy but ends complicated ... routePatterns can contain variables, wildcards and other stuff (You can find more about them 
in the [RoutePattern](#routepatterns) section), let's pretend for the moment that we have a complete understanding about how they work :grimacing: .

The next method is quite straight forward, the `makeController(routeResult: RouteResult) -> UIViewController` function should 
just create the viewController to be presented when `wireframe.route(url: URL('/start')!)` is called anywhere in our app 
(pretending that our routePattern is "/start"). 

It's routeResult-Parameter contains some context information that might be useful when creating a ViewController, 
although we don't need it here (have a look at the [RouteResult](#routeresult) section later :wink: ).

The `makeOption(routeResult:)` is a little more complicated (have a look at the [RoutingOption](#routingoption) section, when needed).
It defines how the wireframe should present the ViewController by default. Returning a `DefaultRoutingOptionPush` will result in 
the wireframe just pushing our ViewController to it's current UINavigationController.

Ok that was easy :innocent: , let's register our new feature in our app ...
go back to your AppDelegate and add it:


```swift 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //just imagine we created and initialized your visperApp here
    
     let startFeature = StartFeature(routePattern: "/start")
     try! visperApp.add(feature: startFeature)
        
}
```

The visperApp will now register our feature for the "/start" route, which enables us to route to it with an other line of code:

 ```swift 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
     //just imagine we created and initialized your visperApp here
     
      let startFeature = StartFeature(routePattern: "/start")
      try! visperApp.add(feature: startFeature)
      
      try! visperApp.wireframe.route(url: URL(string: "/start")!)
      
      self.window?.makeKeyAndVisible()
 }
 ```

The full code of your AppDelegate should now look like that:


 ```swift 
 import UIKit
 import VISPER
 
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
 
     var window: UIWindow?
     var visperApp: WireframeApp!
 
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         
         let window = UIWindow(frame: UIScreen.main.bounds)
         self.window = window
         
         let factory = DefaultWireframeAppFactory()
         let visperApp = factory.makeApp()
         self.visperApp = visperApp
         
         let navigationController = UINavigationController()
         window.rootViewController = navigationController
         visperApp.navigateOn(navigationController)
         
         let startFeature = StartFeature(routePattern: "/start")
         try! visperApp.add(feature: startFeature)
     
         try! visperApp.wireframe.route(url: URL(string: "/start")!)
         
         self.window?.makeKeyAndVisible()
         return true
     }
 
 }
 ```

And if you start your app ... "drum roll" ... you will see a absolutly useless ugly black ViewController with a centered UIButton.
But that's great :blush: , let's add some functionality :heart_eyes_cat:.

### Adding a Presenter
 
Managing application logic, needs a smart guy who knows something about his environment, so that's obviously not our 
stupid ViewController, he wouldn't be able to cope with anything other than views ...

What we need is someone who connects the stupid view with our one-trick ponys in the interactor and wireframe layer.
We get that with a [Presenter](#wireframe).

The Presenter-Protocol is quite simple:

```swift
protocol Presenter {
    func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool
    func addPresentationLogic( routeResult: RouteResult, controller: UIViewController) throws
}
``` 

So let's create one that is capable of configuring our controller.

```swift
class StartPresenter: Presenter {
    
    var userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        return controller is StartViewController
    }
    
    func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        
        guard let controller = controller as? StartViewController else {
            fatalError("needs a StartViewController")
        }
        
        controller.buttonTitle = "Hello \(self.userName)"
        
        controller.tapEvent = { _ in
            print("Nice to meet you \(self.userName)!")
        }
        
    }
}
```

The presenter is responsible for a ViewController of class StartViewController, adds some information to the buttonTitle,
and some behaviour to the buttons tap event.

Let's pretend that our presenter gets the information about the users name as a dependency from it's environment, we will 
add that information later in the interactor/redux layer. 

To add the presenter to our application all we need to do is to extend our StartFeature with the new protocol `PresenterFeature`

```swift
extension StartFeature: PresenterFeature {
    func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        return [StartPresenter(userName: "unknown guy")]
    }    
}
```

and remove the following disgusting line from our StartFeature (it should create components, adding some data is presenter work )
```swift
func makeController(routeResult: RouteResult) throws -> UIViewController {
    let controller = StartViewController()
    // remove the following line, our feature shouldn't care about usernames ...
    // controller.buttonTitle = "Hello unknown User!"
    return controller
}
```

Tapping the view button will now result in the debug output "Nice to meet you unknown guy!", but wouldn't it be nicer to present an 
alert message with this message?

Challenge accepted ?

Let's start with creating a new Feature creating a UIAlertController showing ...

```swift
class MessageFeature: ViewFeature {
    
    var routePattern: String = "/message/:username"
    var priority: Int = 0
    
    
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        let username: String = routeResult.parameters["username"] as? String ?? "unknown"
        
        let alert = UIAlertController(title: nil,
                                    message: "Nice to meet you \(username.removingPercentEncoding!)",
                             preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Goodbye", style: .cancel, handler: nil))
        
        return alert
    }
    
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionModal(animated: true,
                                         presentationStyle: .popover)
    }
    
}

```

There is happening a lot here, so let's check what we have done ...

First have a look at the route pattern `/message/:username`, it is not a common matchable string.
The `:username` defines a routing parameter called `'username'`. This route would be matched by any URL starting with 
`/message/` with the second part being interpreted as the routing parameter `username`. 
If your routing URL would be `URL(string: '/message/Max%20Mustermann')` the routing parameter `'username'` would be 
`'Max Mustermann'`. 

Second the `makeController(routeResult:)` function extracts the routing parameter `'username'` from it's RoutingResult.

And at last, the `makeOption(routeResult:)` function creates a `DefaultRoutingOptionModal`, which results in the wireframe 
presenting the alert as an modal view controller with presentation style `.popover`.  

After having realized all that, it is time to add the new feature in the `AppDelegate` to our `WireframeApp`. 

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //imagine visperApp is already initialized 
              
        let messageFeature = MessageFeature()
        try! visperApp.add(feature: messageFeature)
        
        //followed by other stuff
}
```

And to modify our `StartPresenter` to use a `Wireframe` to route to the message feature.

```swift
class StartPresenter: Presenter {
    
    var userName: String
    let wireframe: Wireframe
    
    init(userName: String, wireframe: Wireframe) {
        self.userName = userName
        self.wireframe = wireframe
    }
    
    func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        
        guard let controller = controller as? StartViewController else {
            fatalError("needs a StartViewController")
        }
        
        controller.buttonTitle = "Hello \(self.userName)"
        
        controller.tapEvent = { [weak self] (_) in
            guard let presenter = self else { return }
            let path = "/message/\(presenter.userName)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            let url = URL(string:path)
            try! presenter.wireframe.route(url: url!)
        }
        
    }
}
``` 

The exiting stuff happens in the `tapEvent` closure.
The presenter creates an `URL(string:"/message/unknown%20guy")` and tells the wireframe 
to route to this URL (if we pretend that username is still `"unknown guy"`).

The wireframe matches the URL to the routePattern of our `MessageFeature`, asks it for creating the ViewController
and presents it by interpreting the `RoutingOption` given by the `MessageFeature`.   

And voila! An alert view greeting us is shown.

Quite a lot stuff going on, just for an AlertViewController. 
But it scales quite good with greater ViewControllers, 
helping you to keep them simple, seperated and with an clean architecture keeping presentation and domain logic 
out of the ViewController and on it's place.   

Do you remember that our StartPresenter doesn't really know from where it should retrieve the username ?
The reason for this problem that this example doesn't contain a real interactor layer.
We will solve this problem by adding a [Redux](#visper-redux) architecture to this example in the next chapter. 

**You can find the code for this tutorial in the Wireframe-Example in the VISPER.xcworkspace.**  

### Adding Redux

> **SPOILER**: You can use the code from the Wireframe-Example in the VISPER.xcworkspace as a starting point for this tutorial if 
> you didn't complete the last chapter. You have to replace the "Wireframe-Example" section in the Podfile of this 
> workspace with the following code to do that:
> ```swift
> target 'VISPER-Wireframe-Example' do
>    pod 'VISPER-Wireframe', :path => '../'
>    pod 'VISPER-Core', :path => '../'
>    pod 'VISPER-UIViewController', :path => '../'
>    pod 'VISPER-Objc', :path => '../'
>    pod 'VISPER', :path => '../'
> end   
> ```
> run `pod install` after that.

If Redux is a new concept to you, start with reading the two following articles.

 * [A cartoon guide to Flux](https://code-cartoons.com/a-cartoon-guide-to-flux-6157355ab207)
 * [A cartoon intro into Redux](https://code-cartoons.com/a-cartoon-intro-to-redux-3afb775501a6)

 
If you already know Redux but did not comprehend all of it's details think about reading them too :stuck_out_tongue:.

After finishing that have a short look on the project from the last chapter and create two States.

```swift
struct UserState: Equatable {
    let userName: String
}

struct AppState: Equatable {
    let userState: UserState?
}
```

> **SPOILER**: It's a not necessary but good practice to make your AppState conform to Equatable, since this makes the handling of state changes easier.


The AppState should contain the full state of our app. 
Since the state of an whole app can become quite complex, it is best practice to compose it of different 
substates to conquer state complexity in a more locale manner.

Although our state isn't really complex it's a good idea to start it this way, to demonstrate how state 
composition could be done if it would be needed.

The next step should be replacing our [WireframeApp](#app) with an [AnyVISPERApp\<AppState\>](#app).
This gives us an `Redux` object to manage our state changes. 

Start with creating a new method in your AppDelegate:

```swift
func createApp() -> AnyVISPERApp<AppState> {
    fatalError("not implemented")
}
```

continue with creating an initial state used when the app is loaded:

```swift
let initalState: AppState = AppState(userState: UserState(userName: "unknown stranger"))
``` 


Now it's time to write some boilerplate code and write the [AppReducer](#visper-redux), a function responsible 
for composing and reducing our AppState.       
 
```swift
let appReducer: AppReducer<AppState> = { (reducerProvider: ReducerProvider, action: Action, state: AppState) -> AppState in
    let newState = AppState(userState: reducerProvider.reduce(action: action, state: state.userState))
    return reducerProvider.reduce(action: action, state: newState)
}
``` 

It's structure is always the same, it creates a new AppState and reduces all substate with it's reducerProvider parameter.
After that it reduces the newly created state itself with the reducer provider and returns the result.

> **SPOILER**: We would love to do this programatically for you, but since a composed appstate is an generic struct 
> and there is no way to create such a struct dynamically we are just f***ed here. Our best guess is to generate the 
> AppReducer with [Sourcery](https://github.com/krzysztofzablocki/Sourcery) you can find an tutorial to do that [here](docs/README-VISPER-Sourcery.md).

Now create a `VISPERAppFactory<AppState>` create your app and return it.
The complete `createApp()` function should now look like that.

```swift
func createApp() -> AnyVISPERApp<AppState> {
    let initalState: AppState = AppState(userState: UserState(userName: "unknown stranger"))
    
    let appReducer: AppReducer<AppState> = { (reducerProvider: ReducerProvider, action: Action, state: AppState) -> AppState in
        let newState = AppState(userState: reducerProvider.reduce(action: action, state: state.userState))
        return reducerProvider.reduce(action: action, state: newState)
    }
    
    let appFactory = VISPERAppFactory<AppState>()
    return appFactory.makeApplication(initialState: initalState, appReducer: appReducer)
}
```

As next step change the Type of your visperApp property to AnyVISPERApp<AppState> and 
initialize it with your newly crafted `createApp()` function.

Your `AppDelegate` should now look like that:

```swift 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var visperApp: AnyVISPERApp<AppState>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.visperApp = self.createApp()
        
        //imagine you initialized your features here
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func createApp() -> AnyVISPERApp<AppState> {
        let initalState: AppState = AppState(userState: UserState(userName: "unknown stranger"))
        
        let appReducer: AppReducer<AppState> = { (reducerProvider: ReducerProvider, action: Action, state: AppState) -> AppState in
            let newState = AppState(userState: reducerProvider.reduce(action: action, state: state.userState))
            return reducerProvider.reduce(action: action, state: newState)
        }
        
        let appFactory = VISPERAppFactory<AppState>()
        return appFactory.makeApplication(initialState: initalState, appReducer: appReducer)
    }
    
}
``` 

Wow that was a lot stuff to get it running ...

It's getting better now :blush:. 

It's time to make you and our `StartPresenter` happy by giving him access to the state.

We start that process with changing it's `userName` property type from `String` to `ObservableProperty<String>`.
 
An ObservableProperty is a ValueWrapper that can notify you when it's value is changed.

```swift
class StartPresenter: Presenter {
    
    var userName: ObservableProperty<String>
    let wireframe: Wireframe
    var referenceBag = SubscriptionReferenceBag()

    init(userName: ObservableProperty<String?>, wireframe: Wireframe) {
        
        //map our AppState ObservableProperty from String? to String
        self.userName = userName.map({ (name) -> String in
            guard let name = name, name.count > 0 else { return "unknown person"}
            return name
        })
        
        self.wireframe = wireframe
    }

    // you already know the rest :P of it's implementation
    ...    
}
```

As you might notice we added another property of type [SubscriptionReferenceBag](#subscriptionreferencebag).
We will use that to subscribe to the property and store that subscription as 
long as the presenter exists (which should be as long as it's controller exists).
Check the [SubscriptionReferenceBag](#subscriptionreferencebag) section if you wanne know more about that.

```swift
func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
    
   guard let controller = controller as? StartViewController else {
       fatalError("needs a StartViewController")
   }
    
   let subscription = self.userName.subscribe { (value) in
               controller.buttonTitle = "Hello \(value)"
           }
   self.referenceBag.addReference(reference: subscription)
    
   controller.tapEvent = { [weak self] (_) in
        guard let presenter = self else { return }
        let path = "/message/\(presenter.userName.value)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let url = URL(string:path)
        try! presenter.wireframe.route(url: url!)
   }
}
```

As a result the buttons title will now be changed when the username has been changed.
Since we changed the url path in `tapEvent` from `presenter.userName` to `presenter.userName.value`, even the MessageFeature behaves already
correctly and uses the name from our appstate.    

When you are trying to build your project now, you will get some errors, because the constructor of `StartPresenter` 
changed. It want's to have `ObservableProperty<String?> parameter now.

Let's change that by injecting such a property into the `StartFeature` and your `StartPresenter`.

```swift
class StartFeature: ViewFeature {
    
    let routePattern: String
    
    let priority: Int = 0
    let wireframe: Wireframe
    let userName: ObservableProperty<String>
    
    init(routePattern: String, wireframe: Wireframe,userName: ObservableProperty<String>){
        self.routePattern = routePattern
        self.wireframe = wireframe
        self.userName = userName
    }
    
    // imagine the ViewFeature functions here
}


extension StartFeature: PresenterFeature {
    
    func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        return [StartPresenter(userName: self.userName, wireframe: self.wireframe)]
    }
    
}
```

We will use map to inject it to the `StartFeature` in your `AppDelegate`.

```swift
let startFeature = StartFeature(routePattern: "/start",
                                   wireframe: visperApp.wireframe,
                                    userName: visperApp.redux.store.observableState.map({ return $0.userState.userName ?? "Unknown Person"}))
```
 
Building the app now results in an running application using the appstate as it's reactive datasource.

Well having a reactive datasource is quite boring if your state isn't changing.
Time to introduce some state change.

We are starting by adding an input field to our StartViewController:

```swift 
class StartViewController: UIViewController, UITextFieldDelegate {
    
    typealias ButtonTap = (_ sender: UIButton) -> Void
    typealias NameChanged = (_ sender: UITextField, _ username: String?) -> Void
    
    weak var button: UIButton! {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    weak var nameField: UITextField?
    
    var buttonTitle: String? {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }

    var tapEvent: ButtonTap?
    var nameChanged: NameChanged?
    
    override func loadView() {
        
        let view = UIView()
        self.view = view
        
        let nameField = UITextField(frame: .null)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        self.nameField = nameField
        self.navigationItem.titleView = nameField
        nameField.placeholder = "enter your username here"
        nameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        nameField.backgroundColor = .white
        
        let button = UIButton()
        self.button = button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.tapped(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
     
    }
    
    @objc func tapped(sender: UIButton) {
        self.tapEvent?(sender)
    }
    
    @objc func textFieldChanged(textField: UITextField) {
        self.nameChanged?(textField, textField.text)
    }
    
}
```

There's nothing magically happening here, it's just our plain old UIViewController with a button and an UITextField
in it's title view. Now we wanne to change our appstate if you enter your username in the text field.
Since our view should only care about viewing stuff and responding to userinput, triggering state change should be done in the presenter.

The presenter triggers a state change by dispatching an [Action](#changing-state) (a simple message object)  to an [ActionDispatcher](#changing-state) (read more about it [here](#changing-state)).
So let's provide him with such a thing:

```swift
class StartPresenter: Presenter {
    
    //
    // imagine some old properties here ...
    // 
    let actionDipatcher: ActionDispatcher
    

    init(userName: ObservableProperty<String?>, 
        wireframe: Wireframe, 
  actionDipatcher: ActionDispatcher) {
        
        //use map to translate from ObservableProperty<String?> to ObservableProperty<String>
        self.userName = userName.map({ (name) -> String in
            guard let name = name, name.count > 0 else { return "unknown person"}
            return name
        })
        
        self.wireframe = wireframe
        
        //this one is new
        self.actionDipatcher = actionDipatcher
    }
    
    //you already know the rest of our StartPresenter
}
```  

Since we now need an [ActionDispatcher](#changing-state) to initialize the presenter, let's give it to our `StartFeature` too:

```swift
class StartFeature: ViewFeature {
    
    //
    // imagine some old properties here ...
    // 
    let actionDispatcher: ActionDispatcher
    
    init(routePattern: String, 
            wireframe: Wireframe,
     actionDispatcher: ActionDispatcher, 
             userName: ObservableProperty<String?>){
        self.routePattern = routePattern
        self.wireframe = wireframe
        self.userName = userName
        self.actionDispatcher = actionDispatcher
    }
    
    //
    // and the rest of it's implementation following here ...
    // 
}

extension StartFeature: PresenterFeature {
    
    func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        return [StartPresenter(userName: self.userName, 
                              wireframe: self.wireframe, 
                        actionDipatcher: self.actionDispatcher)]
    }
    
}
```   

and inject it in our AppDelegate

````swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //
    // some intialization before ...
    //
       
    let startFeature = StartFeature(routePattern: "/start",
                                       wireframe: visperApp.wireframe,
                                actionDispatcher: visperApp.redux.actionDispatcher,
                                        userName: visperApp.redux.store.observableState.map({ return $0.userState.userName }))
    try! visperApp.add(feature: startFeature)
    
    //
    // some routing afterwards ...
    //
}
````

Now we need an Action to be dispatched by the `StartPresenter`:

```swift
struct ChangeUserNameAction: Action {
    let username: String?
}
```

It's just a very simple struct 'carring' (some people would say 'messaging') our username string to 
the reducers changing the app state. 

Dispatching it in the presenter is easy:

```swift
func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
    
    guard let controller = controller as? StartViewController else {
        fatalError("needs a StartViewController")
    }
    
    //ignore the whole view observing stuff normally done here
    
    controller.nameChanged = { [weak self](_, text) in
        self?.actionDipatcher.dispatch(ChangeUserNameAction(username: text))
    }
}
```

You can build your app now, but the appstate isn't changed if you enter your username. 

So what f*ck is that?

Well, there's just no [Reducer](#reducer) handling the change of the `UserState` (and as a result the AppState), 
when receiving an `ChangeUserNameAction`.

But there's hope, building such a thing is easy (it can even be generated by [Sourcery](docs/README-VISPER-Sourcery.md)):


```swift
struct ChangeUserNameReducer: ActionReducerType {

    typealias ReducerStateType = UserState
    typealias ReducerActionType = ChangeUserNameAction
    
    func reduce(provider: ReducerProvider, action: ChangeUserNameAction, state: UserState) -> UserState {
        return UserState(userName: action.username)
    }
}
```

after adding it in your StartFeature, it's done:

```swift
extension StartFeature: LogicFeature {
    func injectReducers(container: ReducerContainer) {
        container.addReducer(reducer: ChangeUserNameReducer())
    }
}
```

Starting your app should now result in an reactive app changing the title of your button while 
you are entering your username. 

**You can find the code for this tutorial in the VISPER-Swift-Example in the VISPER.xcworkspace.**

## Components

### App

The core component of your VISPER application is an instance of the [App](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/App.html)
protocol, which allows you to configure your application by a [Feature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols.html#/s:11VISPER_Core7FeatureP) which represents a distinct functionality of your app and 
configures all VISPER components used by it.

The definition of the [App](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/App.html) protocol is quite simple:

````swift
public protocol App {

    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    func add(feature: Feature) throws

    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    func add(featureObserver: FeatureObserver)

}
````

### Features and FeatureObserver

You can basicly add some [FeatureObservers](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/FeatureObserver.html) and [Features](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols.html#/s:11VISPER_Core7FeatureP) to an [App](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/App.html).

A [FeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/FeatureObserver.html) will be called whenever a [Feature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols.html#/s:11VISPER_Core7FeatureP) is added and is responsible for configuring your VISPER components to provide the functionality implemented by your [Feature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols.html#/s:11VISPER_Core7FeatureP).

Many VISPER Components implement their own subtypes of [App](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/App.html), [Feature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols.html#/s:11VISPER_Core7FeatureP) and [FeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/FeatureObserver.html).

[VISPER-Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/index.html) provides you with: 
* [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html) 
* [ViewFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/ViewFeature.html) 
* [PresenterFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/PresenterFeature.html)
* [WireframeFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeFeatureObserver.html)
* [ViewFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/ViewFeatureObserver.html) 
* [PresenterFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/PresenterFeatureObserver.html).

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) provides you with: 
* [ReduxApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ReduxApp.html) 
* [LogicFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/LogicFeature.html) 
* [LogicFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Structs/LogicFeatureObserver.html).

[VISPER-Swift](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Swift/index.html) provides you with a [VISPERApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Swift/Classes/VISPERApp.html) which combines all characteristics of a [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html) and a [ReduxApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ReduxApp.html) and is used in the most Apps build with the VISPER-Framework.

### Wireframe

The [Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/Wireframe.html) manages the lifecycle of UIViewController in an VISPER-Application. 
It is used to create controllers and to route from one controller to an other. It seperates the ViewController presentation and creation logic from the UIViewController itself.

The [VISPER-Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/index.html) component contains an implementation of the [Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/Wireframe.html)-Protocol.  

You can use the [DefaultWireframeAppFactory](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Classes/DefaultWireframeAppFactory.html) to create a [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html) with a default configuration:

````swift
let navigationController = UINavigationController()
let factory = DefaultWireframeAppFactory()
let wireframeApp = factory.makeApp()
wireframeApp.navigateOn(navigationController)
````

if you want to create a [Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/Wireframe.html) without creating a [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html) use the [WireframeFactory](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Classes/WireframeFactory.html).

````swift
let factory = WireframeFactory()
let wireframe = factory.makeWireframe()
````

Now create a ViewFeature which provides a ViewController and some RoutingOptions, to define how the controller will be presented, to your wireframe.

````swift
class ExampleViewFeature: ViewFeature {

    var routePattern: String = "/exampleView"
    var priority: Int = 0

    //controller will be pushed on current active navigation controller 
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }

    func makeController(routeResult: RouteResult) throws -> UIViewController {
        let controller = UIViewController()
        return controller
    }
}
````

Add it to your [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html)

````swift
let feature = ExampleFeature()
wireframeApp.add(feature: feature)
````

or to your [Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/Wireframe.html)

````swift
let feature = ExampleFeature()
wireframe.add(controllerProvider: feature, priority: feature.priority)
wireframe.add(optionProvider: feature, priority: feature.priority)
try wireframe.add(routePattern: feature.routePattern)
````

You can now route to the controller provided by the ExampleFeature:
````swift
try wireframe.route(url: URL(string: "/exampleView")!)
````

[Here ist a full example using VISPER with a wireframe](docs/Wireframe-Example.md)

### Routepatterns

Has to be documented have a look at [JLRoutes](https://github.com/joeldev/JLRoutes) definition of RoutePatterns (we stole the idea from them some time ago).

### VISPER-Redux

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) is an implementation of the redux-architecture in swift. 

It provides you with an app architecture to tackle the problem 
of distributed app state and state changes. It is the implementaion 
of the interactor layer in many Apps based on the VISPER Framework.

If you want to learn more about redux, have a look at the following tutorials and documentations:

* [A cartoon guide to Flux](https://code-cartoons.com/a-cartoon-guide-to-flux-6157355ab207)
* [A cartoon Intro to Redux](https://code-cartoons.com/a-cartoon-intro-to-redux-3afb775501a6)
* [redux.js Documentation](http://redux.js.org/docs/introduction/)

A comprehensive introduction about [VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) can be found [here](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html).

#### State

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) stores the complete state of your app in a central struct to create a transparent representation of the current state of your different app components.

A typical composite app state for an app to manage your todos in the next week might look like that: 

```swift
struct AppState {
    var userState: UserState
    var todoListState: TodoListState
    var imprintState: ImprintState
}
```

with some composite sub states:

```swift
    struct UserState {
    var userName: String
    var isAuthenticated: Bool
}
```

```swift
struct TodoListState {
    var todos: [Todo]
}
```
```swift
struct ImprintState {
    var text: String
    var didAlreadyRead: Bool
}
```


#### AppReducer

Each store has a special reducer with the following definition:

```swift
public typealias AppReducer<State> = (_ ReducerProvider: ReducerProvider,_ action: Action, _ state: State) -> State
```

It is used as a single entrypoint to the store.
It is called whenever a action is dispatched, to resolve a new state.
Since our state is generic it is necessary to delegate the creation of each state property to the reducerProvider parameter.

An AppReducer for the previously defined AppState should look like that:

```swift
let appReducer = { (reducerProvider: ReducerProvider, action: Action, currentState: AppState) -> AppState in
    let state = AppState(
        userState: reducerProvider.reduce(action,currentState.userState),
        todoListState: reducerProvider.reduce(action,currentState.todoListState),
        imprintState : reducerProvider.reduce(action,currentState.imprintState)
    )
    return reducerProvider.reduce(action,state)
}
```

#### ReduxApp

Createing an redux app is simple

```swift
let appState: AppState = AppState( ... create your state here ...)
let factory = ReduxAppFactory()
let app: ReduxApp<AppState> = factory.makeApplication(initialState: appState, appReducer: appReducer)
```

#### Changing state 

The current state in an app using [VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) 
is stored in a central [Store](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Classes/Store.html) 
instance, which lives in a convinience wrapper object of type [Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Classes/Redux.html). 
State change can only be achieved by dispatching an action (a simple message object) at the [ActionDispatcher](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/Protocols/ActionDispatcher.html),
and creating a modified new state in a Reducer (A reduce-function or an instance of type [FunctionalReducer](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Structs/FunctionalReducer.html),[ActionReducerType](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ActionReducerType.html) 
or [AsyncActionReducerType](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/AsyncActionReducerType.html)).

A reduce-function has the following form (where ActionType and StateType are generic types of type Action and Any):

```swift
(_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType
```

the reduce-function/reducer will be applied to all actions of type ActionType and to all states of type StateType.
A reducer can be added to your redux architecture by adding it to the reducer container.

```swift
// add a reduce function
app.redux.reducerContainer.addReduceFunction(...)
```

```swift
// add a action reducer instance
app.redux.reducerContainer.addReducer(...)
```

An action is just an simple object conforming to the empty protocol Action, for example:

```swift
struct SetUsernameAction: Action {
    var newUsername: String
}

let action = SetUsernameAction(newUsername: "Max Mustermann")
app.redux.actionDispatcher.dispatch(action)
```

#### Reducer 

Reducers specify how the application's state changes in response to actions sent to the store. Remember that actions only describe what happened, but don't describe how the application's state changes.
A reducer in VISPER swift could be a reduce-function, or an instance of type [FunctionalReducer](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Structs/FunctionalReducer.html),[ActionReducerType](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ActionReducerType.html)                                                                               
or [AsyncActionReducerType](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/AsyncActionReducerType.html).

##### ReduceFuntion

A reduce funtion is just a simple function getting a provider, an action and an state, and returning a new state of the same type.
```swift
let reduceFunction = { (provider: ReducerProvider, action: SetUsernameAction, state: UserState) -> UserState in
    return UserState(userName: action.newUsername,
              isAuthenticated: state.isAuthenticated)
}
reducerContainer.addReduceFunction(reduceFunction:reduceFunction)
```

##### FunctionalReducer
A functional reducer is quite similar, just a reducer taking a reduce function and using it to reduce a state.

```swift
let functionalReducer = FunctionalReducer(reduceFunction: reduceFunction)
reducerContainer.addReducer(reducer:functionalReducer)
```

##### ActionReducerType

An action type reducer is a class of type ActionReducerType which contains a reduce function for a specific action and state type.

```swift
struct SetUsernameReducer: ActionReducerType {

    typealias ReducerStateType  = UserState
    typealias ReducerActionType = SetUsernameAction

    func reduce(provider: ReducerProvider,
                  action: SetUsernameAction,
                   state: UserState) -> UserState {
                   
                   return UserState(userName: action.newUsername,
                             isAuthenticated: state.isAuthenticated)
    }
}

let reducer = SetUsernameReducer()
reducerContainer.addReducer(reducer:reducer)
```

##### AsyncActionReducerType

An async reducer is an reducer of AsyncActionReducerType which does not return a new state, but calls a completion with a new state.

```swift
struct SetUsernameReducer: AsyncActionReducer {

    typealias ReducerStateType  = UserState
    typealias ReducerActionType = SetUsernameAction

    let currentState: ObserveableProperty<UserState>

    func reduce(provider: ReducerProvider,
                  action: SetUsernameAction,
              completion: @escaping (_ newState: UserState) -> Void) {
        let newState =  UserState(userName: action.newUsername,
        isAuthenticated: self.currentState.value.isAuthenticated)
        completion(newState)
    }
}


let reducer = SetUsernameReducer(currentState: app.state.map{ $0.userState })
reducerContainer.addReducer(reducer:reducer)
```

#### LogicFeature

You can use a LogicFeature to add some reducers to your app.

````swift
import VISPER_Redux

class ExampleLogicFeature: LogicFeature {

    func injectReducers(container: ReducerContainer) {
        let reducer = SetUsernameReducer()
        container.addReducer(reducer: incrementReducer)
    }

}


let logicFeature = ExampleLogicFeature()
app.add(feature: let logicFeature)

````

#### Observing state change

Observing state change ist simple. Just observe the state of your app:

```swift

//get your reference bag to retain subscription
let referenceBag: SubscriptionReferenceBag = self.referenceBag


//subscribe to the state
let subscription = app.state.subscribe { appState in
    print("New username is:\(appState.userState.userName)")                                   
}

//retain subscription in your reference bag
referenceBag.addReference(reference: subscription)
```

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) contains a [ObservableProperty<AppState>](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/Classes/ObservableProperty.html) to represent the changing AppState.
[ObservableProperty](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/Classes/ObservableProperty.html) allows you to subscribe for state changes, and can be mapped to a RxSwift-Observable. 
It is implemented in the [VISPER-Reactive](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/Classes/ObservableProperty.html) Component.


#### SubscriptionReferenceBag

needs to be documented

---------------------------------------------------------------------------------------------------------

## Complete list of all available VISPER-Components

* [VISPER](https://rawgit.com/barteljan/VISPER/master/docs/VISPER/index.html) - a convenience import wrapper to include all VISPER Components with one import. It contains some deprecated components for backwards compatibility to previous VISPER Versions.
* [VISPER-Swift](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Swift/index.html) - All swift components of the VISPER-Framework, and a convenience import wrapper for all their dependencies.
* [VISPER-Objc](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Objc/index.html) - A wrapper around the core VISPER classes to use them in an objc codebase.
* [VISPER-Core](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Core/index.html) - Some common core protocols used to communicate between the different components of your feature. This pod should be used if you want to include VISPER Components into your own projects and components. It's protocols are implemented in the other VISPER component pods.
* [VISPER-Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/index.html) - The component containing the implementation of the wireframe layer in a VIPER-Application, it manages the presentation and the lifecycle of your ViewControllers.
* VISPER-Presenter([swift](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Presenter/Swift/index.html) / [objc](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Presenter/Objc/index.html)) - The component containing the implementation of the presentation layer in a VIPER-Application. It contains some presenter classes to seperate your application logic, from your view logic. 
* [VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) - A component containing the implementation of an redux architecture used in many VISPER-Application to represent the interactor layer in a viper application.
* [VISPER-Reactive](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/index.html) - A simple implementation of reactive properties to allow the use of a reactive redux architecture in a VISPER-Application. It can be updated by the subspec VISPER-Rective/RxSwift to use the RxSwift framework.
* [VISPER-Sourcery](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Sourcery/index.html) - A component supporting you to create a VISPER application by creating some nessecary boilerplate code for you.
* VISPER-UIViewController ([swift](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-UIViewController/swift/index.html))  /  ([objc](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-UIViewController/objc/index.html)) - A component extending UIViewControllers to notify a presenter about it's lifecycle (viewDidLoad, etc.) 
* [VISPER-Entity](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Entity/index.html) - A component modeling the entity layer if you do not use your custom layer in your VISPER-Application.



