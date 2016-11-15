//
//  MainFromViewController.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 15/11/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class MainFromViewController: UIViewController {

    @IBAction func didTapShowButton(_ sender: UIButton) {
//        centerVerticallyAction()
        customContentViewSizeAction()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func formSheetControllerWithNavigationController() -> UINavigationController {
        return self.storyboard!.instantiateViewController(withIdentifier: "formSheetController") as! UINavigationController
    }
    
    func centerVerticallyAction() {
        let navigationController = self.formSheetControllerWithNavigationController()
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: navigationController)
        formSheetController.presentationController?.shouldCenterVertically = true
        
        formSheetController.presentationController?.frameConfigurationHandler = { [weak formSheetController] view, currentFrame, isKeyboardVisible in
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
                return CGRect(x: formSheetController!.presentationController!.containerView!.bounds.midX - 210, y: currentFrame.origin.y, width: 420, height: currentFrame.size.height)
                
            }
            return currentFrame
        };
        
        self.present(formSheetController, animated: true, completion: nil)
    }
    
    func customContentViewSizeAction() {
        let navigationController = self.formSheetControllerWithNavigationController()
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: navigationController)
        formSheetController.presentationController?.contentViewSize = CGSize(width: view.frame.size.width-20.0, height: view.frame.size.height-60)
        
        formSheetController.contentViewControllerTransitionStyle = .bounce
        
        
        self.present(formSheetController, animated: true, completion: nil)
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
