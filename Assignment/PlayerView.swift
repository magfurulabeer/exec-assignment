//
//  PlayerView.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import AVKit

class PlayerView: UIView {
  var player: AVPlayer? {
    get {
      return playerLayer.player
    }
    set {
      playerLayer.player = newValue
    }
  }
  
  var playerLayer: AVPlayerLayer {
    return layer as! AVPlayerLayer
  }
  
  // Override UIView property
  override static var layerClass: AnyClass {
    return AVPlayerLayer.self
  }
}
