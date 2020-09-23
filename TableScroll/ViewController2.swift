//
//  ViewController2.swift
//  TableScroll
//
//  Created by Jozef Matúš on 21/09/2020.
//  Copyright © 2020 VINEETKS. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

	@IBOutlet weak var containerVIewTopContraint: NSLayoutConstraint!
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
		label.text = "Section 1"
		label.textAlignment = .center
		label.backgroundColor = .yellow
		return label
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = "Row: \(indexPath.row+1)"
		return cell
	}

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var containerView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addGestureRecognizer(scrollView.panGestureRecognizer)
		tableView.removeGestureRecognizer(tableView.panGestureRecognizer)

		let scrollviewOrigin = scrollView.frame.origin
		scrollView.scrollIndicatorInsets = UIEdgeInsets(
			top: -scrollviewOrigin.y,
			left: 0,
			bottom: scrollviewOrigin.y,
			right: scrollviewOrigin.x
		)
	}

	override func viewDidAppear(_ animated: Bool) {
		var boundSize = tableView.contentSize
		boundSize.height += 200
		scrollView.contentSize = boundSize
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView == self.scrollView {
			guard scrollView.contentOffset.y > 200 else {
				print("GUARD CALLED")
				containerVIewTopContraint.constant = -1*scrollView.contentOffset.y
				tableView.contentOffset = CGPoint.zero
				return
			}
			containerVIewTopContraint.constant = -201
			let adjustedContentOffset = scrollView.contentOffset.applying(CGAffineTransform(translationX: 0, y: -201))
			tableView.contentOffset = adjustedContentOffset
		}
		else if scrollView == self.tableView {
			tableView.contentOffset = scrollView.contentOffset
		}
	}

}
