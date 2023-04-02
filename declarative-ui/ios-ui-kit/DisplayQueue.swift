//
//  DisplayQueue.swift
//  declarative-ui
//
//  Created by Russell Warwick on 01/04/2023.
//

import QuartzCore

class DisplayQueue {
    static let sharedInstance = DisplayQueue()
    private var displayLink:CADisplayLink!
    
    init() {
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkTick))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    @objc func displayLinkTick(){
        if let _ = itemQueue.first {
            itemQueue.remove(at: 0)() // Remove it from the queue and run it
            // Stop the display link if it's not needed
            displayLink.isPaused = (itemQueue.count == 0)
        }
    }
    
    private var itemQueue:[()->()] = []
    
    func addItem(block:@escaping ()->()) {
        displayLink.isPaused = false // It's needed again
        itemQueue.append(block) // Add the closure to the queue
    }
}
