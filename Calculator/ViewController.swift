//
//  ViewController.swift
//  Calculator
//
//  Created by florian BUREL on 21/09/2015.
//  Copyright (c) 2015 florian BUREL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// Outlet vers le label d'affichage
    @IBOutlet weak var display: UILabel!
    
    /// Flag indiquant si l'utilisateur est en train de taper un nombre ou pas
    private var userIsTyping = false
    
    /// Listes des operandes (nombres) en mémoire
    private var operands = [Double]()

    /// Execute une Operation avec les 2 derniers nombres en mémoires
    private func performOperation(operation:(Double, Double) -> Double)
    {
        let a = operands.removeLast()
        let b = operands.removeLast()
        
        let result = operation(a, b);
        
        operands.append(result);
        
        display.text = "\(result)"
        
    }

    /*
        UI Actions
    */
    
    @IBAction func enterPressed() {
        userIsTyping = false
        
        // Transforme le display.Text en Double
        
        var number = NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        
        // Ajoute le nombre a la liste des opérandes
        operands.append(number)
        
        
    }
    
    @IBAction func dotPressed()
    {
        
        
        let text = display.text!
        let stringToSearch = "."
        
        // Recherche '.' dans text
        let hasNoDot = text.rangeOfString(stringToSearch) == nil;
        
        if hasNoDot
        {
           display.text = display.text! + "."
        }
    }
    
    @IBAction func operatorPressed(sender: UIButton) {
        
        // On donne un [Enter] gratuit
        if userIsTyping
        {
            enterPressed()
        }
        
        // Verifie que l'on a AU MOINS 2 operand
        if operands.count >= 2
        {
            switch sender.currentTitle!
            {
            case "*":
                performOperation(*)
                
            case "/":
                performOperation({(a, b) in
                    
                    return a / b
                })
                
            case "-":
                performOperation({(a, b) in
                    
                    a - b
                })
                
            case "+":
                performOperation(){ $0 + $1 }
                
            default:
                println("error")
            }
            
        }
        else
        {
            display.text = "0";
        }
        
    }
    
    @IBAction func digitPressed(sender: UIButton) {
        
        
        if let title = sender.currentTitle
        {
            if userIsTyping
            {
                display.text = display.text! + title
            }
            else
            {
                display.text = title
            }
            
            userIsTyping = true
        }
    }
    
    
    
}

