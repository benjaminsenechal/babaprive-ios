//
//  SaleBLL.swift
//  Babaprivé
//
//  Created by Benjamin SENECHAL on 18/12/2015.
//  Copyright © 2015 Benjamin SENECHAL. All rights reserved.
//

import Foundation
import Alamofire

class SaleBLL {
    private var _saleSAL : SaleSAL
    
    init(saleSAL:SaleSAL) {
        _saleSAL = saleSAL
    }
    
    func retrieveSales(salesClosure:((sales : [Sale]?,errorMessage:String!)->Void)) {
        _saleSAL.retrieveSales { (sales, errorMessage) -> Void in
            guard errorMessage == nil else {
                salesClosure(sales: nil, errorMessage: errorMessage)
                return
            }
            
            salesClosure(sales: sales, errorMessage: nil)
        }
    }
    
    func initElasticSearch(filtersClosure:((aggregation : Aggregation?,errorMessage:String!)->Void)) {
        
        _saleSAL.initElasticSearch { (aggregation, errorMessage) -> Void in
            guard errorMessage == nil else {
                filtersClosure(aggregation: nil, errorMessage: errorMessage)
                return
            }
            
            filtersClosure(aggregation: aggregation, errorMessage: nil)
        }
        
    }
    
}