//
//  Aggregation.swift
//  Babaprive
//
//  Created by Benjamin SENECHAL on 17/02/2016.
//  Copyright © 2016 Benjamin SENECHAL. All rights reserved.
//

import Foundation

final class Aggregation : ResponseObjectSerializable {
    private var _content : [Content]!, _date : [Date]!, _website : [Website]!, _title : [Title]!

    var date : [Date]{
        get{
            return _date
        }
    }
    
    var website : [Website]{
        get{
            return _website
        }
    }
    
    var title : [Title] {
        get {
            return _title
        }
    }
    
    var content : [Content]{
        get{
            return _content
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
        
        
        _content = Content.collection(response: response, representation: representation.valueForKeyPath("aggregations.content.buckets")!)
        _date = Date.collection(response: response, representation: representation.valueForKeyPath("aggregations.date.buckets")!)
        _website = Website.collection(response: response, representation: representation.valueForKeyPath("aggregations.website.buckets")!)
        _title = Title.collection(response: response, representation: representation.valueForKeyPath("aggregations.titleraw.buckets")!)
    }
    
}

protocol AggregationProcotol {
    func getKey() -> String
    func getDocCount() -> Int
}


final class Content : ResponseObjectSerializable,ResponseCollectionSerializable, AggregationProcotol {
    var key : String!, doc_count : Int!
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        key = representation.valueForKeyPath("key") as? String
        doc_count = representation.valueForKeyPath("doc_count") as? Int
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Content] {
        var content: [Content] = []
        
        if let rpt = representation as? [[String: AnyObject]] {
            for userRepresentation in rpt {
                if let user = Content(response: response, representation: userRepresentation) {
                    content.append(user)
                }
            }
        }
        return content
    }
    
    func getDocCount() -> Int {
        return doc_count
    }

    func getKey() -> String {
        return key
    }
}

final class Title : ResponseObjectSerializable, ResponseCollectionSerializable, AggregationProcotol {
    
    var key : String!, doc_count : Int!
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        key = representation.valueForKeyPath("key") as? String
        doc_count = representation.valueForKeyPath("doc_count") as? Int
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Title] {
        var title: [Title] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = Title(response: response, representation: userRepresentation) {
                    title.append(user)
                }
            }
        }
        return title
    }
    
    
    func getDocCount() -> Int {
        return doc_count
    }
    
    func getKey() -> String {
        return key
    }
    
}

final class Website : ResponseObjectSerializable, ResponseCollectionSerializable, AggregationProcotol {
    
    var key : String!, doc_count : Int!
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        key = representation.valueForKeyPath("key") as? String
        doc_count = representation.valueForKeyPath("doc_count") as? Int
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Website] {
        var website: [Website] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = Website(response: response, representation: userRepresentation) {
                    website.append(user)
                }
            }
        }
        return website
    }
    
    func getDocCount() -> Int {
        return doc_count
    }
    
    func getKey() -> String {
        return key
    }

}

final class Date : ResponseObjectSerializable, ResponseCollectionSerializable, AggregationProcotol {
    
    var key : String!, doc_count : Int!

    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        
        key = String(representation.valueForKeyPath("key")!)
        doc_count = representation.valueForKeyPath("doc_count") as? Int
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Date] {
        var date: [Date] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = Date(response: response, representation: userRepresentation) {
                    date.append(user)
                }
            }
        }
        return date
    }
    
    func getDocCount() -> Int {
        return doc_count
    }
    
    func getKey() -> String {
        return key
    }

}

