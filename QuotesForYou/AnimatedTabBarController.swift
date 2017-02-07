//
//  AnimatedTabBarController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        switch item.tag {
        case 1:
            
            self.tabBar.viewWithTag(1)?.transform
            
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                let rotation = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                self.tabBar.viewWithTag(1)?.transform = rotation
            }, completion: nil)
            
            print(1)
            // do animation
        default:
            print("nothing")
            // do nothing
            
        }
        
       
    }
    
    
}
