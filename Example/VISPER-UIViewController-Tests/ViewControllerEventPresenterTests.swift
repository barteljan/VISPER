//
//  VISPER_UIViewController_Tests.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 13.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_UIViewController
import VISPER_Presenter

class ViewControllerEventPresenterTests: XCTestCase {

    func showVC(controller: UIViewController) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = controller
        XCTAssertNotNil(controller.view,"\(controller)s view should be created")
        window?.makeKeyAndVisible()
    }
    
    func hideVC(){
        UIApplication.shared.keyWindow?.rootViewController = UIViewController()
    }
    
    func testCreateViewLoadEvent() {
        let controller = UIViewController()
        let event = LoadViewEvent(sender: controller)
        XCTAssertNotNil(event)
    }
    
    
    func testLoadViewCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        let calledInvokedViewEventParameters = presenter.invokedReceivedEventParametersList
        
        guard calledInvokedViewEventParameters.count > 0 else {
            XCTFail("didn't invoke loadViewEvent")
            return
        }
        
        AssertThat(calledInvokedViewEventParameters[0].event, isOfType: LoadViewEvent.self)
        
    }
    
    func testViewDidLoadCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        let calledInvokedViewEventParameters = presenter.invokedReceivedEventParametersList
        
        guard calledInvokedViewEventParameters.count > 1 else {
            XCTFail("didn't invoke loadViewEvent")
            return
        }
        
        AssertThat(calledInvokedViewEventParameters[1].event, isOfType: ViewDidLoadEvent.self)
    }

    func testViewWillAppearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        let calledInvokedViewEventParameters = presenter.invokedReceivedEventParametersList
        
        guard calledInvokedViewEventParameters.count > 2 else {
            XCTFail("didn't invoke viewWillAppearEvent")
            return
        }
        
        AssertThat(calledInvokedViewEventParameters[2].event, isOfType: ViewWillAppearEvent.self)
    }
    
    func testViewDidAppearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerEventPresenter()
        presenter.stubbedIsResponsibleForResult = true
        
        controller.addVisperPresenter(presenter)
        
        self.showVC(controller: controller)
        
        let expection = self.expectation(description: "timerCalled")
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            expection.fulfill()
        }
        
        wait(for: [expection], timeout: 0.7)
        
        
        let calledInvokedViewEventParameters = presenter.invokedReceivedEventParametersList
        
        guard calledInvokedViewEventParameters.count > 3 else {
            XCTFail("didn't invoke viewDidAppearEvent")
            return
        }
        
        AssertThat(calledInvokedViewEventParameters[3].event, isOfType: ViewDidAppearEvent.self)
    }
    
    func testViewWillDisappearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerEventPresenter()
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
        
        let calledInvokedViewEventParameters = presenter.invokedReceivedEventParametersList
        
        guard calledInvokedViewEventParameters.count > 4 else {
            XCTFail("didn't invoke viewWillDisappearEvent")
            return
        }
        
        AssertThat(calledInvokedViewEventParameters[4].event, isOfType: ViewWillDisappearEvent.self)
    }
    
    func testViewDidDisappearCalled() {
        
        UIViewController.enableLifecycleEvents()
        
        let controller = UIViewController()
        let presenter = MockViewControllerEventPresenter()
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
        
        let calledInvokedViewEventParameters = presenter.invokedReceivedEventParametersList
        
        guard calledInvokedViewEventParameters.count > 5 else {
            XCTFail("didn't invoke viewWillDisappearEvent")
            return
        }
        
        AssertThat(calledInvokedViewEventParameters[5].event, isOfType: ViewDidDisappearEvent.self)
    }
    
}
