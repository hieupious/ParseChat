//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Hoi Pham Ngoc on 3/23/16.
//  Copyright © 2016 Hoang Trung Hieu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.currentUser() != nil {
            dispatch_async(dispatch_get_main_queue(), { 
                self.performSegueWithIdentifier("doLogin", sender: self)
            })
            
        }

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBtnSignUpClick(sender: UIButton) {
        print("Sign IN")
        userSignUp()
    }
    @IBAction func onBtnLoginClick(sender: UIButton) {
        print("Login")
        userLogin()
    }
    func userLogin() {
        PFUser.logInWithUsernameInBackground(userEmail.text!, password:userPassword.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("doLogin", sender: self)
                
            } else {
                // The login failed. Check error to see why.
                self.displayMessage((error?.localizedDescription)!)
                print(error?.description)
            }
        }
    }
    func userSignUp() {
        if userEmail.text == "" {
            self.displayMessage("email is required")
        } else
            if userPassword.text == "" {
        self.displayMessage("password is required")
            } else {
                let user = PFUser()
                user.username = userEmail.text
                user.password = userPassword.text
                // other fields can be set just like with PFObject
                
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, error: NSError?) -> Void in
                    if let error = error {
                        let errorString = error.userInfo["error"] as? NSString
                        self.displayMessage(errorString as! String)
                    } else {
                        print("sign up success")
                        self.performSegueWithIdentifier("doLogin", sender: self)
                    }
                }
        }
        
    }
    func displayMessage(message: String) {
        let alertController = UIAlertController(title: "Alert",
            message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
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
