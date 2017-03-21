//
//  ViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/17/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class AppController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotificationObservers()
        loadInitialViewController()
    }
    
}

extension AppController {
    
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeTimeVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeTabVC, object: nil)
        
    }
    
}

// MARK: - Loading VC's
extension AppController {
    
    // Load View Controller based on storyboard ID
    func loadInitialViewController() {
        let defaults = UserDefaults.standard
        let id: StoryboardID
        
        // Unwrap storredDefault - if value exist, set id to to TabVC , else - set to timeVC
        if let storredDefault = defaults.object(forKey: "chosenTime") as? Date {
            
            // This can be swapped for currentUser credentials if we decide to use Firebase
            id = .tabVC
            print(storredDefault)
        } else {
            id = .timeVC
        }
        
        // Create a view controller with storyboard ID
        actingVC = loadViewController(withID: id)
        
        // Call on add function to add child view controller
        add(viewController: actingVC, animated: true)
        
        
    }
    
    func loadViewController(withID id: StoryboardID) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // The raw value is the string we set for each enum case for StoryboardID
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
    }
    
}

// MARK:- Displaying VC's

extension AppController {
    
    // Add function has a default arguement value of false for animated ; we can later call on function without this arguement
    func add(viewController: UIViewController, animated: Bool = false) {
        
        // Add child view controller
        addChildViewController(viewController)
        
        // Add container view to view controller's view
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        
        // Add frame to view controller's view
        viewController.view.frame = containerView.bounds
        
        // Set constraints to whatever the container view is
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Let view controller know it has a parent
        viewController.didMove(toParentViewController: self)
        
        // If animated true -> proceed, else keep container view displayed by increasing alpha
        guard animated else { containerView.alpha = 1.0; return }
        
        // Animate transition with alpha of container view
        UIView.transition(with: containerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1.0
        }) { _ in }
    }
    
    // Switch VC based on notification's name type
    func switchViewController(with notification: Notification) {
        switch notification.name {
        case Notification.Name.closeTimeVC:
            switchToViewController(with: .tabVC)
        case Notification.Name.closeTabVC:
            switchToViewController(with: .timeVC)
        default:
            fatalError("\(#function) - Unable to match notficiation name.")
        }
    }
    
    private func switchToViewController(with id: StoryboardID) {
        let existingVC = actingVC
        existingVC?.willMove(toParentViewController: nil)
        actingVC = loadViewController(withID: id)
        add(viewController: actingVC)
        actingVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.8, animations: {
            self.actingVC.view.alpha = 1.0
            existingVC?.view.alpha = 0.0
        }) { success in
            existingVC?.view.removeFromSuperview()
            existingVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
        }
        
    }
    
}

// MARK: - Notification Extension
extension Notification.Name {
    
    static let closeTimeVC = Notification.Name("close-time-view-controller")
    static let closeTabVC = Notification.Name("close-tab-view-controller")
}
