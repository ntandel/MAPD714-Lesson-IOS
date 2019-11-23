

import UIKit
import FirebaseAuth
import Firebase
class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var uid = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        
        
       var e = emailTextField.text!
       var p = passwordTextField.text!
       
     
               Auth.auth().createUser(withEmail: e, password: p) { authResult, error in
                   if ((error) != nil){
                       var alertController = UIAlertController(title: "Error", message:
                       error?.localizedDescription as! String, preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                       self.present(alertController, animated: true, completion: nil)
                   }
                   else{
                    
                    self.uid = Auth.auth().currentUser!.uid
                    print(self.uid)
                    self.defaults.set(self.uid, forKey: "uid") 
                                           
//                       self.presentingViewController?.dismiss(animated: false, completion:nil)
                    self.performSegue(withIdentifier: "goHome", sender: nil)
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
