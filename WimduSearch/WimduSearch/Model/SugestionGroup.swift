//
//  SugestionGroup.swift
//  WimduSearch
//
//  Created by Yahia Mahrous on 6/22/16.
//  Copyright © 2016 Yahia Mahrous. All rights reserved.
//

import Foundation
import SwiftyJSON
public class SugestionGroup: NSObject {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kSugestionGroupType : String = "type"
    internal let kSugestionGroupSugestions: String = "suggestions"
    
    
    // MARK: Properties
    public var type: String?
    public var suggestions: [Suggestions]?
    
    
    
    public init(json: JSON) {
        type = json[kSugestionGroupType].string
        suggestions = []
        
        let suggestionsArray = json[kSugestionGroupSugestions].array
        for i in 0 ..< suggestionsArray!.count{
            let item : Suggestions = Suggestions(json: suggestionsArray![i])
            suggestions?.append(item)
        }
            
        
        
    }
    
}