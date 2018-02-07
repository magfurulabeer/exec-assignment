//
//  LectureViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import AVKit
import Kingfisher

class LectureViewController: UIViewController {

  @IBOutlet weak var playerView: PlayerView!
  @IBOutlet weak var slideImageView: UIImageView!

  var viewModel: LectureViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.update = updateView
    viewModel.retrieveLectureSegment()
    playerView.addTapGestureRecognizer(action: viewModel.pauseOnTap)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.deinitialize()
    playerView = PlayerView()
  }

  func updateView() {
    guard playerView != nil else { return } // If called before uiviewcontroller lays out subviews

    OperationQueue.main.addOperation { [weak self] in
      guard let this = self else { return }
      
      if let url = this.viewModel.slideImageUrl {
        this.slideImageView.kf.setImage(with: url)
      }
      
      this.title = this.viewModel.title
      guard let url = this.viewModel.videoUrl else { return }
      if let asset = this.viewModel.player?.currentItem?.asset as? AVURLAsset, asset.url == url { return }
      
      this.playerView.player = AVPlayer(url: url)
      this.viewModel.player = this.playerView.player
      this.viewModel.player?.play()
    }
  }
}
