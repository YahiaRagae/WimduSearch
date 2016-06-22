//
//  Suggestions.swift
//
//  Created by Yahia Mahrous on 6/22/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
public class Suggestions: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSuggestionsOfferCountKey: String = "offer_count"
	internal let kSuggestionsLocalizedNameKey: String = "localized_name"
	internal let kSuggestionsLocalizedCountryNameKey: String = "localized_country_name"


    // MARK: Properties
	public var offerCount: Int?
	public var localizedName: String?
    public var type: String?
	public var localizedCountryName: String?



    public init(json: JSON) {
        offerCount = json[kSuggestionsOfferCountKey].int
        localizedName = json[kSuggestionsLocalizedNameKey].string
        localizedCountryName = json[kSuggestionsLocalizedCountryNameKey].string
        
    }

}
