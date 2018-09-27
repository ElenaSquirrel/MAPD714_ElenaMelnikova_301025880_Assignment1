//
//  ViewController.swift
//  MAPD714_ElenaMelnikova_301025880
//  Calculator
//  Created by Elena Melnikova on 2018-09-25.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    //Number displayed on screen
    var screenNumber:Double? = nil
    
    //Number displayed on screen before operation
    var previousNumber:Double? = nil
    
    //Operation
    var operation:Int? = nil
    
    //Flag showing if operation is in progress
    var performingMath = false
    
    @IBOutlet weak var label:UILabelPadding! //UILabel! with paddings that set in UILabelPaddind.swift
    //Normalize string to string
    func normalize(input:String) -> String {
        
        let isMinus = String(input.prefix(1))
        var str: String
        //Take first 9 chars including "-" sign or 8 chars excluding "+" sign
        
        //Take first 9 chars (with "-")
        
        if isMinus == "-" {
            
            str = String(input.prefix(9))
        } else {
            //Take first 8 chars (no "-"
            str = String(input.prefix(8))
        }
        //Remove trailing "0"
        if str.contains(".") {
            while str.last! == "0" {
                str = String(str.dropLast())
            }
        }
        
        //Remove last "."
        if str.last == "." {
            str = String(str.dropLast())
        }
        
        return str
    }
    //Normalize double to string
    
    func normalize(input:Double) -> String {
        let str = String(input)
        return normalize(input:str)
    }
    //Process number entered
    
    @IBAction func numberField(_ sender: UIButton) {
        
        //Do not allow enter second "." if "." already presents in label
        
        if sender.tag == 0 && (label.text!.contains(".")) {
            return
        }
        
        if performingMath == true {
            
            //Current mode Performing math switchs to Entering numbers mode
            
            performingMath = false
            
            //Decemal "." clicked
            
            if sender.tag == 0  {
                
                //Update label
                
                label.text = "0."
                
                //Update screen number
                
                screenNumber = Double(label.text!)!
            } else {
                
                //Clicked other number (not ".") and this number is first one after mode switched to Entering numbers
                
                let str = String(sender.tag - 1)
                
                //Set screennumber
                
                screenNumber = Double(str)!
                
                //Set label
                
                label.text = str
            }
        } else {
            //Current mode: Entering numbers
            
            if sender.tag == 0  {
                
                //"." entered
                
                if label.text! == "" {
                    
                //If nothing entered in lable, default to "0"
                    
                    label.text="0"
                }
                
                //Append "." to string that already in label
                
                label.text=label.text!+"."
                
                //Update screennumber from label
                
                screenNumber = Double(label.text!)!
            } else
            {
                //Entered other number (not ".")
                
                //If label was not either "0" or "Error"
                if label.text != "0" && label.text != "-0" && label.text != "Error" {
                    
                    //Append number to string already in label
                    var str = String(label.text!+String(sender.tag-1))
                    
                    //                    if String(str.prefix(1)) == "-" {
                    //                        str = String(str.prefix(10))
                    //                    } else {
                    //                        str = String(str.prefix(9))
                    //                    }
                    str = normalize(input: str)
                    
                    //Update screenNumber
                    screenNumber = Double(str)
                    
                    //Update label
                    label.text=str
                } else {
                    //Label was either "0" or "Error"
                    
                    //Update label with entered number
                    
                    label.text=String(sender.tag-1)
                    
                    //Update screenNumber with entered number
                    screenNumber = Double(label.text!)!
                }
            }
        }
        
    }
    
    //Process operation entered
    @IBAction func operationsField(_ sender: UIButton) {
        
        //"C" clicked
        if sender.tag == 11
        {
            //Initialize all data
            previousNumber = nil;
            screenNumber = 0;
            label.text = "0";
            operation = nil;
            performingMath = false;
            return
        }
        
        //Previous operation was error - do not allow enter operation
        if label.text == "Error" {
            return
        }
        
        //"+/-" button clicked
        if sender.tag == 12 && performingMath == false {
            //Change label and screenNumber sign
            screenNumber = -screenNumber!
            let str = normalize(input:screenNumber!)
            label.text = str
            return
        } else if sender.tag == 12 && performingMath == true{
            return
        }
        
        //Label has some number and operation is not "="
        if label.text != "" && sender.tag != 18
        {
            //Performing math true
            if performingMath {
                
                //Update operation
                operation = sender.tag
                
                //Update label
                label.text = operationToLabel(tag: sender.tag)
                return
            }
            
            //No numbers have been set - just return
            if previousNumber == nil && screenNumber == nil {
                return
            }
            
            //Previous number unset; screenNumber set
            if previousNumber == nil && screenNumber != nil {
                
                //Shift screenNumber to previous number
                previousNumber = screenNumber
                screenNumber = nil
                
                //Update operation
                operation = sender.tag
                
                //Set performMath flag
                performingMath = true
                
                //Update label with operation
                label.text = operationToLabel(tag: sender.tag)
                return
            }
           
            //PreviousNumber set; screenNumber unset
            if previousNumber != nil && screenNumber == nil {
                
                //Update operation
                operation = sender.tag
                
                //Set performMath flag
                performingMath = true
                
                //Update label with operation
                label.text = operationToLabel(tag: sender.tag)
                return
            }
            
            //Both previous and screenNumber set
            if previousNumber != nil && screenNumber != nil {
                
                if (screenNumber! == 0 && operation! == 14) {
                    
                    //Division by 0
                    
                    //Set error
                    previousNumber = nil
                    screenNumber = nil
                    operation = nil
                    label.text = "Error"
                    performingMath = false
                    return
                } else
                    
                    //Any other operation
                {
                    //Perform operation
                    let res = oper(num1:previousNumber, num2:screenNumber, operation:operation!)
                    
                    //Normalize result
                    let str = normalize(input: res)
                    
                    //Normalize double
                    let dbl = Double(str)
                    
                    //Update label
                    label.text = str
                    
                    //Update previousNumber
                    previousNumber = dbl
                    
                    //Update screenNumber
                    screenNumber = nil
                    
                    //Update operation
                    operation = sender.tag
                    
                    //Set performanceMath flag
                    performingMath = true
                    
                    return
                }
            }
        }
             //Operation "="
        else if sender.tag == 18
        {
            //Unset performanceMath flag
            performingMath = false
            
            //Return if previousNumber unset
            if previousNumber == nil {
                return
            }
            
            //PreviousNumber is set and operation is square root (√)
            if previousNumber != nil && operation==13 {
                
                //Error if a negative number
                if previousNumber! < 0 {
                    previousNumber = nil
                    screenNumber = nil
                    operation = nil
                    label.text = "Error"
                    performingMath = false
                    return
                }
                
                //Process operation
                let res = oper(num1:previousNumber, num2:screenNumber, operation:operation!)
                
                //Normalize string
                let str = normalize(input: res)
                
                //Update screenNumber
                screenNumber = Double(str)
                
                //Update label
                label.text = str
                
                //Unset operation
                operation = nil
                
                //Unset previous Number
                previousNumber = nil
                
                //Unset performingMath flag
                performingMath = false
                
                return
            }
            
            //PreviousNumber set; screenNumber unset
            if previousNumber != nil && screenNumber == nil {
                
                //Unset operation
                operation = nil
                
                //Normalize previousNumber
                let str = normalize(input: previousNumber!)
                let dbl = Double(str)!
                
                //Shift previosNumber to screenNumber and label
                screenNumber = dbl
                label.text = str
                
                //Unser previousNumber
                previousNumber = nil
                
                return
            }
            
            //Both previousNumber and screenNumber are set
            if previousNumber != nil && screenNumber != nil {
                
                if (screenNumber! == 0 && operation! == 14) {
                    //Division by 0
                    
                    //Set error
                    previousNumber = nil
                    screenNumber = nil
                    operation = nil
                    label.text = "Error"
                    performingMath = false
                    return
                } else {
                    
                    //Perform operation
                    let res = oper(num1:previousNumber, num2:screenNumber, operation:operation!)
                    
                    //Normalize result
                    let str = normalize(input: res)
                    
                    //Normalize double
                    let dbl = Double(str)
                    
                    //Update label
                    label.text = str
                    
                    //Unset previousNumber
                    previousNumber = nil
                    
                    //Update screenNumber
                    screenNumber = dbl
                    
                    //Unset operation
                    operation = nil
                    
                    //Unset performanceMath flag
                    performingMath = false
                    
                    return
                }
            }
        }
        
    }
    
    func operationToLabel(tag:Int) -> String {
        switch tag {
        case 13:
            //Square root
            return "√"
        case 14:
            //Division
            return "/"
        case 15:
            //Multiplication
            return "X"
        case 16:
            //Subtraction
            return "-"
        case 17:
            //Sum
            return "+"
        default:
            return ""
        }
    }
    
    
    func oper(num1: Double?, num2: Double?, operation:Int) -> Double {
        var res: Double = 0
        switch operation {
        case 13:
            //Square root
            res = num1!.squareRoot()
            break
        case 14:
            //Division
            res = num1! / num2!
            break;
        case 15:
            //Multiplication
            res = num1! * num2!
            break;
        case 16:
            //Subtraction
            res = num1! - num2!
            break;
        case 17:
            //Sum
            res = Double(num1!) + Double(num2!)
            break;
        default:
            res = num2!
        }
        return res
    }
}
