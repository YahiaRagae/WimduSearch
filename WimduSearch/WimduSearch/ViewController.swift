//
//  ViewController.swift
//  WimduSearch
//
//  Created by Yahia Mahrous on 6/22/16.
//  Copyright © 2016 Yahia Mahrous. All rights reserved.
//

import UIKit
import MLPAutoCompleteTextField
class ViewController: UIViewController ,MLPAutoCompleteTextFieldDataSource,MLPAutoCompleteTextFieldDelegate{
    
    var searchDataFetcher:SearchDataFetcher!;
    @IBOutlet weak var tfCityName: MLPAutoCompleteTextField!
    
    
    
    // MARK: UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchDataFetcher = SearchDataFetcher();
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: MLPAutoCompleteTextFieldDelegate Methods
    
    // MARK: MLPAutoCompleteTextFieldDataSource Methods
    func autoCompleteTextField(textField: MLPAutoCompleteTextField!, possibleCompletionsForString string: String!, completionHandler handler: (([AnyObject]!) -> Void)!) {
        let sugestionsStr : NSMutableArray = NSMutableArray();
        if(string.characters.count > 2){
            searchDataFetcher.search(string) { (items, status) in
                for i in 0 ..< items.count{
                    let group:SugestionGroup = items.objectAtIndex(i) as! SugestionGroup
                    for x in 0 ..< group.suggestions!.count{
                        let item:Suggestions =  group.suggestions![x] 
                        sugestionsStr.addObject("\(item.localizedName!) - "  + group.type!)
                    }
                    
                }
                handler(sugestionsStr as [AnyObject])
                
            }
        }else{
            handler(sugestionsStr as [AnyObject])
        }
        
        
        
    }


}

