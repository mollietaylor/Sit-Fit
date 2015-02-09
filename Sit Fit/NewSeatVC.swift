//
//  NewSeatVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/3/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class NewSeatVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // TODO: var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    @IBOutlet weak var seatImageView: UIImageView!
    @IBOutlet weak var selectVenueButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "top_icon")
        navigationItem.titleView = UIImageView(image: image)

        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        seatNameField.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if let venue = FeedData.mainData().selectedVenue {
            
            let venueName = venue["name"] as String
            
            selectVenueButton.setTitle(venueName + " (edit)", forState: .Normal)
            
        } else {
            
            selectVenueButton.setTitle("Select Venue", forState: .Normal)
            
        }
        
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        self.seatImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func cancelSeat(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func resizeImage(image: UIImage, withSize size: CGSize) -> UIImage {
        
        // make square
        
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat["creator"] = PFUser.currentUser()
        
        let image = resizeImage(seatImageView.image!, withSize: CGSizeMake(540.0, 540.0))
        
        // turn UIImage into PFFile and add to newSeat
        let imageFile = PFFile(name: "seat.png", data: UIImagePNGRepresentation(image))
        newSeat["image"] = imageFile
        
        if let venue = FeedData.mainData().selectedVenue {
            
            newSeat["venue"] = venue
            
        }
        
        newSeat.saveInBackground()
        
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
