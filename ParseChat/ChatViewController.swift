//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Hoang Trung Hieu on 3/23/16.
//  Copyright © 2016 Hoang Trung Hieu. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {


    
    @IBOutlet weak var newMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMess(sender: AnyObject) {
        sendNewMessage()
    }
    
    func sendNewMessage() {
        var message = PFObject(className:"Message_Swift_032016")
        message["text"] = newMessage.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("Send success: \(self.newMessage.text)")
                self.newMessage.text = ""
            } else {
                // There was a problem, check error.description
            }
        }
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
