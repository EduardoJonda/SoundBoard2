//
//  ViewController.swift
//  Snapchat
//
//  Created by yonny on 22/05/18.
//  Copyright © 2018 Yonnyr Team. All rights reserved.
//

import UIKit
import Firebase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        btnInit.layer.cornerRadius = 10
        
    }

    @IBOutlet weak var btnInit: UIButton!
    
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
    
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
           print("Intentamos Iniciar Sesion")
            if error != nil {
                print("Tenemos el siguiente error\(String(describing: error))")
                self.alerta(title: "Autenticacion Fallida", message: "Ingrese sus crendenciales validas")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user,error) in
                    print("Intentamos crear un usuario")
                    if error != nil {
                        print("Tenemos el siguiente error\(String(describing: error))")
                    }else{
                        print("El usuario fue creado exitosamente")
                        Database.database().reference().child("usuarios").child(user!.uid).child("email").setValue(user!.email)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                }
            }else{
                print("Inicio de sesión exitoso")
            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            
        }
        }
        
    }
   
    func alerta (title: String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

