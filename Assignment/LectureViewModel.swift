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

class LectureViewModel: ViewModel {
  var coordinator: Coordinator
  var update: () -> Void!
  private let courseId: Int
  private let id: Int
  fileprivate var lectureSegment: LectureSegment = LectureSegment()
  private var playerController = AVPlayerViewController()
  
  private let courseManager = CourseManager()
  
  init(coordinator: Coordinator, update: @escaping () -> Void, courseId: Int, id: Int) {
    self.coordinator = coordinator
    self.update = update
    self.courseId = courseId
    self.id = id
  }
  
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
  
  var slideImageUrl: URL? {
    return currentSlide.imageUrl
  }
  
  var title: String {
    return lectureSegment.label
  }
}

// MARK: - Player Controls
extension LectureViewModel {
  var player: AVPlayer? {
    get {
      return playerController.player
    }
    set {
      playerController.player = newValue
      guard newValue != nil else { return }
      // Todo: Improve algorithm. Too inefficient.
      player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: Double(1), preferredTimescale: 1), queue: DispatchQueue.main, using: { [weak self] (time) in
        guard let this = self else { return }
        let currentTime = Int(CMTimeGetSeconds(time))
        
        this.currentSlide = this.slides.reduce(Slide(), { (result, slide) -> Slide in
          let beforeCurrentTime = slide.startAt <= currentTime
          let isLatestResult = slide.startAt > result.startAt

          if beforeCurrentTime &&  isLatestResult {
            return slide
          }
          return result
        })

        // if currentSlide and reducesSlide are same, don't update. if they're different, update currentSlide and update()
        this.update()
      })
      
      // Does not work
//      let times = Array(slides).map { NSValue(time: CMTime(seconds: Double($0.startAt), preferredTimescale: 1)) }
//      player?.addBoundaryTimeObserver(forTimes: times, queue: DispatchQueue.main, using: { [weak self] in
//        guard let this = self else { return }
//
//        print("~~~~~~~~~~~~~~")
//
//        print(this.duration)
//        let matchingSlides = this.slides.filter({ $0.startAt == this.duration })
//        guard let slide = matchingSlides.first else { return }
//
//        this.currentSlide = slide
//        this.update()
//      })
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
  
  func deinitialize() {
    player?.pause()
    player = nil
  }
}
