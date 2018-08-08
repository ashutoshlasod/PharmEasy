//
//  ServiceModel.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation

public final class ServiceModel: NSObject,NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let page = "page"
        static let perPage = "per_page"
        static let total = "total"
        static let totalPages = "total_pages"
        static let data = "data"
    }
    
    // MARK: Properties
    public var page: Int?
    public var perPage: Int?
    public var total: Int?
    public var totalPages: Int?
    public var data: [DataModel]?
    
    init(page: Int?, perPage: Int?, total: Int?, totalPages: Int?, data: [DataModel]?){
        self.page = page
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
        self.data = data
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? Int
        self.perPage = aDecoder.decodeObject(forKey: SerializationKeys.perPage) as? Int
        self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as? Int
        self.totalPages = aDecoder.decodeObject(forKey: SerializationKeys.totalPages) as? Int
        self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [DataModel]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(page, forKey: SerializationKeys.page)
        aCoder.encode(perPage, forKey: SerializationKeys.perPage)
        aCoder.encode(total, forKey: SerializationKeys.total)
        aCoder.encode(totalPages, forKey: SerializationKeys.totalPages)
        aCoder.encode(data, forKey: SerializationKeys.data)
    }
}

extension ServiceModel : Decodable{
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum SearchResultSerializationKeys : String,CodingKey{
        case page = "page"
        case perPage = "per_page"
        case total = "total"
        case totalPages = "total_pages"
        case data = "data"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchResultSerializationKeys.self)
        
        let page = try container.decodeIfPresent(Int.self, forKey: .page)
        let perPage = try container.decodeIfPresent(Int.self, forKey: .perPage)
        let total = try container.decodeIfPresent(Int.self, forKey: .total)
        let totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        let data = try container.decodeIfPresent([DataModel].self, forKey: .data)
        
        self.init(page: page, perPage: perPage, total: total, totalPages: totalPages, data: data)
    }
}
