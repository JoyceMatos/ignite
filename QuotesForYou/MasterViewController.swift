//
//  MasterViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/7/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var containerViewA: UIView!
    @IBOutlet weak var containerViewB: UIView!
    weak var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        self.currentVC = self.storyboard?.instantiateViewController(withIdentifier: "timeVC")
//        self.currentVC!.view.translatesAutoresizingMaskIntoConstraints = false
//        self.addChildViewController(self.currentVC!)
//        self.addSubview(self.currentVC!.view, toView: self.containerViewA)
//        super.viewDidLoad()
//
        // Do any additional setup after loading the view.
    }

//    func addSubview(subView:UIView, toView parentView:UIView) {
//        parentView.addSubview(subView)
//        
//        var viewBindingsDict = [String: AnyObject]()
//        viewBindingsDict["subView"] = subView
//        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
//                                                                                 options: [], metrics: nil, views: viewBindingsDict))
//        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
//                                                                                 options: [], metrics: nil, views: viewBindingsDict))
//    }
//    

}
