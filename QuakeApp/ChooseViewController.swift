//
//  ChooseViewController.swift
//  QuakeApp
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 francisca. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

  var quakeUrl : String?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func hourQuakeAction(sender: AnyObject) {
    self.quakeUrl = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
    self.performSegueWithIdentifier("quakeSegue", sender: nil)
  }


  @IBAction func dayQuakeAction(sender: AnyObject) {
    self.quakeUrl = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson"
    self.performSegueWithIdentifier("quakeSegue", sender: nil)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "quakeSegue" {
      let mapVC = segue.destinationViewController as! MapViewController
      mapVC.quakeUrl = quakeUrl
    }
  }

}
