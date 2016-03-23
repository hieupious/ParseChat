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
    
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject]! = []
    
    @IBOutlet weak var newMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getMessage()
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ChatViewController.getMessage), userInfo: nil, repeats: true)
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

    func getMessage() {
        var query = PFQuery(className:"Message_Swift_032016")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects! as? [PFObject] {
                    self.messages = objects
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            self.tableView.reloadData()
        }
    }
    
    func refreshMessage() {
    
    }
    
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessCell", forIndexPath: indexPath) as! UITableViewCell
        var message = self.messages[abs(self.messages.count - indexPath.row - 1)]["body"] as? String ?? self.messages[indexPath.row]["text"] as? String
        
        cell.textLabel?.text = message
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
}
