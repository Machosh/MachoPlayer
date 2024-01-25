//
//  MachoPlayerOverlayInterface.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation
import AVKit

public enum overlayType{
    case live
    case vod
    case clip
}

protocol MachoPlayerOverlayManager: AnyObject{
    func hideOverlay()
}

class MachoPlayerOverlayInterface: UIView{
    
    weak var buttonListner: MachoPlayerOverlayButtonListener?
    weak var interfaceManager: MachoPlayerOverlayManager?
    
    let playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: ""), for: .normal)
        btn.isHidden = false
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let pauseButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: ""), for: .normal)
        btn.isHidden = false
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
}

extension MachoPlayerOverlayInterface{
    public func updateTimer(){
        
    }
}
