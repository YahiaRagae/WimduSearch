//
//  BaseDataFetcher.swift
//  WimduSearch
//
//  Created by Yahia Mahrous on 6/22/16.
//  Copyright © 2016 Yahia Mahrous. All rights reserved.
//

import Foundation 
import Alamofire

// MARK: BaseDataFetcher

@objc public class  BaseDataFetcher: NSObject   {
    public static let SETTINGS_MAIN_URL:String = "MainURL"
    public static let SETTINGS_URLs:String = "URLs"
    public let message:String = "loading"
    public let messageCancelled:String = "cancelled"
    
    enum SucessFlag {
        case deafult
    }
    
    var currentRquest: Alamofire.Request?
    
    
    public func getRequestWithJsonReponse(link link:String , andSearchKewWord searchWord:String,  withCompletion completion:(response : Response<AnyObject, NSError> , status : Bool )->Void ){
        if(currentRquest != nil){
            currentRquest?.cancel()
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let request = NSMutableURLRequest(URL: NSURL(string: link)!)
        request.cachePolicy = .ReturnCacheDataElseLoad
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //let bodyString = "\"q\" = \"\(searchWord)\""
        //request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding);
        
        currentRquest = Alamofire.request(request)
            .validate()
            .responseJSON { response in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                switch response.result {
                case .Success:
                    NSLog("Success")
                    completion(response: response , status: true)
                case .Failure:
                    NSLog("Failure")
                    completion(response: response , status: false)
                    
                    
                }
        }
    }
    
    
    
    
    public func getSettingdDictionary() ->NSDictionary!
    {
        if let path = NSBundle.mainBundle().pathForResource("Settings", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
    public func getLink(endPointName:String) ->String{
        var link = "";
        
        let settingsDic:NSDictionary = getSettingdDictionary();
        
        let urls:NSDictionary = settingsDic.objectForKey(BaseDataFetcher.SETTINGS_URLs) as! NSDictionary
        
        link = (settingsDic.objectForKey(BaseDataFetcher.SETTINGS_MAIN_URL) as! String) +  (urls.objectForKey(endPointName) as! String)
        
        return link;
    }
    
    
}