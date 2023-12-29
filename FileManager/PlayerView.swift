//
//  PlayerView.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2023/12/10.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
