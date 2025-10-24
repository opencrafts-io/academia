//
//  NotificationService.swift
//  OneSignalNotificationServiceExtension
//
//  Created by Tirus Khamasi on 21/10/2025.
//

import UserNotifications
import OneSignalExtension

class NotificationService: UNNotificationServiceExtension{
    var contentHandler: ((UNNotificationContent) -> Void)?
    var receivedRequest: UNNotificationRequest!
    var bestAttemptContent: UNMutableNotificationContent?
    
    // A few notes...
    // This extension only runs when `mutable_content` is set
    // Setting an attachement or action buttons automatically sets the property to true
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.receivedRequest = request
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent{
            // debugging only G
            print("Running Notification Service Extension")
            bestAttemptContent.body = "[Modified] " + bestAttemptContent.body
            OneSignalExtension.didReceiveNotificationExtensionRequest(self.receivedRequest, with: bestAttemptContent, withContentHandler: self.contentHandler)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Hapa either modify the content that comes in ama use the original payload
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent{
            OneSignalExtension.serviceExtensionTimeWillExpireRequest(self.receivedRequest, with: self.bestAttemptContent)
            contentHandler(bestAttemptContent)
        }
    }
}
