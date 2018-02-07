//
//  CourseViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import RealmSwift

class CourseViewController: UITableViewController {

  
  @IBOutlet weak var professorLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  
  // MARK: - Properties
  
  // Implement coordinator to inject vm into vc
  var viewModel: CourseViewModel! {
    didSet {
      updateView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    viewModel.update = updateView
    viewModel.retrieveCourse()
  }

  @IBAction func didTapStartButton(_ sender: UIButton) {
    if viewModel.numberOfModules > 0 {
      viewModel.didSelectLectureSegment(module: 0, Index: 0)
    }
  }
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfModules
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfSegments(module: section)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let segment = viewModel.segment(module: indexPath.section, index: indexPath.row)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = segment.name

    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.moduleLabel(for: section)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectLectureSegment(module: indexPath.section, Index: indexPath.row)
  }

  func updateView() {
    guard titleLabel != nil else { return } // If called before uiviewcontroller lays out subviews

    OperationQueue.main.addOperation { [weak self] in
      guard let this = self else { return }
      
      if let url = this.viewModel.headerImage {
        this.headerImageView.kf.setImage(with: url)
      }
      
      this.title = this.viewModel.navbarTitle
      this.titleLabel.text = this.viewModel.title
      this.professorLabel.text = this.viewModel.professor
      this.dateLabel.text = this.viewModel.dateRange
      this.tableView.reloadData()
    }
  }
}
