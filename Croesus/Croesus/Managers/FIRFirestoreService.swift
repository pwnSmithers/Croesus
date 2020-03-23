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
    
    func create<T: Codable>(for encondableObject: T, in collectionReference: FIRCollectionReference, completion: @escaping (Bool) -> Void){
        do{
            let json = try encondableObject.toJson(excluding: ["id"])
            reference(to: .users).addDocument(data: json)
            
            completion(true)
            print("Completed Task")
        }catch{
            print(error)
        }
    }
    
    func read<T: Codable>(from collectionReference: FIRCollectionReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void){
        reference(to: .users).addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            do{
                var objects = [T]()
                for document in snapshot.documents{
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            }catch{
                print(error)
            }
        }
    }
    
    func update<T: Codable & Identifiable>(for encodableObject: T, in collectionReference: FIRCollectionReference){
        do{
            let json = try encodableObject.toJson(excluding: ["id"])
            guard let id = encodableObject.id else { throw MyError.encodingError}
            reference(to: .users).document(id).setData(json)
        }catch{
            print(error)
        }
    }
}
