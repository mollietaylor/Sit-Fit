//
//  FeedTVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/3/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class FeedTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        refreshFeed()
        
    }
    
    func refreshFeed() {
        
        FeedData.mainData().refreshFeedItems { () -> () in
            
            self.tableView.reloadData()
            
        }
        
    }
    
    @IBAction func addNewSeat(sender: AnyObject) {
        
        var newSeatSB = UIStoryboard(name: "NewSeat", bundle: nil)
        var newSeatVC = newSeatSB.instantiateInitialViewController() as NewSeatVC
        presentViewController(newSeatVC, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedData.mainData().feedItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> FeedCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as FeedCell

        let seat = FeedData.mainData().feedItems[indexPath.row]
        
        cell.seatInfo = seat

        return cell
    }

}
