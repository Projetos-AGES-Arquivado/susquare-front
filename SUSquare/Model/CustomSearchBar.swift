//
//  CustomSearchBar.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 15/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import UIKit

class CustomSearchBar: UISearchBar {
    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        setShowsCancelButton(false, animated: false)
        searchBarStyle = .prominent
        isTranslucent = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i] is UITextField {
                index = i
                break
            }
        }
        
        return index
    }
    
    override func draw(_ rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
            let searchField: UITextField = (subviews[0]).subviews[index] as! UITextField
            
            searchField.attributedPlaceholder = NSAttributedString(string: "Buscar Posto de Saúde", attributes: [NSForegroundColorAttributeName:UIColor.white])
            
            UIButton.appearance(whenContainedInInstancesOf: [CustomSearchBar.self]).tintColor = .white
            
//            UIButton.appearanceWhenContainedInInstancesOfClasses().tintColor  = .white
            
            // Set its frame.
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: frame.size.width - 60.0, height: frame.size.height - 10.0)
            
            // Set the font and text color of the search field.
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            
            // Set the background color of the search field.
            searchField.backgroundColor = barTintColor
        }
        
        super.draw(rect)
    }
}
