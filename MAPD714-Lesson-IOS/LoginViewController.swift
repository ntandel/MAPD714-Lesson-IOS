//
//  LoginViewController.swift
//  MAPD714-Lesson-IOS
//
//  Created by Harnam kaur on 20/11/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var uid = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        var a = email.text!
        var b = password.text!
        
         Auth.auth().signIn(withEmail: a, password: b) { [weak self] authResult, error in
                    if(error != nil){
                        var alertController = UIAlertController(title: "Error", message:
                            error?.localizedDescription as! String, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                        self?.present(alertController, animated: true, completion: nil)
                    }
                    else{
                        self!.uid = Auth.auth().currentUser!.uid
                        print(self!.uid)
                        self?.defaults.set(self?.uid, forKey: "uid")
                        
                        
                        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
                        self!.present(loginVC, animated: true, completion: nil)
                        
                    }
                }

                
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goHome"{
            let vc = segue.destination as? mainViewController
            vc!.uid = uid
        }
    }
    
            
        }

