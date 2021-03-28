//
//  File.swift
//  Ya
//
//  Created by Alex Bazlinton on 27/03/2021.
//

import Foundation
import AppKit
import IOKit.ps

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    
    var sleepDate = Date()
    static var dataModel = DataModel()
    let nc = NotificationCenter.default
    
    func applicationDidFinishLaunching(_ aNotification: Notification){
        print("launched yo")
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(willSleepHandler(_:)),
                                                          name: NSWorkspace.willSleepNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(didWakeHandler(_:)),
                                                          name: NSWorkspace.didWakeNotification, object: nil)
        
        var context : UnsafeMutableRawPointer
        context = UnsafeMutableRawPointer.allocate(byteCount: 0, alignment: 0)
        let loop: CFRunLoopSource = IOPSNotificationCreateRunLoopSource({ (context: UnsafeMutableRawPointer?) in
            let psInfo : CFTypeRef = IOPSCopyPowerSourcesInfo().takeRetainedValue()
            let powerSource : CFString = IOPSGetProvidingPowerSourceType(psInfo).takeRetainedValue()
            ApplicationDelegate.dataModel.powerSource = powerSource as String
        }, &context).takeRetainedValue() as CFRunLoopSource
        CFRunLoopAddSource(CFRunLoopGetCurrent(), loop, CFRunLoopMode.defaultMode)
    }
    
    @objc func willSleepHandler(_ aNotification: NSNotification)  {
        sleepDate = Date()
        print("about to sleep")
    }
    @objc func didWakeHandler(_ aNotification: NSNotification)  {

        let wakeDate = Date()
        let dateInterval = DateInterval(start: sleepDate, end: wakeDate)
        let duration = dateInterval.duration
        print("I woke after \(duration) seconds")
        ApplicationDelegate.dataModel.duration = Int(duration)
    }
    
}

