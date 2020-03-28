//
//  SurveyTask.swift
//  Croesus
//
//  Created by Smithers on 26/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import ResearchKit


public var SurveyTask: ORKOrderedTask{
    var steps = [ORKStep]()
    

    
    var questionaire = [String]()
    var questionStep = [ORKStep]()
    FIRFirestoreService.shared.read(from: .questions, returning: Questions.self) { (survey) in
        //Instructions screen
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "The Questions Three"
        instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the other side they see."
        steps += [instructionStep]
        
        survey.forEach {
            print($0.Question)
            questionaire.append($0.Question)
        }
        let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        nameAnswerFormat.multipleLines = false
        questionaire.forEach {
             //let nameQuestionStepTitle = $0
             let nameQuestionStep = ORKQuestionStep(identifier: "Question", title: $0, answer: nameAnswerFormat)
             questionStep.append(nameQuestionStep)
         }
        print(questionStep)
         steps += questionStep
         print(steps)
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Right. Off you go!"
        summaryStep.text = "That was easy!"
        steps += [summaryStep]
    }



    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
