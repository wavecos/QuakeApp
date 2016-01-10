//
//  SavedQuakesViewController.swift
//  QuakeApp
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 francisca. All rights reserved.
//

import UIKit
import RealmSwift

class SavedQuakesViewController: UITableViewController {

  var quakes = [Quake]()

  let realm = try! Realm()

  override func viewDidLoad() {
    super.viewDidLoad()

    loadSavedQuakes()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func loadSavedQuakes() {
    let rows = realm.objects(Quake.self)
    quakes = rows.map {$0}

    tableView.reloadData()
  }

  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quakes.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("QuakeCell", forIndexPath: indexPath) as! QuakeCell

    let quake = quakes[indexPath.row]

    cell.magnitudLabel.text = "\(quake.magnitude)"
    cell.placeLabel.text = "\(quake.place)"

    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "es_BO")
    dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
    cell.dateLabel.text = "\(dateFormatter.stringFromDate(quake.date))"

    return cell
  }

}
