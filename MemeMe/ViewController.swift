//
//  ViewController.swift
//  MemeMe
//
//  Created by Kirill Sidelkovsky on 01.09.2020.
//  Copyright © 2020 sidelkovsky.com. All rights reserved.
//

import UIKit
import Device

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var topTextFieldTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomTextFieldBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    var defaultTopText : String = ""
    var defaultBottomText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultTopText = topTextField.text!
        defaultBottomText = bottomTextField.text!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(isPortrait: UIDevice.current.orientation.isPortrait)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: UI Related Methods
    
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
    
    // MARK: Keyboard related methods
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            
            view.frame.origin.y -= getKeyboardHeight(notification)
            
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    // MARK: Editing Text Fields
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == topTextField && textField.text == defaultTopText) || ( textField == bottomTextField && textField.text == defaultBottomText) {
            textField.text = ""
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var text = textField.text as NSString?
        text = text!.replacingCharacters(in: range, with: string) as NSString?
        
        textField.text = text?.uppercased
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == topTextField && textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            textField.text = defaultTopText;
            
        }else if textField == bottomTextField && textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            textField.text = defaultBottomText;
        }
    }
    
    // MARK: Selecting an Image
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage? {
            imagePickerView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
