//
//  MapVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/5/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit
import MapKit

// create a class to allow annotations to have more info than title and subtitle
class MyPointAnnotation: MKPointAnnotation {
    
    var index: Int = 0
    
}

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "top_icon")
        navigationItem.titleView = UIImageView(image: image)
        
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
        
        for (i,seat) in enumerate(seats) {
            
            let venue = seat["venue"] as [String:AnyObject]
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let annotation = MyPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(locationInfo["lat"] as Double, locationInfo["lng"] as Double)
            annotation.title = seat["name"] as String
            annotation.index = i
            myMapView.addAnnotation(annotation)
            
        }
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        var rightArrowButton = ArrowButton(frame: CGRectMake(0, 0, 22, 22))
        rightArrowButton.strokeSize = 2
        rightArrowButton.strokeColor = UIColor.greenColor()
        annotationView.rightCalloutAccessoryView = rightArrowButton
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "dark_green_marker")
        
        return annotationView
        
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        let index = (view.annotation as MyPointAnnotation).index
        
        FeedData.mainData().selectedSeat = FeedData.mainData().feedItems[index]
        
        var detailVC = storyboard?.instantiateViewControllerWithIdentifier("seatDetailVC") as UIViewController
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
