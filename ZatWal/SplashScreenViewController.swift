//
//  SplashScreenViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 04/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit


class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.present(HomeViewController(), animated: true, completion: nil)
        }
    }
}
