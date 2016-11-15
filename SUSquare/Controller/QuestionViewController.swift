//
//  QuestionViewController.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 15/11/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit
protocol QuestionViewControllerDelegate {
    func didFinishReview(viewController: QuestionViewController)
}
class QuestionViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!
    var delegate: QuestionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gr = UITapGestureRecognizer(target: self, action: #selector(end))
        gr.numberOfTapsRequired = 1
        view.addGestureRecognizer(gr)
        
        if (view.tag == 2) {
            self.nextButton.isHidden = true
            self.leaveButton.backgroundColor = .green
            self.leaveButton.setTitle("Terminar pesquisa", for: .normal)
        }
    }
    
    func end() {
        self.view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? QuestionViewController {
            dest.delegate = delegate
        }
    }
    @IBAction func leaveButton(_ sender: UIButton) {
        if view.tag == 2 {
            close()
            delegate?.didFinishReview(viewController: self)
        } else {
            close()
        }
    }
    
    func close() -> Void {
        self.dismiss(animated: true, completion: nil)
    }

}
