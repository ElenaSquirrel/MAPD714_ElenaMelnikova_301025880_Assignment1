//
//  ViewController.swift
//  MAPD714_ElenaMelnikova_301025880
//
//  Created by Elena Melnikova on 2018-09-25.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    
    var screenNumber:Double? = nil;
    

    var previousNumber:Double? = nil;
    
  
    var operation:Int? = nil;
    
 
    var performingMath = false;
    

    @IBOutlet weak var label:UILabelPadding! //UILabel! with paddings that set in UILabelPaddind.swift
    
    func normalize(input:String) -> String {
     
        let isMinus = String(input.prefix(1))
        var str: String;
        
      
        if isMinus == "-" {
        
            str = String(input.prefix(9))
        } else {
          
            str = String(input.prefix(9))
        }
        

        return str
    }
    
  
    func normalize(input:Double) -> String {
        let str = String(input)
        return normalize(input:str)
    }
    

    @IBAction func numberField(_ sender: UIButton) {

        
    }

    @IBAction func operationsField(_ sender: UIButton) {

        
        
    
    
    
    
    }
    
}
