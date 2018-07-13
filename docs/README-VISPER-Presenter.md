# VISPER-Presenter

VISPER is a component based library, which helps you to develop modular apps based on the VIPER Pattern.

VISPER-Presenter contains the implementation of the presentation layer in an VIPER-Application. 
It contains some presenter classes to seperate your application logic, from your view logic. 

[![Version](https://img.shields.io/cocoapods/v/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![License](https://img.shields.io/cocoapods/l/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![Platform](https://img.shields.io/cocoapods/p/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)

---------------------------------------------------------------------------------------------------------

## Currently available VISPER-Components

* [VISPER](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER/index.html) - a convenience import wrapper to include all VISPER Components with one import. It contains some deprecated components for backwards compatibility to previous VISPER Versions.
* [VISPER-Swift](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Swift/index.html) - All swift components of the VISPER-Framework, and a convenience import wrapper for all their dependencies.
* [VISPER-Objc](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Objc/index.html) - A wrapper around the core VISPER classes to use them in an objc codebase.
* [VISPER-Core](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Swift/index.html) - Some common core protocols used to communicate between the different components of your feature. This pod should be used if you want to include VISPER Components into your own projects and components. It's protocols are implemented in the other VISPER component pods.
* [VISPER-Wireframe](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Wireframe/index.html) - The component containing the implementation of the wireframe layer in a VIPER-Application, it manages the presentation and the lifecycle of your ViewControllers.
* VISPER-Presenter([swift](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Presenter/Swift/index.html) / [objc](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Presenter/Objc/index.html)) - The component containing the implementation of the presentation layer in a VIPER-Application. It contains some Presenter classes to seperate your application logic, from your view logic. 
* [VISPER-Redux](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Redux/index.html) - A component containing the implementation of an redux architecture used in many VISPER-Application to represent the interactor layer in a viper application.
* [VISPER-Reactive](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Reactive/index.html) - A simple implementation of reactive properties to allow the use of a reactive redux architecture in a VISPER-Application. It can be updated by the subspec VISPER-Rective/RxSwift to use the RxSwift framework.
* [VISPER-Sourcery](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Sourcery/index.html) - A component supporting you to create a VISPER application by creating some nessecary boilerplate code for you.
* VISPER-UIViewController ([swift](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-UIViewController/swift/index.html))  /  ([objc](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-UIViewController/objc/index.html)) - A component extending UIViewControllers to notify a presenter about it's lifecycle (viewDidLoad, etc.) 
* [VISPER-Entity](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/VISPER-Entity/index.html) - A component modeling the entity layer if you do not use your custom layer in your VISPER-Application.
