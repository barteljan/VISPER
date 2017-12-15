//
//  ControllerPresenterTests.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 15.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Presenter
import VISPER_Core
import VISPER_Wireframe

class ControllerPresenterTests: XCTestCase {
    
    func showVC(controller: UIViewController) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = controller
        XCTAssertNotNil(controller.view,"\(controller)s view should be created")
        window?.makeKeyAndVisible()
    }
    
    func hideVC(){
        UIApplication.shared.keyWindow?.rootViewController = UIViewController()
    }
    
    
    func testLoadViewCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        XCTAssertTrue(presenter.invokedLoad)
        
    }
    
    func testViewDidLoadCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        XCTAssertTrue(presenter.invokedViewDidLoad)
    }
    
    func testViewWillAppearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        XCTAssertTrue(presenter.invokedViewWillAppear)
    }
    
    func testViewDidAppearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        let expection = self.expectation(description: "timerCalled")
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            expection.fulfill()
        }
        
        wait(for: [expection], timeout: 0.7)
        
        
        XCTAssertTrue(presenter.invokedViewDidAppear)
    }
    
    func testViewWillDisappearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        let didAppearExpect = self.expectation(description: "timerCalled")
        let didDisappearAppearExpect = self.expectation(description: "timerCalled")
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            self.hideVC()
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { timer in
                didDisappearAppearExpect.fulfill()
            })
            didAppearExpect.fulfill()
        }
        
        wait(for: [didAppearExpect,didDisappearAppearExpect], timeout: 1.3)
        
        XCTAssertTrue(presenter.invokedViewWillDisappear)
    }
    
    func testViewDidDisappearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        let didAppearExpect = self.expectation(description: "timerCalled")
        let didDisappearAppearExpect = self.expectation(description: "timerCalled")
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            self.hideVC()
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { timer in
                didDisappearAppearExpect.fulfill()
            })
            didAppearExpect.fulfill()
        }
        
        wait(for: [didAppearExpect,didDisappearAppearExpect], timeout: 1.3)
        
        XCTAssertTrue(presenter.invokedViewDidDisappear)
    }
    
    func testLifecycleEventsOrder() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        controller.add(controllerPresenter: presenter)
        
        self.showVC(controller: controller)
        
        let didAppearExpect = self.expectation(description: "timerCalled")
        let didDisappearAppearExpect = self.expectation(description: "timerCalled")
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            self.hideVC()
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { timer in
                didDisappearAppearExpect.fulfill()
            })
            didAppearExpect.fulfill()
        }
        
        wait(for: [didAppearExpect,didDisappearAppearExpect], timeout: 1.3)
        
        guard presenter.events.count == 6 else {
            XCTFail("Should have received 6 events")
            return
        }
        
        XCTAssertEqual(presenter.events[0], LifecycleEventString.load)
        XCTAssertEqual(presenter.events[1], LifecycleEventString.viewDidLoad)
        XCTAssertEqual(presenter.events[2], LifecycleEventString.viewWillAppear)
        XCTAssertEqual(presenter.events[3], LifecycleEventString.viewDidAppear)
        XCTAssertEqual(presenter.events[4], LifecycleEventString.viewWillDisappear)
        XCTAssertEqual(presenter.events[5], LifecycleEventString.viewDidDisappear)
        
        
    }
    
    func testAddPresentationLogic() throws {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockControllerPresenter()
        presenter.stubbedIsResponsibleResult = true
        
        try presenter.addPresentationLogic(routeResult: DefaultRouteResult(routePattern: "/some/pattern", parameters: [:]), controller: controller)
        
        self.showVC(controller: controller)
        
        let didAppearExpect = self.expectation(description: "timerCalled")
        let didDisappearAppearExpect = self.expectation(description: "timerCalled")
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            self.hideVC()
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { timer in
                didDisappearAppearExpect.fulfill()
            })
            didAppearExpect.fulfill()
        }
        
        wait(for: [didAppearExpect,didDisappearAppearExpect], timeout: 1.3)
        
        guard presenter.events.count == 6 else {
            XCTFail("Should have received 6 events")
            return
        }
        
        XCTAssertEqual(presenter.events[0], LifecycleEventString.load)
        XCTAssertEqual(presenter.events[1], LifecycleEventString.viewDidLoad)
        XCTAssertEqual(presenter.events[2], LifecycleEventString.viewWillAppear)
        XCTAssertEqual(presenter.events[3], LifecycleEventString.viewDidAppear)
        XCTAssertEqual(presenter.events[4], LifecycleEventString.viewWillDisappear)
        XCTAssertEqual(presenter.events[5], LifecycleEventString.viewDidDisappear)
        
        
    }
    
}
