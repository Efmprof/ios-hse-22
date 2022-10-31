//
//  CALayer+Shadow.swift
//  evevseevPW2
//
//  Created by Евгений Евсеев on 30.09.2022.
//

import UIKit

extension CALayer {
    enum ShadowWeight {
        case light
    }
    
    func applyShadow(weight: ShadowWeight = .light) {
        switch weight {
        case .light:
            shadowColor = UIColor.black.cgColor
            shadowOffset = CGSize(width:0, height:8)
            shadowRadius = 10;
            shadowOpacity = 0.04;
        }
    }
}
