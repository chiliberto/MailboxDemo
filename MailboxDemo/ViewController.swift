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
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var messageOriginalPosition: CGPoint!
    var laterIconOriginalPosition: CGPoint!
    
    let bgYellow = UIColor(red: 248, green: 204, blue: 40, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width: feedImage.frame.width, height: feedImage.frame.height + messageImage.frame.height)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            print(translation.x)
            
            messageImage.center.x = messageOriginalPosition.x + translation.x
            
            if translation.x < -60 {
            
                laterIcon.center.x = laterIconOriginalPosition.x + translation.x + 60
                laterIcon.alpha = 1.0
                
                messageView.backgroundColor = UIColor.yellowColor()
                //messageView.backgroundColor = UIColor(red: 248, green: 204, blue: 40, alpha: 1)
                //messageView.backgroundColor = bgYellow
            
            }
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if abs(translation.x) < 60 {
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.messageImage.center.x = self.messageImage.frame.width/2

                })
            
            } else if translation.x < -60 {
            
                //Show reschedule options
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.messageImage.center.x = -self.messageImage.frame.width/2
                    self.laterIcon.alpha = 0
                    
                    }, completion: { (completed) -> Void in
            
                        UIView.animateWithDuration(0.25, animations: { () -> Void in

                            self.rescheduleImage.alpha = 1
                        
                        })
                        
                })
                
            }
            
        }
        
    }

}

