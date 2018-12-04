# VISPER-Sourcery

VISPER is a component based library, which helps you to develop modular apps based on the VIPER Pattern.

 VISPER-Sourcery is a component supports createing a VISPER application by creating the nessecary boilerplate code for you.

[![Version](https://img.shields.io/cocoapods/v/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![License](https://img.shields.io/cocoapods/l/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![Platform](https://img.shields.io/cocoapods/p/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)

## Getting started 

### Adding VISPER-Sourcery to your project

**Hier eklärst du einmal wie man sein Projekt einrichten muss um VISPER-Sourcery zu verwenden, wichtig ist hier das run-script und wie man es eventuell anpassen kann. Für alle die Sourcery noch nicht kennen verweist du auf deine Einführung unten.**

### WithAutoInitializer - Generating a default initializer for a struct

**Hier erklärst du einmal konkret an einem Beispiel wie man WithAutoInitializer implementiert was er erzeugt und wo man es findet am besten du beginnst damit das Ziel zu Beschreiben (Ich habe ein struct und möchte das sein Konstruktor automatisch generiert wird).**

## What else can be automated by VISPER-Sourcery? 

### WithAutoGeneralInitializer - Convinience Initializers for property changes of a struct

**Hier erklärst du einmal konkret wie man WithAutoGeneralInitializer implementiert was er erzeugt und wo man es findet am besten du beginnst damit das Ziel zu beschreiben.**

classes that conform to WithAutoGeneralInitializer marker protocol will get an extension with initializers. One initializer that create new Instances of their type with other instances of their type as argument. But there will be initializers that take one instance of their type but change one property.

### AutoAppReducer - AutoGenerating an AppReducer and an ApplicationFactory for a specific state 

**Hier erklärst du einmal konkret wie man AutoAppReducer implementiert was er erzeugt und wo man es findet am besten du beginnst damit das Ziel zu beschreiben.**

Generates an `ApplicationFactory` for any class that implements the `AutoAppReducer` marker protocol. This is usually implemented by the `AppState` and contains the (sub)states of the app. For every (sub)state the code for creating and adding a feature observer is auto generated.

### AutoReducer - Auto genereating convinience reducers for changing a property of an specific state.

**Hier erklärst du einmal konkret wie man AutoReducer implementiert was er erzeugt und wo man es findet am besten du beginnst damit das Ziel zu beschreiben.**

Autocreates Action and Reducer for any type that implements `AutoReducer`

# A short introduction how Sourcery works

VISPER-Sourcery uses the Sourcery-Commandline-Tool to generate Source Code that follows a certain pattern so that automating is possible. Existing classes/structs/enums can be modified (inLine). Extensions or even classes/structs/enums can be auto-created. If you don't know how sourcery works have a look at the following example or dive into it's own documentation [documentation](https://github.com/krzysztofzablocki/Sourcery).

An example suited for introduction might be the generation of `LogicFeature` with the `AutoReducer` marker protocol.

The following class was generated with the help of VISPER-Sourcery:

```swift
class AutoReducerFeature: LogicFeature {
    func injectReducers(container: ReducerContainer) {
        // AppState
        container.addReducer(reducer: AppStateSetStylestateReducer())
        container.addReducer(reducer: AppStateSetUserstateReducer())
        // StyleState
        container.addReducer(reducer: StyleStateSetBackgroundcolorReducer())
        container.addReducer(reducer: StyleStateSetFontcolorReducer())
        // UserState
        container.addReducer(reducer: UserStateSetFirstnameReducer())
        container.addReducer(reducer: UserStateSetLastnameReducer())
        container.addReducer(reducer: UserStateSetUsernameReducer())
        container.addReducer(reducer: UserStateSetEmailReducer())
    }
}
```

 To have something generated, you need a template, a marker protocol and something that conforms to the marker protocol. There is another way to have code generated inLine with comments but more on that later.
 `AutoReducer`  is a so called marker protocol. It is some sort of trick to mark a struct or class, in fact the protocols are empty.  

```swift
import Foundation
public protocol AutoReducer{}
```

struct that "conforms" to AutoReducer:   

```swift
import Foundation
import VISPER_Sourcery

struct StyleState: AutoReducer, Equatable {
    let backgroundColor: UIColor
    let fontColor: UIColor
}
```

The struct StyleState conforms to an empty protocol which is syntactically correct but senseless to the compiler. But it is not senseless to sourcery. Sourcery is a command line tool that can identify classes/strucs/enums by their marker protocol(s) and modifies or generates code by evaluating template files. Or as mentioned before: sourcery can add generated code inLine when special comments are used as well, but more on that later.

Hint: marker protocols in production will be mostly added like this:

```swift 
extension SomeClass: SomeMarkerProtocol {}
```

Let's have a look at a stencil file that comes with VISPER-Sourcery,  AutoReducerFeature.stencil:

```stencil
import VISPER_Swift
import VISPER_Redux
//
//
// Feature to add all auto generated reducers
//
//
class AutoReducerFeature: LogicFeature {
    func injectReducers(container: ReducerContainer) {
        {% for type in types.implementing.AutoReducer %}
            // {{type.name}}
            {% for property in type.storedVariables|!annotated:"skipAutoStateInitializers" %}
                container.addReducer(reducer: {{type.name}}Set{{property.name|capitalize}}Reducer())
            {% endfor %}
        {% endfor %}
    }
}
```

As you can see, there is a for loop that iterates over `types.implementing.AutoReducer` and a for loop iterating over `type.storedVariables`. Any type that "implements" the AutoReducer marker protocol is found by sourcery and the correspoding template(s) are processed. In this case there will as much addReducer(reducer:_)-methods added as properties are found per Type that conform to `AutoReducer`.

the methods  `container.addReducer(reducer: StyleStateSetFontcolorReducer())` and  `container.addReducer(reducer: StyleStateSetBackgroundcolorReducer())` were added, because StyleState conforms to the marker protocol `AutoReducer` and has the members `let backgroundColor: UIColor` and `let fontColor: UIColor`.

The other methods were generated accordingly - same stencil file, but conformance to the marker protocol in a struct somewhere else.

This is how marker Protocols work with templates in VISPER-Sourcery in general. The explanation was more detailed, the next explanations be less detailed.

VISPER-Sourcery uses the Stencil-Template-Engine, a more detailed and general explanation can be found [here](http://stencil.fuller.li/en/latest/templates.html "Stencil by Kyle Fuller")

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
