//
//  MachoPlayerButtonListner.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation
import UIKit

extension MachoPlayer: MachoPlayerOverlayButtonListener{
    
    func overlayButtonTapped(_ btn: MachoPlayerOverlayButton) {
        overlayView?.updateTimer()
        switch btn {
        case .play:
            print("play")
        case .pause:
            print("pause")
        case .seek(let timeInterval):
            print("seek to \(timeInterval)")
        }
    }
    
}
