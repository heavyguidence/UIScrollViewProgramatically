//
//  Extension.swift
//  ScrollView
//
//  Created by Gurjap on 2022-04-10.
//

import Foundation
import UIKit

extension UITextField {
    
    //set left padding in text field
    func setLeftPaddingPoints(_ amount : Double) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
