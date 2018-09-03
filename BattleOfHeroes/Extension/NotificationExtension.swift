//
//  NotificationExtension.swift
//  SPNSDemo
//
//  Created by Szabo Istvan on 2018. 05. 10..
//  Copyright © 2018. Sanoma MDC. All rights reserved.
//

import Foundation
import UIKit

public func postNotification(name: Notification.Name, object: Any? = nil) {
    NotificationCenter.default.post(name: name, object: object)
}

public protocol EasyNotification {
    func subscribeForNotification(name: Notification.Name, selector: Selector, object: Any?)

    func subscribeForNotifications(names: [Notification.Name], selector: Selector, object: Any?)

    func unSubscribeFromNotification(name: Notification.Name, object: Any?)

    func unSubscribeFromAllNotifications()
}

public extension EasyNotification {
    public func subscribeForNotification(name: Notification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }

    public func subscribeForNotifications(names: [Notification.Name], selector: Selector, object: Any? = nil) {
        names.forEach { subscribeForNotification(name: $0, selector: selector, object: object) }
    }

    public func unSubscribeFromNotification(name: Notification.Name, object: Any? = nil) {
        NotificationCenter.default.removeObserver(self, name: name, object: object)
    }

    public func unSubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIView: EasyNotification {}

extension UIViewController: EasyNotification {}
