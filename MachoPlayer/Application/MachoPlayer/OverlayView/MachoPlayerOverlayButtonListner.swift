//
//  MachoPlayerOverlayButtonListner.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation

public enum MachoPlayerOverlayButton: Equatable {
    case play
    case pause
    case seek(TimeInterval)
}

protocol MachoPlayerOverlayButtonListener: AnyObject {
    func overlayButtonTapped(_ btn: MachoPlayerOverlayButton)
}
