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
        theme.logoImage = UIImage(named: "logo-vamosaude-completo-transparente")
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
                let message = "Número Cadastrado: \(session!.phoneNumber!)"
                let alertController = UIAlertController(title: "Você está logado!", message: message, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] action in
                    self?.dismiss(animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: .none)
                
                if let numberWithSha = session?.phoneNumber.sha1() {
                    let password = "batataBatatuda"
                    let email = "\(numberWithSha)@vamossaude.com.br"
                    RestManager.signUp(numberWithSha, email, password) {
                        RestManager.authenticateUser(email, password)
                        RestManager.createFavoriteIdWithBlock { [weak self] in
                            print("FavoriteIdCreated")
                            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                                delegate.gotoStoryboard(initialStoryboard: "HealthUnit")
                            }
                            self?.dismiss(animated: true, completion: { [weak self] in
                                self?.dismiss(animated: true, completion: nil)
                            })
                        }
                    }
                }
            } else {
                let message = error!.localizedDescription
                let alertController = UIAlertController(title: "Problema de Autenticação: ", message: message, preferredStyle: .alert)
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
