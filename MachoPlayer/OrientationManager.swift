//
//  OrientationManager.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation
import UIKit

enum transitionDirection{
    case left
    case right
}

protocol OrientationManager{}

extension OrientationManager where Self: UIViewController{
    
    func updateOrientation(_ orientation: UIInterfaceOrientationMask){
        (UIApplication.shared.delegate as? AppDelegate)?.orientation = orientation
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        if #available(iOS 16.0, *) {
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
        } else {
            
        }

        if #available(iOS 16.0, *) {
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            
        }
    }
    
}
