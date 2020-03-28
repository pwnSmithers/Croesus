//
//  SurveyViewController.swift
//  Croesus
//
//  Created by Smithers on 26/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import ResearchKit

class SurveyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func presentSurvey(){
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
}

extension SurveyViewController: ORKTaskViewControllerDelegate{
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
}
