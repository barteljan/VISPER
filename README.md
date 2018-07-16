# VISPER

VISPER is a component based library, which helps you to develop modular apps based on the VIPER Pattern.

[![Version](https://img.shields.io/cocoapods/v/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![License](https://img.shields.io/cocoapods/l/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![Platform](https://img.shields.io/cocoapods/p/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)

---------------------------------------------------------------------------------------------------------

## Currently available VISPER-Components

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

## Getting started 

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

[VISPER-Wireframe](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/index.html) provides you with: [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html), [ViewFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/ViewFeature.html), [PresenterFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/PresenterFeature.html), [WireframeFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeFeatureObserver.html), [ViewFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/ViewFeatureObserver.html) and [PresenterFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Structs/PresenterFeatureObserver.html).

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) provides you with: [ReduxApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ReduxApp.html), [LogicFeature](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/LogicFeature.html) and [LogicFeatureObserver](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Structs/LogicFeatureObserver.html).

[VISPER-Swift](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Swift/index.html) provides you with a [VISPERApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Swift/Classes/VISPERApp.html) which combines all charactersistics of a [WireframeApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Wireframe/Protocols/WireframeApp.html) and a [ReduxApp](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ReduxApp.html) and is used inthe most Apps build on the VISPER-Framework.
