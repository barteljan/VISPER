// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import VISPER_Swift

// generated application factory for AppState
class GeneratedAppFactoryForAppState {
    func makeApplication(initialState: AppState, middleware: Middleware<AppState> = Middleware<AppState>()) throws -> AnyVISPERApp<AppState> {
        //create general application factory
        let applicationFactory = AppFactory<AppState>()
        let application = applicationFactory.makeApplication(initialState: initialState,
                                                               appReducer: appReducerForAppState,
                                                               middleware: middleware)
        // add a feature observer for every sub property of our app state
        // add feature observer for styleState
        let styleStateFeatureObserver = StateObservingFeatureObserver<AppState,StyleState>(state: application.state.map({return $0.styleState}).distinct())
        application.add(featureObserver: styleStateFeatureObserver)
        // add feature observer for userState
        let userStateFeatureObserver = StateObservingFeatureObserver<AppState,UserState?>(state: application.state.map({return $0.userState}).distinct())
        application.add(featureObserver: userStateFeatureObserver)
        let autoReducerFeature = AutoReducerFeature()
        try application.add(feature: autoReducerFeature)
        return application
    }
}
