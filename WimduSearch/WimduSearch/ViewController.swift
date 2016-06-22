//
//  ViewController.swift
//  WimduSearch
//
//  Created by Yahia Mahrous on 6/22/16.
//  Copyright © 2016 Yahia Mahrous. All rights reserved.
//

import UIKit
import MLPAutoCompleteTextField
class ViewController: UIViewController ,MLPAutoCompleteTextFieldDataSource,MLPAutoCompleteTextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    
    var searchDataFetcher:SearchDataFetcher!;
    var sugestionsList:NSMutableArray = NSMutableArray();
    
    @IBOutlet weak var tfCityName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initData();
        initViews();
        
    }
    
    
    // MARK: Class Methods
    func   initData(){
        searchDataFetcher = SearchDataFetcher();
    }
    func   initViews(){
       
    }
    // MARK: UITextFieldDelegate Methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(textField.text!.characters.count>1){
            sugestionsList = NSMutableArray()
            searchDataFetcher.search(string) { (items, status) in
                self.sugestionsList.addObjectsFromArray(items as [AnyObject]);
                self.tableView.reloadData()
                UIView.animateWithDuration(0.5) {
                    self.tableView.alpha = 1
                }
                
            }
        }
        return true
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(sugestionsList.count>0){
            if let group  : SugestionGroup =  (sugestionsList.objectAtIndex(section) as! SugestionGroup){
                return (group.suggestions?.count)!
            }
        }
        return 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sugestionsList.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let group  : SugestionGroup =  (sugestionsList.objectAtIndex(section) as! SugestionGroup){
            return group.type!
        }else{
            return ""
        }

    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
          let item : Suggestions  = (sugestionsList.objectAtIndex(indexPath.section) as!  SugestionGroup).suggestions![indexPath.row]
        cell.textLabel?.text = item.localizedName
        return cell;
    }
    
    // MARK: UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item : Suggestions  = (sugestionsList.objectAtIndex(indexPath.section) as!  SugestionGroup).suggestions![indexPath.row]
        tfCityName.text = item.localizedName
        UIView.animateWithDuration(0.5) { 
            tableView.alpha = 0
        }
    }
   
    
    
    // MARK: IBAction Methods
    
    @IBAction func btnDismissKeyBoard(sender: AnyObject) {
        tfCityName.resignFirstResponder()
    }
    
    
}

