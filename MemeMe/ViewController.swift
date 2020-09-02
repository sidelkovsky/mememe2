//
//  ViewController.swift
//  MemeMe
//
//  Created by Kirill Sidelkovsky on 01.09.2020.
//  Copyright © 2020 sidelkovsky.com. All rights reserved.
//

import UIKit
import Device

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var topTextFieldTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomTextFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(isPortrait: UIDevice.current.orientation.isPortrait)
    }

    // small font for landscape of all devices
    // small font for iPhone SE; ios 13 is not supported on iPhone < 6, so we don't care others
    // normal font for everybody else
    func updateUI(isPortrait: Bool) {

        var fontSize = 36
        
        let smallScreen = Device.size() < Size.screen4_7Inch
                    
        // iPhone SE in Landscape mode
        if smallScreen && !isPortrait {
            topTextFieldTopConstraint.constant = 9
            bottomTextFieldBottomConstraint.constant = -9
            fontSize = 22
        // iPhone SE in Portrait mode and other models in Landscape Mode
        } else if smallScreen || !isPortrait {
            topTextFieldTopConstraint.constant = 18
            bottomTextFieldBottomConstraint.constant = -18
            fontSize = 28
        // iPhone 6 and higher in Portrait mode
        } else {
            topTextFieldTopConstraint.constant = 36
            bottomTextFieldBottomConstraint.constant = -36
        }
        
        updateTextField(topTextField, CGFloat(fontSize))
        updateTextField(bottomTextField, CGFloat(fontSize))
    }
    
    func updateTextField(_ textField: UITextField, _ fontSize: CGFloat) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: fontSize)!,
            .strokeWidth: -2
        ]
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.autocorrectionType = .no
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateUI(isPortrait: UIDevice.current.orientation.isPortrait)
    }

}

