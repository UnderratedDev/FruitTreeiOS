//
//  Notifications.swift
//  FruitTree
//
//  Created by Yudhvir Raj on 2017-11-09.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import NotificationCenter

class Notifications
{
    private static let notificationCentre = NotificationCenter.default
    
    static func post(messageName: String!,
                     object: AnyObject?,
                     userInfo: [NSObject: AnyObject]? = nil)
    {
        //logTrace { "enter post \(messageName!)" }
        
        if userInfo == nil
        {
            //logInfo { "posting \(messageName!)" }
        }
        else
        {
            //logInfo { "posting \(messageName!) \(String(describing: userInfo))" }
        }
        
        notificationCentre.post(name: NSNotification.Name(messageName),
                                object: object,
                                userInfo: userInfo)
        //logTrace { "exit post \(messageName!)" }
    }
    
    static func addObserver(messageName: String!,
                            object: Any?,
                            using receiver: @escaping (Notification) -> Void) -> NSObjectProtocol
    {
        //logTrace { "enter addObserver \(messageName!)" }
        
        let id = notificationCentre.addObserver(forName: NSNotification.Name(messageName),
                                                object: object,
                                                queue: nil,
                                                using: receiver)
        
        //logTrace { "exit addObserver \(messageName!)" }
        
        return id
    }
    
    static func removeObserver(observer: AnyObject?)
    {
        
        //logTrace { "enter removeObserver" }
        
        if observer != nil
        {
            notificationCentre.removeObserver(observer!)
        }
        
        //logTrace { "exit removeObserver" }
    }
}
