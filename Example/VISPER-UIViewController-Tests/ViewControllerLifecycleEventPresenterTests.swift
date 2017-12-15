//
//  ViewControllerLifecycleEventPresenterTests.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 13.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_UIViewController
import VISPER_Presenter

class ViewControllerLifecycleEventPresenterTests: XCTestCase {
    
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
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        XCTAssertTrue(presenter.invokedLoad)
        
    }
    
    func testViewDidLoadCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        XCTAssertTrue(presenter.invokedViewDidLoad)
    }
    
    func testViewWillAppearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        XCTAssertTrue(presenter.invokedViewWillAppear)
    }
    
    func testViewDidAppearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
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
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
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
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
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
        let presenter = MockViewControllerLifecycleEventPresenter()
        presenter.stubbedIsResponsibleForResult = true 
        
        controller.addVisperPresenter(presenter)
        
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
        
        AssertThat(presenter.events[0], isOfType: LoadViewEvent.self)
        AssertThat(presenter.events[1], isOfType: ViewDidLoadEvent.self)
        AssertThat(presenter.events[2], isOfType: ViewWillAppearEvent.self)
        AssertThat(presenter.events[3], isOfType: ViewDidAppearEvent.self)
        AssertThat(presenter.events[4], isOfType: ViewWillDisappearEvent.self)
        AssertThat(presenter.events[5], isOfType: ViewDidDisappearEvent.self)
        
    }
    
}
