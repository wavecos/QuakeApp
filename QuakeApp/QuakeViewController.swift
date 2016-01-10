//
//  QuakeViewController.swift
//  QuakeApp
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 francisca. All rights reserved.
//

import UIKit

class QuakeViewController: UIViewController {


  @IBOutlet weak var magnitudeLabel: UILabel!

  var quake : Quake?

  override func viewDidLoad() {
    super.viewDidLoad()

    if let quake = quake {
      magnitudeLabel.text = "\(quake.magnitude)"
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
