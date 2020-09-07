//
//  GlobalButtonStyle.swift
//  Word Search
//
//  Created by Anuraj on 9/7/20.
//  Copyright © 2020 Anuraj. All rights reserved.

import UIKit

@objc extension UIButton {
    
    dynamic var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    dynamic var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
