//
//  mainViewController.swift
//  MAPD714-Lesson-IOS
//
//  Created by Harnam kaur on 22/11/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class mainViewController: UIViewController {

        @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    var uid = ""
    var db:Firestore?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("UID IS ",self.uid)
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addData(_ sender: UIButton) {
        
        let a =  name.text!
        let b =  age.text!
        let c =  phone.text!
            
        let para = ["name":a,"age":b,"phone":c]
        
        db = Firestore.firestore()
        db?.collection("Data").document(uid).setData(para){
            err in
            if let err = err{
                print(err.localizedDescription)
            }else{
                print("successfully added")

//                var alertController = UIAlertController(title: "Firebase", message:
//                    "Data added successfully", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//
//                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func readData(_ sender: UIButton) {
        
        var db = Firestore.firestore()
               db.collection("Data").document(uid)
                   .addSnapshotListener { documentSnapshot, error in
                       guard let document = documentSnapshot else {
                           var alertController = UIAlertController(title: "Firebase", message:
                               "Error fetching data", preferredStyle: .alert)
                           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                           
                           self.present(alertController, animated: true, completion: nil)
                           return
                       }
                       guard let data = document.data() else {
                           var alertController = UIAlertController(title: "Firebase", message:
                               "Data was empty", preferredStyle: .alert)
                           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                           
                           self.present(alertController, animated: true, completion: nil)
                           return
                       }
                       self.name.text = data.values.first as! String
                       print(data.values)
               }
    }
    
    @IBAction func updateData(_ sender: UIButton) {
        
        
        let a =  name.text!
        let b =  age.text!
        let c =  phone.text!
            
        let para = ["name":a,"age":b,"phone":c]
        
               db = Firestore.firestore()
               db!.collection("Data").document(uid).updateData(para)
             
               
               var alertController = UIAlertController(title: "Firebase", message:
                   "Data updated successfully", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
               
               self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteData(_ sender: UIButton) {
        
        
               var db = Firestore.firestore()
               db.collection("Data").document(uid).delete()
               var alertController = UIAlertController(title: "Firebase", message:
                   "Data deleted successfully", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
               
               self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        do{
                   try Auth.auth().signOut()
                   let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
                   self.present(loginVC, animated: true, completion: nil)

               }
               catch{
               
               }
    }
}
