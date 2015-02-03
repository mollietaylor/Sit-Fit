//
//  NewSeatVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/3/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class NewSeatVC: UIViewController {

    // TODO: var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelSeat(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // TODO: create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        
        FeedData.mainData().feedItems.append(newSeat)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
