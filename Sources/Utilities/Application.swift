//
//  Application.swift
//  Ello
//
//  Created by Sean on 8/4/15.
//  Copyright (c) 2015 Ello. All rights reserved.
//

private let sharedApplication = Application()

public class Application {

    public struct Notifications {
        public static let DidChangeStatusBarFrame = TypedNotification<Application>(name: "com.Ello.Application.DidChangeStatusBarFrame")
        public static let DidChangeStatusBarOrientation = TypedNotification<Application>(name: "com.Ello.Application.DidChangeStatusBarOrientation")
        public static let DidEnterBackground = TypedNotification<Application>(name: "com.Ello.Application.DidEnterBackground")
        public static let DidFinishLaunching = TypedNotification<Application>(name: "com.Ello.Application.DidFinishLaunching")
        public static let DidReceiveMemoryWarning = TypedNotification<Application>(name: "com.Ello.Application.DidReceiveMemoryWarning")
        public static let ProtectedDataDidBecomeAvailable = TypedNotification<Application>(name: "com.Ello.Application.ProtectedDataDidBecomeAvailable")
        public static let ProtectedDataWillBecomeUnavailable = TypedNotification<Application>(name: "com.Ello.Application.ProtectedDataWillBecomeUnavailable")
        public static let SignificantTimeChange = TypedNotification<Application>(name: "com.Ello.Application.SignificantTimeChange")
        public static let UserDidTakeScreenshot = TypedNotification<Application>(name: "com.Ello.Application.UserDidTakeScreenshot")
        public static let WillChangeStatusBarOrientation = TypedNotification<Application>(name: "com.Ello.Application.WillChangeStatusBarOrientation")
        public static let WillChangeStatusBarFrame = TypedNotification<Application>(name: "com.Ello.Application.WillChangeStatusBarFrame")
        public static let WillEnterForeground = TypedNotification<Application>(name: "com.Ello.Application.WillEnterForeground")
        public static let WillResignActive = TypedNotification<Application>(name: "com.Ello.Application.WillResignActive")
        public static let WillTerminate = TypedNotification<Application>(name: "com.Ello.Application.WillTerminate")
        public static let SizeCategoryDidChange = TypedNotification<Application>(name: "com.Ello.Application.SizeCategoryDidChange")
    }

    public class func shared() -> Application {
        return sharedApplication
    }

    public class func setup() {
        let _ = shared()
    }

    public init() {
        let center : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: Selector("didChangeStatusBarFrame:"), name: UIApplicationDidChangeStatusBarFrameNotification, object: nil)
        center.addObserver(self, selector: Selector("didChangeStatusBarOrientation:"), name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
        center.addObserver(self, selector: Selector("didEnterBackground:"), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        center.addObserver(self, selector: Selector("didFinishLaunching:"), name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
        center.addObserver(self, selector: Selector("didReceiveMemoryWarning:"), name: UIApplicationDidChangeStatusBarFrameNotification, object: nil)
        center.addObserver(self, selector: Selector("protectedDataDidBecomeAvailable:"), name: UIApplicationProtectedDataDidBecomeAvailable, object: nil)
        center.addObserver(self, selector: Selector("protectedDataWillBecomeUnavailable:"), name: UIApplicationProtectedDataWillBecomeUnavailable, object: nil)
        center.addObserver(self, selector: Selector("significantTimeChange:"), name: UIApplicationSignificantTimeChangeNotification, object: nil)
        center.addObserver(self, selector: Selector("userDidTakeScreenshot:"), name: UIApplicationUserDidTakeScreenshotNotification, object: nil)
        center.addObserver(self, selector: Selector("willChangeStatusBarOrientation:"), name: UIApplicationDidChangeStatusBarFrameNotification, object: nil)
        center.addObserver(self, selector: Selector("willChangeStatusBarFrame:"), name: UIApplicationWillChangeStatusBarFrameNotification, object: nil)
        center.addObserver(self, selector: Selector("willEnterForeground:"), name: UIApplicationWillEnterForegroundNotification, object: nil)
        center.addObserver(self, selector: Selector("willResignActive:"), name: UIApplicationWillResignActiveNotification, object: nil)
        center.addObserver(self, selector: Selector("willTerminate:"), name: UIApplicationWillTerminateNotification, object: nil)
        center.addObserver(self, selector: Selector("sizeCategoryDidChange:"), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        let center : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }

    @objc
    func didChangeStatusBarFrame(notification : NSNotification) {
        postNotification(Notifications.DidChangeStatusBarFrame, self)
    }

    @objc
    func didChangeStatusBarOrientation(notification : NSNotification) {
        postNotification(Notifications.DidChangeStatusBarOrientation, self)
    }

    @objc
    func didEnterBackground(notification : NSNotification) {
        postNotification(Notifications.DidEnterBackground, self)
    }

    @objc
    func didFinishLaunching(notification : NSNotification) {
        postNotification(Notifications.DidFinishLaunching, self)
    }

    @objc
    func didReceiveMemoryWarning(notification : NSNotification) {
        postNotification(Notifications.DidReceiveMemoryWarning, self)
    }

    @objc
    func protectedDataDidBecomeAvailable(notification : NSNotification) {
        postNotification(Notifications.ProtectedDataDidBecomeAvailable, self)
    }

    @objc
    func protectedDataWillBecomeUnavailable(notification : NSNotification) {
        postNotification(Notifications.ProtectedDataWillBecomeUnavailable, self)
    }

    @objc
    func significantTimeChange(notification : NSNotification) {
        postNotification(Notifications.SignificantTimeChange, self)
    }

    @objc
    func userDidTakeScreenshot(notification : NSNotification) {
        postNotification(Notifications.UserDidTakeScreenshot, self)
    }

    @objc
    func willChangeStatusBarOrientation(notification : NSNotification) {
        postNotification(Notifications.WillChangeStatusBarOrientation, self)
    }

    @objc
    func willChangeStatusBarFrame(notification : NSNotification) {
        postNotification(Notifications.WillChangeStatusBarFrame, self)
    }

    @objc
    func willEnterForeground(notification : NSNotification) {
        postNotification(Notifications.WillEnterForeground, self)
    }

    @objc
    func willResignActive(notification : NSNotification) {
        postNotification(Notifications.WillResignActive, self)
    }

    @objc
    func willTerminate(notification : NSNotification) {
        postNotification(Notifications.WillTerminate, self)
    }

    @objc
    func sizeCategoryDidChange(notification : NSNotification) {
        postNotification(Notifications.SizeCategoryDidChange, self)
    }
}