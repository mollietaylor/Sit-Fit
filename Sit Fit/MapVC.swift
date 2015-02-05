//
//  MapVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/5/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMapView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        refreshFeed()
        
    }
    
    func refreshFeed() {
        
        FeedData.mainData().refreshFeedItems { () -> () in
            
            // make annotations from feedItems
            self.createAnnotationsWithSeats(FeedData.mainData().feedItems)
            
            // zoom to annotations
            self.myMapView.showAnnotations(self.myMapView.annotations, animated: true)
            
        }
        
    }
    
    func createAnnotationsWithSeats(seats: [PFObject]) {
        
        for seat in seats {
            
            let venue = seat["venue"] as [String:AnyObject]
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(locationInfo["lat"] as Double, locationInfo["lng"] as Double)
            annotation.title = seat["name"] as String
            myMapView.addAnnotation(annotation)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
