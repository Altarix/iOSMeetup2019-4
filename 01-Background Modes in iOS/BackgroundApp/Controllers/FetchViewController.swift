//
//  FetchViewController.swift
//  BackgroundApp
//
//  Created by AikOganisyan on 25/11/2019.
//  Copyright © 2019 icos. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name("fetchNewData"), object: nil)
        label.text = "No data"
    }
    
    @objc private func handleNotification() {
        label.text = Service.shared.model.name
    }

}
