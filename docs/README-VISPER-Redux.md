# VISPER-Redux

[![CI Status](http://img.shields.io/travis/barteljan/VISPER-Redux.svg?style=flat)](https://travis-ci.org/barteljan/VISPER-Redux)
[![Version](https://img.shields.io/cocoapods/v/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)
[![License](https://img.shields.io/cocoapods/l/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)
[![Platform](https://img.shields.io/cocoapods/p/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)

---------------------------------------------------------------------------------------------------------

- [VISPER-Redux](#visper-redux)
  * [State](#state)
  * [Changing state](#changing-state)
  * [AppReducer](#appreducer)
  * [A short state change example](#a-short-state-change-example)
  * [Observing state change](#observing-state-change)
  * [Reducer](#reducer)
    + [ReduceFuntion](#reducefuntion)
    + [FunctionalReducer](#functionalreducer)
    + [ActionReducerType](#actionreducertype)
    + [AsyncActionReducerType](#asyncactionreducertype)
  * [Using VISPER-Redux with a ReduxApp and Features](#using-visper-redux-with-a-reduxapp-and-features)
  * [Example](#example)
  * [Installation](#installation)
  * [Author](#author)
  * [License](#license)
  
---------------------------------------------------------------------------------------------------------

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) is an implementation of the redux-architecture in swift. 
It provides you with an app architecture to tackle the problem of distributed app state and state changes.

It is heavyly inspired by [ReReactiveSwift](https://github.com/ReSwift/ReactiveReSwift) and adds just some extensions to tackle composite app states and some integration features to use it in the [VISPER](https://github.com/barteljan/VISPER)-Application Framework.


If you want to learn more about redux, have a look at the following tutorials and documentations:

* [A cartoon guide to Flux](https://code-cartoons.com/a-cartoon-guide-to-flux-6157355ab207)
* [A cartoon Intro to Redux](https://code-cartoons.com/a-cartoon-intro-to-redux-3afb775501a6)
* [redux.js Documentation](http://redux.js.org/docs/introduction/)


## State

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

## Changing state 

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
redux.reducerContainer.addReduceFunction(...)
```

```swift
// add a action reducer instance
redux.reducerContainer.addReducer(...)
```

An action is just an simple object conforming to the empty protocol Action, for example:

```swift
struct SetUsernameAction: Action {
    var newUsername: String
}
```

## AppReducer

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


## A short state change example

At first create an app reducer:

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

Initialize an instance of type Redux 

```swift

let appState = //initialize your initial app state here
self.redux = Redux<AppState>(   appReducer: appReducer,
                              initialState: appState)
```

create a SetUsernameAction 

```swift
struct SetUsernameAction : Action{
    var newUsername : String
}
```

add a specific reducer for changing your UserState

```swift
let setUsernameReducer = { (reducerProvider: ReducerProvider, action: SetUsernameAction, currentState: UserState) -> UserState in
    return UserState(userName: action.newUsername,
                     isAuthenticated: currentState.isAuthenticated)
}

redux.reducerContainer.addReduceFunction(appReducer)
```

and dispatch a new SetUserNameAction 

```swift
let action = SetUsernameAction(newUsername: "Max Mustermann")
redux.actionDispatcher.dispatch(action)
```

your reducers will now be called and the setUsernameReducer will set the new UserStates property userName to "Max Mustermann"


You can prove that by:

```swift
assert(redux.store.observableState.value.userState.userName == "Max Mustermann")
```

## Observing state change

Observing state change ist simple. Just observe the observable property of your store:

```swift

//get your reference bag to retain subscription
let referenceBag: SubscriptionReferenceBag = self.referenceBag


//subscribe to the state
let subscription = redux.store.observableState.subscribe { appState in
    print("New username is:\(appState.userState.userName)")                                   
}

//retain subscription in your reference bag
referenceBag.addReference(reference: subscription)
```

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) contains a [ObservableProperty<AppState>](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/Classes/ObservableProperty.html) to represent the changing AppState.
[ObservableProperty](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/Classes/ObservableProperty.html) allows you to subscribe for state changes, and can be mapped to a RxSwift-Observable. 
It is implemented in the [VISPER-Reactive](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Reactive/Classes/ObservableProperty.html) Component.

## Reducer 

Reducers specify how the application's state changes in response to actions sent to the store. Remember that actions only describe what happened, but don't describe how the application's state changes.
A reducer in VISPER swift could be a reduce-function, or an instance of type [FunctionalReducer](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Structs/FunctionalReducer.html),[ActionReducerType](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/ActionReducerType.html)                                                                               
or [AsyncActionReducerType](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/Protocols/AsyncActionReducerType.html).

### ReduceFuntion

A reduce funtion is just a simple function getting a provider, an action and an state, and returning a new state of the same type.
```swift
let reduceFunction = { (provider: ReducerProvider, action: SetUsernameAction, state: UserState) -> UserState in
    return UserState(userName: action.newUsername,
                        isAuthenticated: state.isAuthenticated)
}
reducerContainer.addReduceFunction(reduceFunction:reduceFunction)
```

### FunctionalReducer
A functional reducer is quite similar, just a reducer taking a reduce function and using it to reduce a state.

```swift
let functionalReducer = FunctionalReducer(reduceFunction: reduceFunction)
reducerContainer.addReducer(reducer:functionalReducer)
```

### ActionReducerType

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

### AsyncActionReducerType

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

## Using VISPER-Redux with a ReduxApp and Features

It is possible to use VISPER-Redux with a feature based architecture, instead of configuring it manually. 

Let's create an application at first:

````swift
let appState: AppState = AppState( ... create your state here ...)

let factory = ReduxAppFactory()

let appReducer = { (reducerProvider: ReducerProvider, action: Action, currentState: AppState) -> AppState in
    let state = AppState(
        userState: reducerProvider.reduce(action,currentState.userState),
        todoListState: reducerProvider.reduce(action,currentState.todoListState),
        imprintState : reducerProvider.reduce(action,currentState.imprintState)
    )
    return reducerProvider.reduce(action,state)
}

let app: ReduxApp<AppState> = factory.makeApplication(initialState: appState, appReducer: appReducer) 
````

create a SetUsernameAction 

```swift
struct SetUsernameAction : Action{
    var newUsername : String
}
```

now create a reducer:

````swift
class SetUsernameReducer: ActionReducerType {
    
    typealias ReducerStateType  = UserState
    typealias ReducerActionType = SetUsernameAction
    
    func reduce(provider: ReducerProvider,
                  action: SetUsernameAction,
                   state: UserState) -> UserState {
         return UserState(userName: action.newUsername,
                    isAuthenticated: state.isAuthenticated)
    }
    
    
}
````

now create a LogicFeature and use it to add your Reducer to the global ReducerContainer 

````swift
import VISPER_Redux

class ExampleLogicFeature: LogicFeature {
    
     func injectReducers(container: ReducerContainer) {
        let reducer = SetUsernameReducer()
        container.addReducer(reducer: incrementReducer)
     }
    
}
````

and dispatch a new SetUserNameAction 

```swift
let action = SetUsernameAction(newUsername: "Max Mustermann")
app.redux.actionDispatcher.dispatch(action)
```

your reducers will now be called and the setUsernameReducer will set the new UserStates property userName to "Max Mustermann"


You can prove that by:

```swift
assert(app.redux.store.observableState.value.userState.userName == "Max Mustermann")
```

## Example

You can find full example showing a typical counter example in the [VISPER-Redux-Example](https://github.com/barteljan/VISPER/tree/master/Example/VISPER-Redux-Example) target

## Installation

[VISPER-Redux](https://rawgit.com/barteljan/VISPER/master/docs/VISPER-Redux/index.html) is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VISPER-Redux'
```

## Author

barteljan, barteljan@yahoo.de

## License

VISPER-Redux is available under the MIT license. See the LICENSE file for more info.
