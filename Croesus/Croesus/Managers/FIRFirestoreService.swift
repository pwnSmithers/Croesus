//
//  FIRFirestoreService.swift
//  Croesus
//
//  Created by Smithers on 22/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FIRFirestoreService{
    private init() {}
    
    static let shared = FIRFirestoreService()
    
    
    func configure(){
        FirebaseApp.configure()
    }
    
    fileprivate func reference(to collectionReference:FIRCollectionReference) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func registerUser(){
        
    }
    
    func create<T: Codable>(for encondableObject: T, in collectionReference: FIRCollectionReference){
        do{
            let json = try encondableObject.toJson(excluding: ["id"])
            reference(to: .users).addDocument(data: json)
        }catch{
            print(error)
        }
    }
    
    func read<T: Codable>(from collectionReference: FIRCollectionReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void){
        
        
    }
}
