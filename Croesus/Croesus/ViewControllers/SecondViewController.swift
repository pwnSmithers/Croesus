//
//  SecondViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import UIKit
import ResearchKit
class SecondViewController: UIViewController {

    @IBAction func presentButton(_ sender: Any) {
        showSurvey()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    fileprivate func showSurvey(){
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.view.backgroundColor = .white
        present(taskViewController, animated: true, completion: nil)
    }
}


extension SecondViewController: ORKTaskViewControllerDelegate{
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
}
