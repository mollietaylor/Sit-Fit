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
            
            if let venue = seat["venue"] as? [String:AnyObject] {
            
                if let locationInfo = venue["location"] as? [String:AnyObject] {
                
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(locationInfo["lat"] as Double, locationInfo["lng"] as Double)
                    annotation.title = seat["name"] as String
                    myMapView.addAnnotation(annotation)
                    
                }
                
            }
            
        }
        
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        println("accessory tapped")
        // present VC and pass along view.annotation.title
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var customPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        customPinView.pinColor = .Purple
        customPinView.animatesDrop = true
        customPinView.canShowCallout = true
        
        var rightButton: UIButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
        rightButton.addTarget(self, action: Selector(showDetail()), forControlEvents: UIControlEvents.TouchUpInside)
        customPinView.rightCalloutAccessoryView = rightButton
        
        var customImage = UIImageView(image: UIImage(named: "image.png"))
        customPinView.leftCalloutAccessoryView = customImage
        
        myMapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
        
        return customPinView
        
    }
    
    func showDetail() {
        
        println("show detail")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
