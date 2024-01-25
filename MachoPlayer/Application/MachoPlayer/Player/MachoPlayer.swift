//
//  MachoPlayer.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation
import UIKit
import AVKit

protocol MachoPlayerItemManager: AnyObject{
    func previous(prevInfo info: MovieViewModel)
    func next(nextInfo info: MovieViewModel)
}

final class MachoPlayer: UIViewController{
    
    public private(set) var player = AVPlayer()
    
    weak var itemManager: MachoPlayerItemManager?
    
    internal var fullScreenViewController = MachoFullScreenPlayer()
    
    internal var overlayView: MachoPlayerOverlayInterface? {
        willSet {
            overlayView?.removeFromSuperview()
        } didSet {
            guard let overlayView = overlayView else{ return }
            view.addSubview(overlayView)
            
            overlayView.buttonListner = self
        }
    }
    
    internal var playerInfo: MovieViewModel? = nil{
        didSet{
            guard let playerInfo = playerInfo else{ return }
        }
    }
    
    
}
