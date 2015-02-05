//
//  NewSeatVC.swift
//  Sit Fit
//
//  Created by Mollie on 2/3/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class NewSeatVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // TODO: var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    @IBOutlet weak var seatImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        
        
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        self.seatImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancelSeat(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // TODO: create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat["creator"] = PFUser.currentUser()
        
        // image
        let imageFile = PFFile(name: "image.png", data: UIImagePNGRepresentation(self.seatImageView.image))
        newSeat["image"] = imageFile
        
        newSeat.saveInBackground()
        
        FeedData.mainData().feedItems.append(newSeat)
        
//        when you hit save on a new seat, create a PFFile using the UIImage on the seatImageView
        
        
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
