//
//  ViewController.swift
//  Babaprive
//
//  Created by Benjamin SENECHAL on 18/12/2015.
//  Copyright © 2015 Benjamin SENECHAL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var _sales : [Sale]!

    @IBOutlet weak var salesTableView: UITableView!
    var expandedIndexPath: NSIndexPath? {
        didSet {
            switch expandedIndexPath {
            case .Some(let index):
                salesTableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
            case .None:
                salesTableView.reloadRowsAtIndexPaths([oldValue!], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.salesTableView.rowHeight = UITableViewAutomaticDimension
        self.salesTableView.estimatedRowHeight = 150
        
        DataManager.saleBLL.retrieveSales { (sales, errorMessage) -> Void in
            self._sales = sales
            self.salesTableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _sales == nil ? 0 : _sales.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sale", forIndexPath: indexPath) as! SaleTableViewCell
        cell.sale = _sales[indexPath.row]
        
        cell.onStateUpdate = {() -> Void in
            switch self.expandedIndexPath {
            case .Some(_) where self.expandedIndexPath == indexPath:
                self.expandedIndexPath = nil
            case .Some(let expandedIndex) where expandedIndex != indexPath:
                self.expandedIndexPath = nil
                //self.tableView(tableView, didSelectRowAtIndexPath: indexPath)
            default:
                self.expandedIndexPath = indexPath
            }
        }
        
        switch expandedIndexPath {
        case .Some(let expandedIndexPath) where expandedIndexPath == indexPath:
            cell.showsDetails = true
        default:
            cell.showsDetails = false
        }
        
        return cell
    }
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        switch expandedIndexPath {
        case .Some(_) where expandedIndexPath == indexPath:
            expandedIndexPath = nil
        case .Some(let expandedIndex) where expandedIndex != indexPath:
            expandedIndexPath = nil
            self.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        default:
            expandedIndexPath = indexPath
        }
    }
    */
}


