//
//  SaleSAL.swift
//  Babaprivé
//
//  Created by Benjamin SENECHAL on 18/12/2015.
//  Copyright © 2015 Benjamin SENECHAL. All rights reserved.
//

import Foundation
import Alamofire

class SaleSAL {
    init() {
    }
    
    func retrieveSales(salesClosure:((Sales:[Sale]?,errorMessage:String!)->Void)) {
        Alamofire.request(.GET, "https://www.babaprive.fr/api")
            .responseCollection { (response: Response<[Sale], NSError>) in
                
                guard response.result.error == nil else {
                    print("error in API login -> " + String(response.result.error!))
                    salesClosure(Sales: nil, errorMessage: response.result.error?.description)
                    return
                }
                debugPrint(response)
                salesClosure(Sales: response.result.value! as [Sale], errorMessage: nil)
        }
    }
    
    func initElasticSearch(filtersClosure:((aggregation : Aggregation?,errorMessage:String!)->Void)) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://babaprive.fr:4000/babaprive/sale/_search")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(convertStringToDictionary(), options: [])
        Alamofire.request(request)
            .responseObject { (response: Response<Aggregation, NSError>) in
                
                guard response.result.error == nil else {
                    print("error in API login -> " + String(response.result.error!))
                    filtersClosure(aggregation: nil, errorMessage: "error in API login -> "+String(response.result.error!))
                    return
                }
                
                let agg = response.result.value! as Aggregation
                filtersClosure(aggregation: agg, errorMessage: nil)
        }
        
    }
    
    func convertStringToDictionary() -> [String: AnyObject]! {
        
        
        if let path = NSBundle.mainBundle().pathForResource("string", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                return jsonDict
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
        
    }
}