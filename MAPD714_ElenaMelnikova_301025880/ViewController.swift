//
//  ViewController.swift
//  MAPD714_ElenaMelnikova_301025880
//
//  Created by Elena Melnikova on 2018-09-25.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var screenNumber:Double? = nil
    
    var previousNumber:Double? = nil
    
    var operation:Int? = nil
    
    var performingMath = false
    
    @IBOutlet weak var label:UILabelPadding! //UILabel! with paddings that set in UILabelPaddind.swift
    
    func normalize(input:String) -> String {
        
        let isMinus = String(input.prefix(1))
        var str: String
        
        if isMinus == "-" {
            
            str = String(input.prefix(10))
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
        
        if performingMath == true {
            
            performingMath = false
            
            if sender.tag == 0  {
                
                label.text = "0."
                
                screenNumber = Double(label.text!)!
            } else {
                
                let str = String(sender.tag - 1)
                
                screenNumber = Double(str)!
                
                label.text = str
            }
        } else {
            
            if sender.tag == 0  {
                
                if label.text! == "" {
                    
                    label.text="0"
                }
                
                label.text=label.text!+"."
                
                screenNumber = Double(label.text!)!
            } else
            {
                if label.text != "0" && label.text != "Error" {
                    
                    var str = String(label.text!+String(sender.tag-1))
                    
//                    if String(str.prefix(1)) == "-" {
//                        str = String(str.prefix(10))
//                    } else {
//                        str = String(str.prefix(9))
//                    }
                    str = normalize(input: str)
                    
                    screenNumber = Double(str)
                    
                    label.text=str
                } else {
                    
                    label.text=String(sender.tag-1)
                    
                    screenNumber = Double(label.text!)!
                }
            }
        }
        
    }
    
    @IBAction func operationsField(_ sender: UIButton) {
  
        //"C" clicked
        if sender.tag == 11
        {
            label.text = "0"
            previousNumber = nil;
            screenNumber = 0;
            label.text = "0";
            operation = nil;
            performingMath = false;
            return
        }

        if label.text == "Error" {
            return
        }

        if sender.tag == 12 {
            screenNumber = -screenNumber!
            let str = normalize(input: screenNumber!)
            label.text = str
            return
        }
        
        if label.text != "" && sender.tag != 18
        {
            if performingMath {
                //Update operation
                operation = sender.tag

                label.text = operationToLabel(tag: sender.tag)
                return
            }

            if previousNumber == nil && screenNumber == nil {
                return
            }

            if previousNumber == nil && screenNumber != nil {
                previousNumber = screenNumber
                screenNumber = nil

                operation = sender.tag
 
                performingMath = true

                label.text = operationToLabel(tag: sender.tag)
                return
            }

            if previousNumber != nil && screenNumber == nil {
                
                operation = sender.tag
 
                performingMath = true

                label.text = operationToLabel(tag: sender.tag)
                return
            }

            if previousNumber != nil && screenNumber != nil {
                
                if (screenNumber! == 0 && operation! == 14) {

                    previousNumber = nil
                    screenNumber = nil
                    operation = nil
                    label.text = "Error"
                    performingMath = false
                    return
                } else

                {

                    let res = oper(num1:previousNumber, num2:screenNumber, operation:operation!)

                    let str = normalize(input: res)
   
                    let dbl = Double(str)

                    label.text = str

                    previousNumber = dbl

                    screenNumber = nil

                    operation = sender.tag

                    performingMath = true
                    
                    return
                }
            }
        }
        else if sender.tag == 18
        {
            performingMath = false

            if previousNumber == nil {
                return
            }

            if previousNumber != nil && operation==13 {

                if previousNumber! < 0 {
                    previousNumber = nil
                    screenNumber = nil
                    operation = nil
                    label.text = "Error"
                    performingMath = false
                    return
                }

                let res = oper(num1:previousNumber, num2:screenNumber, operation:operation!)

                let str = normalize(input: res)

                screenNumber = Double(str)

                label.text = str

                operation = nil

                previousNumber = nil

                performingMath = false
                
                return
            }

            if previousNumber != nil && screenNumber == nil {

                operation = nil

                let str = normalize(input: previousNumber!)
                let dbl = Double(str)!

                screenNumber = dbl
                label.text = str

                previousNumber = nil
                
                return
            }

            if previousNumber != nil && screenNumber != nil {
                
                if (screenNumber! == 0 && operation! == 14) {

                    previousNumber = nil
                    screenNumber = nil
                    operation = nil
                    label.text = "Error"
                    performingMath = false
                    return
                } else {

                    let res = oper(num1:previousNumber, num2:screenNumber, operation:operation!)

                    let str = normalize(input: res)

                    let dbl = Double(str)

                    label.text = str

                    previousNumber = nil
   
                    screenNumber = dbl

                    operation = nil

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
