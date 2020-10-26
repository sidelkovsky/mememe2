//
//  UIViewController+MemeMe.swift
//  MemeMe
//
//  Created by Kirill Sidelkovsky on 26.10.2020.
//  Copyright © 2020 sidelkovsky.com. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentMemeCreator(with meme: Meme? = nil) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateMemeViewContoller") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
}
