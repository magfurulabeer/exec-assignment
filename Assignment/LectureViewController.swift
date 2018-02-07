//
//  LectureViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import AVKit

class LectureViewController: UIViewController {

  @IBOutlet weak var playerView: PlayerView!
  @IBOutlet weak var slideImageView: UIImageView!

  let viewModel = LectureViewModel()
  
  override var prefersStatusBarHidden: Bool { return true }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    playerView.player = AVPlayer(url: URL(string: "https://staging-video.execonline.com/80/mobile.mp4")!)
    viewModel.player = playerView.player
    viewModel.player?.play()
    viewModel.update = updateView

    playerView.addTapGestureRecognizer(action: viewModel.pauseOnTap)

  }

  func updateView() {
    OperationQueue.main.addOperation { [weak self] in
      guard let this = self else { return }
      
//      this.titleLabel.text = this.viewModel.title
//      this.professorLabel.text = this.viewModel.professor
//      this.dateLabel.text = this.viewModel.dateRange
//      this.tableView.reloadData()
    }
  }
}
