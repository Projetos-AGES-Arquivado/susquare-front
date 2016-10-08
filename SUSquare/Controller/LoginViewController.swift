//
//  LoginViewController.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 08/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit
import DigitsKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTheme() -> DGTAppearance {
        let theme = DGTAppearance()
        theme.accentColor = UIColor(red: 40, green: 216, blue: 255, alpha: 1.0)
        theme.backgroundColor = UIColor(red: 10, green: 120, blue: 255, alpha: 1.0)
        //theme.logoImage = ??
        return theme
    }

    @IBAction func didTapButton(_ sender: AnyObject) {
        let digits = Digits.sharedInstance()
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration?.appearance = self.makeTheme()
        configuration?.phoneNumber = "+55"
        digits.authenticate(with: nil, configuration: configuration!) { session, error in
            if (session != nil) {
                User.sharedInstance.session = session
                let message = "Phone number: \(session!.phoneNumber)"
                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: .none))
                self.present(alertController, animated: true, completion: .none)
                if let delegate = UIApplication.shared.delegate as? AppDelegate {
                    delegate.gotoStoryboard(initialStoryboard: "Main")
                }
            } else {
                let message = error!.localizedDescription
                let alertController = UIAlertController(title: "Authentication Error: ", message: message, preferredStyle: .alert)
                self.present(alertController, animated: true, completion: .none)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
