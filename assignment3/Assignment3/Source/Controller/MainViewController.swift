//
//  MainViewController.swift
//  Assignment3
//
//  Created by Fangjian Shang on 7/11/18.
//  Copyright © 2018 CIS 410. All rights reserved.
//

import UIKit

class MainViewController : UIViewController, DetailViewControllerDelegate {
    
    @IBOutlet private weak var countLabel: UILabel!

	private var countAction: Int = 0

    //keep track action times and update label
    override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
        countLabel.text = "The detail action has been performed \(countAction) time\(countAction == 1 ? "" : "s")"
    }

	func detailViewControllerDidWork(_ detailViewController: DetailViewController) {
		countAction += 1
	}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewControllerSegue"{
            let detailViewController = segue.destination as! DetailViewController
			detailViewController.delegate = self
        }
		else {
			super.prepare(for: segue, sender: sender)
		}
    }
    
    @IBAction func modelViewDidFinish(_ sender: UIStoryboardSegue) { }
}
