//
//  QuakeViewController.swift
//  QuakeApp
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 francisca. All rights reserved.
//

import UIKit
import RealmSwift

class QuakeViewController: UIViewController {

  @IBOutlet weak var magnitudeLabel: UILabel!
  @IBOutlet weak var placeLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudLabel: UILabel!

  var quake : Quake?

  let realm = try! Realm()

  override func viewDidLoad() {
    super.viewDidLoad()

    if let quake = quake {
      magnitudeLabel.text = "\(quake.magnitude)"
      placeLabel.text = quake.place

      let dateFormatter = NSDateFormatter()
      dateFormatter.locale = NSLocale(localeIdentifier: "es_BO")
      dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
      dateLabel.text = "el \(dateFormatter.stringFromDate(quake.date))"

      latitudeLabel.text = "Latitud  : \(quake.latitude)"
      longitudLabel.text = "Longitud : \(quake.longitude)"
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


  @IBAction func saveQuakeAction(sender: AnyObject) {
    if let quake = quake {
      try! realm.write {
        realm.add(quake, update: true)
      }
      let message = UIAlertController(title: "Mensaje", message: "Terremoto guardado :)", preferredStyle: .Alert)
      message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
      presentViewController(message, animated: true, completion: nil)
    }
  }


}
