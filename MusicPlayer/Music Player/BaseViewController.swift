//
//  BaseViewController.swift
//  Music Player
//
//  Created by Jaren Lynch on 5/16/19.
//  Copyright © 2019 Jaren Lynch. All rights reserved.
//

import UIKit
import FirebaseUI

class BaseViewController: UIViewController, FUIAuthDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
//            print(Auth.auth().currentUser as Any)
        } else {
            let authUI = FUIAuth.defaultAuthUI()
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [
                FUIGoogleAuth(), FUIEmailAuth()]
            
            authUI?.providers = providers
            
            let authViewController = authUI!.authViewController()
            self.present(authViewController, animated: true, completion: nil)
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            // log error
            return
        }
        
//        print(authDataResult?.user.uid as Any)
        performSegue(withIdentifier: "goMusic", sender: self)

    }
//
//    private func showList() {
//        performSegue(withIdentifier: "showList", sender: self)
//    }
}
