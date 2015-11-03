//
//  LoginVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/2/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import ParseUI

class LoginVC: PFLogInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logInView?.logo = UIImageView.init(image: UIImage(named: "Melodious Logo"))
        
        let backgroundImage = UIImage(named: "Listening Music")
        
        self.logInView?.backgroundColor = UIColor(patternImage: backgroundImage!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
