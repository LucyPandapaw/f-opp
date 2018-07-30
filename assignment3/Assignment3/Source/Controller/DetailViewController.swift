//
//  DetailViewController.swift
//  Assignment3
//
//  Created by Fangjian Shang on 7/11/18.
//  Copyright © 2018 CIS 410. All rights reserved.
//
import UIKit

class DetailViewController : UIViewController {
	weak var delegate : DetailViewControllerDelegate?

    @IBOutlet private weak var timeLabel: UILabel!

	//invoked by "perform Action" to inform user's action??
    @IBAction func userTakenAction (_ sender: Any) {
        delegate?.detailViewControllerDidWork(self)
    }

    //update time label
    override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		let currentTimeValue = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
        timeLabel.text = "Presented at \(currentTimeValue)"
    }
    
}
