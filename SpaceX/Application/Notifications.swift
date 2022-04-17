//
//  Notifications.swift
//  SpaceX
//
//  Created by Тимур Ахметов on 17.04.2022.
//

import Foundation
import UserNotifications
import UIKit

class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granded, error in
            guard granded else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { settings in
            print(settings)
        }
    }
}
