//
//  ViewController.swift
//  HelloWorld
//
//  Created by wangxuehua on 15/6/8.
//  Copyright (c) 2015年 wangxuehua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let multiple = "×"
    let division = "÷"
    let plus = "+"
    let subtract = "−"
    let sqrt = "√"
    let equalSymbol = "="

    @IBOutlet weak var digitalLabel: UILabel!
    
    var isFirstInput: Bool = true
    
    // store then digit every times clicked
    var operandStack = Array<Double>()
    
    // last operation stack
    var lastOperationStack = Array<String>()
    
    // display the result of calculation on then screen
    var displayValue: Double {
        get {
//            return NSNumberFormatter().numberFromString(digitalLabel.text!)!.doubleValue
            return NSString(string: digitalLabel.text!).doubleValue
        }
        set {
            digitalLabel.text! = "\(newValue)"
        }
    }

    @IBAction func digitalButtonClicked(sender: UIButton) {
        //var digitalValue: String = sender.currentTitle!
        let digitalValue = sender.currentTitle!
        println("current title = \(digitalValue)")
        
        if (isFirstInput) {
            digitalLabel.text! = digitalValue
            isFirstInput = false
        }
        else {
            digitalLabel.text! += digitalValue
        }
    }
    
    @IBAction func operationClicked(sender: UIButton) {
        // store the digit
//        displayValue = NSString(string: digitalLabel.text!).doubleValue
        // record the last operation
        lastOperationStack.append(sender.currentTitle!)
        isFirstInput = true
        
        // push the input digit into the stack
        operandStack.append(displayValue)
    }
    
    @IBAction func result(sender: UIButton) {
        // store the digit
//        displayValue = NSString(string: digitalLabel.text!).doubleValue
        
        // push the input digit into the stack
        operandStack.append(displayValue)
        // record the last operation
//        lastOperationStack.append(sender.currentTitle!)
        isFirstInput = true
        calculateTwoDigitFormul()
        
    }
    
    func performOperation(operation: (Double, Double) -> Double) -> Double {
        // get the result of formul between tow digit
        if operandStack.count >= 2 {
            var lastDigit = operandStack.removeLast()
            var penultDigit = operandStack.removeLast()
            var result = operation(penultDigit, lastDigit)
            displayValue = result
            return result
        }
        else if operandStack.count == 1 {
            var result = operandStack.removeLast()
            displayValue = result
            return result
        }
        displayValue = 0
        return 0
    }
    
    func calculateTwoDigitFormul() -> Double {
        // get the result of formul between tow digit
        if lastOperationStack.count <= 0 {
            return 0
        }
        
        switch lastOperationStack.removeLast() {
        case "+": performOperation() {return $0 + $1}
        case "−": performOperation() {return $0 - $1}
        case "×": performOperation() {return $0 * $1}
        case "÷": performOperation() {return $0 / $1}
        default:
            break
        }
        return 0
    }
    
    func calculateFinalFormul() ->Double {
        // get the result of formul
        return 0
    }
    
}

