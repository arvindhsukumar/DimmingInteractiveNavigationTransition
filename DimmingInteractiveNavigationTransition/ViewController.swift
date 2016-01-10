//
//  ViewController.swift
//  DimmingInteractiveNavigationTransition
//
//  Created by Arvindh Sukumar on 09/01/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func pushNewController(sender: AnyObject) {
        let vc = ViewController()
        vc.view.backgroundColor = UIColor.blueColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

