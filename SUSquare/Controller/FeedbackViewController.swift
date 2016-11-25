//
//  FeedbackViewController.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 19/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var feedBackText: UITextView!
    @IBOutlet weak var segmentedFeedback: UISegmentedControl!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        feedBackText.delegate = self
        feedBackText.text = "Escreva aqui seu comentário"
        feedBackText.textColor = UIColor.lightGray
        
        feedBackText.layer.borderColor = UIColor.lightGray.cgColor
        feedBackText.layer.borderWidth = 1
        feedBackText.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapedView(_ sender: UIControl) {
        feedBackText.endEditing(true)
    }
    @IBAction func openCameraButton(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController( title: "Câmera Desabilitada", message: "Não foi possível encontrar uma câmera ou ela foi desabilitada.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC, animated: true, completion: nil)
    }
    
    @IBAction func sendFeedback(_ sender: AnyObject) {
        RestManager.saveFeedback(imagePicked.image!, "teste", 222)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
}

extension FeedbackViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imagePicked.contentMode = .scaleAspectFit //3
        imagePicked.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension FeedbackViewController : UINavigationControllerDelegate{

}

extension FeedbackViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Escreva aqui seu comentário"
            textView.textColor = UIColor.lightGray
        }
    }
}
