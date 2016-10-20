//
//  PartnersViewController.swift
//  SUSquare
//
//  Created by AGES1 on 20/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class PartnersViewController: UIViewController {

    @IBOutlet weak var scrollViewPartners: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let partners = self.storyboard?.instantiateViewController(withIdentifier: "partners")
        
        self.scrollViewPartners.addSubview((partners?.view)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PartnersViewController : UIScrollViewDelegate{
    override func viewDidLayoutSubviews() {
        self.scrollViewPartners.contentSize = CGSize(width: self.scrollViewPartners.frame.width, height: 2000)
    }
}
