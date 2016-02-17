//
//  Sale.swift
//  Babaprivé
//
//  Created by Benjamin SENECHAL on 18/12/2015.
//  Copyright © 2015 Benjamin SENECHAL. All rights reserved.
//

import Foundation

final class Sale : ResponseObjectSerializable, ResponseCollectionSerializable {
    private var _saleId : String!, _date : String!, _imageUrl : String!, _title : String!, _website : String!, _createdAt : String!, _updatedAt : String!
    
    var saleId : String{
        get{
            return _saleId
        }
    }
    
    var date : String{
        get{
            return _date
        }
    }
    
    var imageUrl : String{
        get{
            return _imageUrl
        }
    }
    
    var title : String{
        get{
            return _title
        }
    }
    
    var website : String{
        get{
            return _website
        }
    }
    
    var createdAt : String{
        get{
            return _createdAt
        }
    }
    
    var updatedAt : String {
        get {
            return _updatedAt
        }
    }
    
//    init(saleId : String!, date : String!, imageUrl : String!, title: String!, website: String!, createdAt: String!, updatedAt : String!){
//        _saleId = saleId
//        _date = date
//        _imageUrl = imageUrl
//        _title = title
//        _website = website
//        _createdAt = createdAt
//        _updatedAt = updatedAt
//    }
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        _saleId = representation.valueForKeyPath("id") as? String
        _date = representation.valueForKeyPath("date") as? String
        _imageUrl = representation.valueForKeyPath("image") as? String
        _title = representation.valueForKeyPath("title") as? String
        _website = representation.valueForKeyPath("website") as? String
        _createdAt = representation.valueForKeyPath("created_at") as? String
        _updatedAt = representation.valueForKeyPath("updated_at") as? String
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Sale] {
        var users: [Sale] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = Sale(response: response, representation: userRepresentation) {
                    users.append(user)
                }
            }
        }
        
        return users
    }
}