# VISPER-Redux

[![CI Status](http://img.shields.io/travis/barteljan/VISPER-Redux.svg?style=flat)](https://travis-ci.org/barteljan/VISPER-Redux)
[![Version](https://img.shields.io/cocoapods/v/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)
[![License](https://img.shields.io/cocoapods/l/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)
[![Platform](https://img.shields.io/cocoapods/p/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)

VISPER-Redux is an implementation of the redux-architecture in swift. 
It provides you with an app architecture to tackle the problem of distributed app state and state changes.

It is heavyly inspired by [ReReactiveSwift](https://github.com/ReSwift/ReactiveReSwift) and adds just some extensions to tackle composite app states and some integration features to use it in the [VISPER](https://github.com/barteljan/VISPER)-Application Framework.


If you want to learn more about redux, have a look at the following tutorials and documentations:

* [A cartoon guide to Flux](https://code-cartoons.com/a-cartoon-guide-to-flux-6157355ab207)
* [A cartoon Intro to Redux](https://code-cartoons.com/a-cartoon-intro-to-redux-3afb775501a6)
* [redux.js Documentation](http://redux.js.org/docs/introduction/)

## State

VISPER-Redux stores the complete state of your app in a central struct to create a transparent representation of the current state of your different app components.

A typical composite app state for an app to manage your todos in the next week might look like that: 

```swift
struct AppState {
    var userState : UserState
    var todoListState : TodoListState
    var imprintState : ImprintState
}
```

with some composite sub states:

```swift
struct UserState {
    var userName : String
    var isAuthenticated : Bool
}
```

```swift
struct TodoListState {
    var todos : [Todo]
}
```
```swift
struct ImprintState {
    var text : String
    var didAlreadyRead : Bool
}
```

## Changing state 

The current state in a VISPER-Redux app is stored in a central Store instance, which lives in a convinience wrapper object of type Redux. 
State change can only be achieved by dispatching an action (a simple message object) at the ActionDispatcher, and creating a modified new state in a reduce function.

A reduceFunction has the following form:

```swift
let reducer : (_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType
```

the reducer will be applied to all actions of type ActionType and to all states of type StateType.
A reducer can be added to your redux architecture by adding it to the reducer container.

```swift
// add a reduce function
redux.reducerContainer.addReduceFunction(...)
```

```swift
// add a action reducer instance
redux.reducerContainer.addReducer(...)
```



An action is just an simple object conforming to the empty protocol Action, for example:

```swift
struct SetUsernameAction : Action{
    var newUsername : String
}
```

### A short state change example

At first initialize an instance of type Redux 

```swift
//initialize your starting app state here
let appState = ...
let redux = Redux(initialState: appState)
```

add a reducer (an object responsible for a state change) for your complete app state

```swift
let appReducer = { (reducerProvider: ReducerProvider, action: Action, currentState: AppState) -> AppState in
    return AppState(
        userState: reducerProvider.reduce(action,currentState.userState),
        todoListState: reducerProvider.reduce(action,currentState.todoListState),
        imprintState : reducerProvider.reduce(action,currentState.imprintState)
    )
}

redux.reducerContainer.addReduceFunction(appReducer)

```

add a specific reducer for changing your UserState

```swift
let setUsernameReducer = { (reducerProvider: ReducerProvider, action: SetUsernameAction, currentState: UserState) -> AppState in
    return UserState(userName: action.newUsername,
                     isAuthenticated: currentState.isAuthenticated)
}

redux.reducerContainer.addReduceFunction(appReducer)
```

create a SetUsernameAction 

```swift
struct SetUsernameAction : Action{
    var newUsername : String
}
```

and dispatch it 

```swift
let action = SetUsernameAction(newUsername: "Max Mustermann")
redux.actionDispatcher.dispatch(action)
```

your reducers will now be called and the setUsernameReducer will set the new UserStates property userName to "Max Mustermann"


You can prove that by:

```swift
assert(redux.store.observable.value.userState.userName == "Max Mustermann")
```

## Observing state change

Observing state change ist simple. Just observe the observable property of your store:

```swift
redux.store.observable.subscribe { appState in
    print("New username is:\(appState.userState.userName)")                                   
}
```

VISPER-Redux contains a very simple implementation of Observable, with the name ObservableProperty, we recommend you to add some categories to it to use your favorite rx library with it.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. It contains a typical counter Example app for demonstration purposes.


## Installation

VISPER-Redux is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VISPER-Redux'
```

## Author

barteljan, jan.bartel@atino.net

## License

VISPER-Redux is available under the MIT license. See the LICENSE file for more info.
