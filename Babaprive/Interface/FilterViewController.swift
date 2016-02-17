//
//  FilterViewController.swift
//  Babaprive
//
//  Created by Benjamin SENECHAL on 17/02/2016.
//  Copyright © 2016 Benjamin SENECHAL. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    var filterDictionnary = [Objects]()

    private var filters : Aggregation! {
        didSet {
            filterDictionnary = [
                Objects(sectionName: "content", sectionObjects: self.filters.content),
                Objects(sectionName: "title", sectionObjects: self.filters.title),
                Objects(sectionName: "website", sectionObjects: self.filters.website),
                Objects(sectionName: "date", sectionObjects: self.filters.date)
            ]
        }
    }
    
    struct Objects {
        
        var sectionName : String!
        var sectionObjects : [AnyObject]!
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager.saleBLL.initElasticSearch { (aggregation, errorMessage) -> Void in
            self.filters = aggregation
            self.filterTableView.reloadData()
        }
        

    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterDictionnary.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterDictionnary[section].sectionObjects.count

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let agg = filterDictionnary[indexPath.section].sectionObjects[indexPath.row] as! AggregationProcotol
        
        cell.textLabel?.text = agg.getKey()
        cell.detailTextLabel?.text = "\(agg.getDocCount())"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return filterDictionnary[section].sectionName
    }

}
