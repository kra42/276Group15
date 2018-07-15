//
//  GoogleSignIn.swift
//  CropBook
//
//  Created by Jack Ren on 2018-07-15.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleSignIn: UIViewController, GIDSignInUIDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
}

