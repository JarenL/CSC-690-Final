//
//  ViewController.swift
//  Caboose
//
//  Created by Jaren Lynch on 5/15/19.
//  Copyright © 2019 Jaren Lynch. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseAuth

class ViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            // to do
        } else {
            let authUI = FUIAuth.defaultAuthUI()
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [
                FUIEmailAuth(),
                FUIGoogleAuth()]
            
            authUI?.providers = providers
            let authViewController = authUI!.authViewController()
            self.present(authViewController, animated: true, completion: nil)
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // to do - Handle user returning from authenticating
    }


}

