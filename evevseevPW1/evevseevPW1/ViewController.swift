//
//  ViewController.swift
//  evevseevPW1
//
//  Created by Евгений Евсеев on 17.09.2022.
//

import UIKit

// Возможно стоит использовать extension к UIColor, но пока мы их не проходили
// и я решил оставить так
func hexNumToUIColor (hex:UInt64) -> UIColor {
    return UIColor(
        red: CGFloat((hex & 0xFF0000) >> 16) / 255,
        green: CGFloat((hex & 0x00FF00) >> 8) / 255,
        blue: CGFloat(hex & 0x0000FF) / 255,
        alpha: 1
    )
}

func hexStringToUIColor (hex:String) -> UIColor {
    var parsedString = hex;
    if (parsedString.hasPrefix("#")) {
        parsedString.remove(at: hex.startIndex)
    }

    var rgbValue:UInt64 = 0
    Scanner(string: parsedString).scanHexInt64(&rgbValue)
    
    return hexNumToUIColor(hex: rgbValue)
}

func generateRandomHex() -> UInt64 {
    return .random(in: 0...255*255*255)
}

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyRandomViewsColors()
        self.applyRandomViewsRadiuses()
    }
    
    // Update views radius  on screen resize (resize is possible only on iPads)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.applyRandomViewsRadiuses()
            })
        }
    }
    
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.applyRandomViewsColors()
            self.applyRandomViewsRadiuses()
        }) { completion in
            button?.isEnabled = true
        }
    }
    
    func applyRandomViewsColors() {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(hexNumToUIColor(hex: generateRandomHex()))
        }
        for view in self.views {
            view.backgroundColor = set.popFirst()
        }
    }
    
    func applyRandomViewsRadiuses() {
        for view in self.views {
            view.layer.cornerRadius = .random(
                in: 0...CGFloat.minimum(view.frame.height, view.frame.width) / 2
            )
        }
    }
}

