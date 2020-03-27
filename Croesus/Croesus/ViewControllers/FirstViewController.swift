//
//  FirstViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import UIKit
import Firebase
import ResearchKit

class FirstViewController: UIViewController {

    @IBOutlet weak var surveryTableView: UITableView!
    //private var thoughtsCollectionRef : CollectionReference!
    //private var Questions : Questions?
    private var surveyOne : [Questions]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserProfile()
        setupView()
        getSurveyQuestions()
    }


    fileprivate func getUserProfile(){
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "uid"){
         FIRFirestoreService.shared.getUserProfile(uid: uid)
        }
        
    }
    
    fileprivate func setupView(){
        surveryTableView.delegate = self
        surveryTableView.dataSource = self
    }
    
    fileprivate func getSurveyQuestions(){
            FIRFirestoreService.shared.read(from: .questions, returning: Questions.self) { (survey) in
                self.surveyOne = survey
                self.surveryTableView.reloadData()
        }
        
        
    }
    
    
    
    fileprivate func setupSurveyScreen() -> ORKOrderedTask{
        var steps = [ORKStep]()
        
            //Instructions screen
           let instructionStep = ORKInstructionStep(identifier: "IntroStep")
           instructionStep.title = "The Questions Three"
           instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the other side they see."
           steps += [instructionStep]
            
      
            let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
            nameAnswerFormat.multipleLines = false
            var questionSteps = [ORKStep]()
            self.surveyOne?.forEach({
                let nameQuestionStep = ORKQuestionStep(identifier: $0.Question, title: $0.Question, answer: nameAnswerFormat)
                questionSteps.append(nameQuestionStep)
            })
         
            steps += questionSteps
        
            let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
            summaryStep.title = "Right. Off you go!"
            summaryStep.text = "That was easy!"
            steps += [summaryStep]
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        if let survey = surveyOne{
            if survey.isEmpty{
                cellCount = 1
            }else{
                cellCount = survey.count
            }
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = surveryTableView.dequeueReusableCell(withIdentifier: "survey", for: indexPath) as! SurveryCell
        
        if let survey = surveyOne{
            
            if survey.isEmpty{
                cell.surveryName.text = "There are no surveys for you"
                cell.dateCreated.text = "-"
            }else{
                cell.surveryName.text = survey[indexPath.row].Question
                cell.dateCreated.text = survey[indexPath.row].date
            }
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = ORKTaskViewController(task: setupSurveyScreen(), taskRun: nil)
          taskViewController.delegate = self
          taskViewController.view.backgroundColor = .white
          present(taskViewController, animated: true, completion: nil)

    }
    
}

extension FirstViewController: ORKTaskViewControllerDelegate{
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
}
