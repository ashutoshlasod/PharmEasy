//
//  DataModel.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation

public final class DataModel: NSObject,NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let avatar = "avatar"
    }
    
    // MARK: Properties
    public var id: Int?
    public var firstName: String?
    public var lastName: String?
    public var avatar: String?
    
    init(id: Int?, firstName: String?, lastName: String?, avatar: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
        self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
        self.avatar = aDecoder.decodeObject(forKey: SerializationKeys.avatar) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(firstName, forKey: SerializationKeys.firstName)
        aCoder.encode(lastName, forKey: SerializationKeys.lastName)
        aCoder.encode(avatar, forKey: SerializationKeys.avatar)
    }
}

extension DataModel : Decodable{
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum SearchResultSerializationKeys : String,CodingKey{
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchResultSerializationKeys.self)
        
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        let firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        let lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        let avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        
        self.init(id: id, firstName: firstName, lastName: lastName, avatar: avatar)
    }
}
