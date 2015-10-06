//
//  ViewController.swift
//  MailboxDemo
//
//  Created by Gilbert Guerrero on 10/4/15.
//  Copyright © 2015 Gilbert Guerrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var rescheduleView: UIView!

    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var messageOriginalPosition: CGPoint!
    var laterIconOriginalPosition: CGPoint!
    var listIconOriginalPosition: CGPoint!
    var archiveIconOriginalPosition: CGPoint!
    var deleteIconOriginalPosition: CGPoint!
    
    let bgYellow = UIColor(red: 248/255.0, green: 204/255.0, blue: 40/255.0, alpha: 1)
    let bgBrown  = UIColor(red: 206/255.0, green: 150/255.0, blue: 98/255.0, alpha: 1)
    let bgGray   = UIColor(white: 219/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(
            width: feedImage.frame.width,
            height: feedImage.frame.height + messageImage.frame.height
        )

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRescheduleButton(sender: AnyObject) {
        
        //Hide reschedule options
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.rescheduleImage.alpha = 0
            self.listImage.alpha = 0
            
            }, completion: { (completed) -> Void in
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.rescheduleView.hidden = true
                    
                    self.messageView.center.y = -self.messageView.frame.height/2
                    self.feedImage.center.y = self.feedImage.center.y - self.messageView.frame.height
                    
                    }, completion: { (completed) -> Void in
                        
                      self.messageView.hidden = true
                    
                })
                
        })
        
    }

    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
    
        // Absolute (x,y) coordinates in parent view
        var point = panGestureRecognizer.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            messageOriginalPosition = messageImage.center
            laterIconOriginalPosition = laterIcon.center
            listIconOriginalPosition = listIcon.center
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            //print(translation.x)
            
            messageImage.center.x = messageOriginalPosition.x + translation.x
            
            if translation.x < -260 {

                listIcon.center.x = listIconOriginalPosition.x + translation.x + 260
                
                laterIcon.alpha = 0
                listIcon.alpha = 1.0
                
                messageView.backgroundColor = bgBrown

            } else if translation.x < -60 {
                
                laterIcon.center.x = laterIconOriginalPosition.x + translation.x + 60
                
                laterIcon.alpha = 1.0
                listIcon.alpha = 0
                
                messageView.backgroundColor = bgYellow
                
            } else {
                
                laterIcon.alpha = 0.25
                listIcon.alpha = 0

                messageView.backgroundColor = bgGray
            
            }

            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if abs(translation.x) < 60 {
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.messageImage.center.x = self.messageImage.frame.width/2

                })
            
            } else if translation.x < -260 {
                
                //Show reschedule options
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.messageImage.center.x = -self.messageImage.frame.width/2
                    self.listIcon.alpha = 0
                    self.rescheduleView.hidden = false
                    
                    }, completion: { (completed) -> Void in
                        
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            
                            self.listImage.alpha = 1
                            
                        })
                        
                })
            
            } else if translation.x < -60 {
            
                //Show reschedule options
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.messageImage.center.x = -self.messageImage.frame.width/2
                    self.laterIcon.alpha = 0
                    self.rescheduleView.hidden = false
                    
                    }, completion: { (completed) -> Void in
            
                        UIView.animateWithDuration(0.25, animations: { () -> Void in

                            self.rescheduleImage.alpha = 1
                        
                        })
                        
                })
                
            } //end if
            
        } //end if states
        
    }

}

