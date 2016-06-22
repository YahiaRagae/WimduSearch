//
//  SearchDataFetcher.swift
//  WimduSearch
//
//  Created by Yahia Mahrous on 6/22/16.
//  Copyright © 2016 Yahia Mahrous. All rights reserved.
//

import Foundation
import SwiftyJSON

import Alamofire

class SearchDataFetcher: BaseDataFetcher {
    let URL_SEARCH_SUGGESTIONS : String = "URL_SEARCH_SUGGESTIONS"
    let SEARCH_WORD_PARAM : String = "q"
    
    func search(searchWord : String  , withCompletion completion:(items : NSMutableArray, status : Bool )->Void)
    {
        let link = getLink(URL_SEARCH_SUGGESTIONS)
        
        
        getRequestWithJsonReponse(link: link, andSearchKewWord: searchWord) { (response, status) in
            let items:NSMutableArray = self.parseSugestions(response: response)
            completion(items: items , status: status)
        }
    }
    
    
    
    // MARK: Parsers
    func parseSugestions(response response: Response<AnyObject, NSError>) -> NSMutableArray{
        let items:NSMutableArray = NSMutableArray();
        if(response.result.value != nil ){
            let result = JSON(response.result.value!)
            
            if(result["search_suggestions"].count > 0){
                let resultArray = result["search_suggestions"];
                
                for i in 0 ..< resultArray.count{
                    let item:SugestionGroup = SugestionGroup(json: resultArray[i]  )
                    items.addObject(item)
                }
            }
            
        }
        
        return items;
    }
    
}