//
//  VenuesTVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/5/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit
import CoreLocation

var onceToken: dispatch_once_t = 0

class VenuesTVC: UITableViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    var foundVenues: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        dispatch_once(&onceToken) { () -> Void in
            
            if let location = locations.last as? CLLocation {
                
                self.foundVenues = FourSquareRequest.requestVenuesWithLocation(location)
                self.tableView.reloadData()
                
            }
            
        }
        
        manager.stopUpdatingLocation()
    
//        var userLocation = locations.last as CLLocation
//        let foundVenues = FourSquareRequest.requestVenuesWithLocation(userLocation)
//        self.tableView.reloadData()
//        manager.stopUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return foundVenues.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as UITableViewCell

        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        cell.textLabel?.text = venue["name"] as? String

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
        FeedData.mainData().selectedVenue = venue
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}
