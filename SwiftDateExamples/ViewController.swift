//
//  ViewController.swift
//  SwiftDateExamples
//
//  Created by Kanishk Gupta on 18/08/22.
//

import SwiftDateKit
import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var dateResultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dates = SwiftDateKit.instance.getBeginAndEndYear(Date())
        
        let edate = SwiftDateKit.instance.dateFromString("2022/12/31")
        
        print(dates!.1, edate)
        
        dateResultLabel.text = "\(SwiftDateKit.instance.getBeginAndEndYear(Date()))"
    }


}

