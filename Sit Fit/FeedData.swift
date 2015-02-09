//
//  FeedData.swift
//  Sit Fit
//
//  Created by Mollie on 2/3/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

let _mainData: FeedData = FeedData()

class FeedData: NSObject {
    
    var selectedVenue: [String:AnyObject]?
    var selectedSeat: PFObject?
    var feedItems: [PFObject] = []
//    var myFeedItems: [PFObject] = []
    
    class func mainData() -> FeedData {
        
        
        return _mainData
    }
    
    func refreshFeedItems(completion: () -> ()) {
        // we want to pass through a chunk of code that will be called after the request finishes
        
        var feedQuery = PFQuery(className: "Seat")
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.feedItems = objects as [PFObject]
                
            }
            
            // now we'll run whatever we added in FeedTVC (or wherever)
            completion()
            
        }
        
    }
    
    func refreshMyFeedItems(completion: () -> ()) {
        
        var feedQuery = PFQuery(className: "Seat")
        feedQuery.whereKey("creator", equalTo: PFUser.currentUser())
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.feedItems = objects as [PFObject]
                
            }
            
            completion()
            
        }
        
    }
   
}
