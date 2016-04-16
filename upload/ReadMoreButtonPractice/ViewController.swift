//
//  ViewController.swift
//  ReadMoreButtonPractice
//
//  Created by Suraj MAC2 on 4/14/16.
//  Copyright © 2016 supaint. All rights reserved.
//

import UIKit


class mainTableViewCell : UITableViewCell{
    
    
//TODO: - General
    
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var txtDescription: UITextView!
    
   
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UITextViewDelegate {

    
//TODO: - General
    
    var indexOfExpandedCell : NSIndexPath = NSIndexPath()
    var shouldCellBeExpanded : Bool = Bool()
    
     var selectedItemArray : [String] = ["0","0","0","0","0","0","0","0","0"]
    
//TODO: - Controls
    
    @IBOutlet weak var tblMain: UITableView!
    
    
    
//TODO: - Let's Play
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//TODO: - UITableViewDatasource Method implementation
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return selectedItemArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as! mainTableViewCell
        
        cell.outerView.layer.cornerRadius = 5.0
        
               if(selectedItemArray[indexPath.row] == "0"){
               
                cell.txtDescription.text = " Apps that require users to share personal information, such as email address and date of birth, in order to function will be rejected.It also states that your app is asking to create an account to access the full app and even needs the account or access features that do not require the user to have an account. You can make those features available without the account creating you might be able to get through the review."
                
                cell.txtDescription.delegate = self
                

                
            //Normal Cell
            print("Normal Cell Height")
            if(cell.txtDescription.text.utf16.count >= 100){
                var abc : String = (cell.txtDescription.text as NSString).substringWithRange(NSRange(location: 0, length: 100))
                
                abc += "...ReadMore"
                cell.txtDescription.text = abc
                
                
                let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: abc)
                attributedString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16), range: NSMakeRange(0, abc.characters.count))
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1.0), range: NSMakeRange(0, abc.characters.count))
                attributedString.addAttribute(NSLinkAttributeName, value: "...ReadMore", range: NSRange(location: 100, length: 11))
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 249/255, green: 64/255, blue: 82/255, alpha: 1.0), range: NSMakeRange(100, 11))
                attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSRange(location: 100, length: 11))
                cell.txtDescription.tag = indexPath.row
                cell.txtDescription.attributedText = attributedString
                
                //selectedItemArray[indexPath.row] = "0"
            }
        }else{
            
            //Modified Cell
            print("sss:\(indexPath.row)")
            print("Modified Cell Height")
                
                cell.txtDescription.text = " Apps that require users to share personal information, such as email address and date of birth, in order to function will be rejected.It also states that your app is asking to create an account to access the full app and even needs the account or access features that do not require the user to have an account. You can make those features available without the account creating you might be able to get through the review."
                
                cell.txtDescription.delegate = self
            
        }
       
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(shouldCellBeExpanded && indexPath == indexOfExpandedCell){
            
            return 200.0
        }else{
            return 150.0
        }
    }

    
    
    //The function you said i have written here
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool
    {
        print(textView.tag)
        
        // textView.sizeToFit()
        var oldindx : NSIndexPath = NSIndexPath(forRow: textView.tag, inSection: 0)
        
        indexOfExpandedCell = NSIndexPath(forRow: textView.tag, inSection: 0)
       
        //indexOfExpandedCell = textView.tag
        
        for ind in 0...selectedItemArray.count-1{
            if(selectedItemArray[ind] == "1"){
                oldindx = NSIndexPath(forRow: ind, inSection: 0)
            }
            if(ind == textView.tag){
                 selectedItemArray[ind] = "1"
            }else{
                 selectedItemArray[ind] = "0"
            }
        }
        print(selectedItemArray)
       // selectedItemArray[textView.tag] = "1"
        shouldCellBeExpanded = true
        
        self.tblMain.beginUpdates()
       // if(oldindx != -1){
            self.tblMain.reloadRowsAtIndexPaths([oldindx], withRowAnimation: UITableViewRowAnimation.None)
        //}
        self.tblMain.reloadRowsAtIndexPaths([indexOfExpandedCell], withRowAnimation: UITableViewRowAnimation.None)
        self.tblMain.endUpdates()
        
        return false
    }

}

