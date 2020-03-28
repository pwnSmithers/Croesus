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
    private var surveyOne : [Questions]?

    private var currentUser : UserData?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserProfile()
        setupView()
        getSurveyQuestions()
    }


    fileprivate func getUserProfile(){
        guard let uid = Constants.keychain["uid"] else {
            return
         }
        
            FIRFirestoreService.shared.getUserProfile(uid: uid) { (currentUser) in
                print(currentUser)
                self.currentUser = currentUser
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
           instructionStep.title = "Expenditure Survey"
           instructionStep.text = "We here at Croesus pride our selves at not only keeping you and your loved ones money safe but also make sure we advise on expenditure."
           steps += [instructionStep]
            
      
            let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 100)
            nameAnswerFormat.multipleLines = false
            var questionSteps = [ORKStep]()
            self.surveyOne?.forEach({

                let nameQuestionStep = ORKQuestionStep(identifier: $0.Question, title: $0.Question, answer: nameAnswerFormat)
                questionSteps.append(nameQuestionStep)
            })
         
            steps += questionSteps
        
           
            let review = ORKReviewStep(identifier: "reviewSteps")
            review.text = "These are your answers so far, not too sure about them all of sudden? click on any to edit them . We care about your finances and want to make sure you give us the right data :)"
            review.title = "Survey Review"
            steps += [review]
            
            let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
            summaryStep.title = "Right. Off you go!"
            summaryStep.text = "Please tap done to submit this data to our data banks for evaluation. Thank you for your honesty"
            steps += [summaryStep]
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }
    
    fileprivate func sendSurveyData(surveyResult : [ORKResult]){
        guard let userData = currentUser else{
            return
        }
        for result in surveyResult{
            if let questionResult = result as? ORKStepResult {
                if let questionTextResult = questionResult.results{
                    for results in questionTextResult{
                        if let answer = results as? ORKTextQuestionResult{
                            let surveyResponse = Survey(question: answer.identifier, answer: answer.textAnswer!, fullNames: "\(userData.firstName!) \(userData.lastName!)" ,email: userData.userEmail!)
                            FIRFirestoreService.shared.addSurveyResponse(for: surveyResponse, in: .responses) { (completed) in
                                if completed{
                                    print("Done")
                                }
                            }
                        }
                       
                    }
                }
            }
        }
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = surveryTableView.dequeueReusableCell(withIdentifier: "survey", for: indexPath) as! SurveryCell
        
        if let survey = surveyOne{
            
            if survey.isEmpty{
                cell.surveryName.text = "There are no surveys for you"
                cell.dateCreated.text = "-"
            }else{
                cell.surveryName.text = "Expenditure Survey"
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
        //print(taskViewController.result)
        if let results = taskViewController.result.results{
            sendSurveyData(surveyResult: results)
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
}
