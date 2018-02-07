//
//  LectureViewModel.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import AVKit
import RealmSwift
import Bond

class LectureViewModel: NSObject {
  
  var update: () -> Void = {} // <- Could be injected
  private let courseId: Int = 119 // <- Should be injected
  private let id: Int = 1454 // <- Should be injected
  fileprivate var lectureSegment: LectureSegment = LectureSegment()
 
  
  private var playerController = AVPlayerViewController() {
    didSet {
      // What if user scrubs backwards?
      let times = Array(slides).map { NSValue(time: CMTime(seconds: Double($0.startAt), preferredTimescale: 1)) }
      
      player?.addBoundaryTimeObserver(forTimes: times, queue: DispatchQueue.main, using: { [weak self] in
        guard let this = self else { return }

        let matchingSlides = this.slides.filter({ $0.startAt == this.duration })
        guard let slide = matchingSlides.first else { return }
        
        this.currentSlide = slide
        this.update()
      })
    }
  }
  
  private let courseManager = CourseManager()
  
//  init(courseId: Int, id: Int) {
//    super.init()
//    self.courseId = courseId
//    self.id = id
//  }
  
  func retrieveLectureSegment() {
    courseManager.retrieveLectureSegment(courseId: courseId, id: id).then { [weak self] segment -> Void in
      guard let this = self else { fatalError() }
      this.lectureSegment = segment
      this.update()
    }
  }
  
  lazy var currentSlide: Slide = {
    return slides.first ?? Slide()
  }()
}

extension LectureViewModel {
  // Maybe should be in model?
  var videoUrl: URL? {
    return URL(string: lectureSegment.videoUrlString)
  }
  
  var slides: List<Slide> {
    return lectureSegment.slides
  }
  
  // Todo: Kingfisher
//  var slideImage: UIImage {
//    guard let url = currentSlide.imageUrl else { return UIImage() }
//    return UIImage(
//  }
}

// MARK: - Player Controls
extension LectureViewModel {
  var player: AVPlayer? {
    get {
      return playerController.player
    }
    set {
      playerController.player = newValue
    }
  }
  
  var isPlaying: Bool {
    guard let player = player else { return false }
    return player.rate > 0 && player.error == nil
  }
  
  var duration: Int {
    guard let time = player?.currentItem?.asset.duration else { return 0 }
    let seconds = CMTimeGetSeconds(time)
    return Int(seconds.truncatingRemainder(dividingBy: 60))
  }
  
  func pauseOnTap() {
    isPlaying ? player?.pause() : player?.play()
  }
}
