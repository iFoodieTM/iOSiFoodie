
//
//  ViewController.swift
//  Ifoodie_edit_profile
//
//  Created by alumnos on 24/02/2020.
//  Copyright © 2020 ap. All rights reserved.
//
import Alamofire
import AlamofireImage
import UIKit

var token:String = UserDefaults.standard.string(forKey: "token")!


class EditProfile: UIViewController {
    
    var Json_user:[String:Any]?
    var Json_check:[String:Any]?
    var edit_name:Bool = true
    var edit_user_name:Bool = false
    var edit_password:Bool = false
    var original_name:String = ""
    var original_user_name:String = ""
    var original_password:String = ""
    
    //var tintColor: UIColor!

    @IBOutlet weak var Profile_img: UIImageView!
    @IBOutlet weak var Name_text: UITextField!
    @IBOutlet weak var Name_intructions: UILabel!
    @IBOutlet weak var User_name_text: UITextField!
    @IBOutlet weak var User_name_instructions: UILabel!
    @IBOutlet weak var Password_text: UITextField!
    @IBOutlet weak var Password_instructions: UILabel!
    @IBOutlet weak var Password_repeated_text: UITextField!
    @IBOutlet weak var password_repeated_instructions: UILabel!
    @IBOutlet weak var btn_close_session: UIButton!
    @IBOutlet weak var btn_name: UIButton!
    @IBOutlet weak var btn_user_name: UIButton!
    @IBOutlet weak var btn_password: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
   
        Name_text.isUserInteractionEnabled = false
        Name_intructions.isHidden = true
        User_name_text.isUserInteractionEnabled = false
        User_name_instructions.isHidden = true
        Password_text.isUserInteractionEnabled = false
        Password_instructions.isHidden = true
        Password_repeated_text.isHidden = true
        password_repeated_instructions.isHidden = true
        btn_name.setImage(#imageLiteral(resourceName: "edit"), for: UIControl.State.normal)
        btn_user_name.setImage(#imageLiteral(resourceName: "edit"), for: UIControl.State.normal)
        btn_password.setImage(#imageLiteral(resourceName: "edit"), for: UIControl.State.normal)
        load_user()

    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
     
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    func load_user() {
        
        let url = URL(string: INIURL + "show_user")

        
        // se necesita sacar el token desde las preferencias del movil
        
        let header = ["Authentication":Token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON {(response) in

            if response.response!.statusCode == 200{
            
                self.Json_user = response.result.value as! [String:Any]
                self.Name_text.text = self.Json_user!["name"] as! String
                self.original_name = self.Json_user!["name"] as! String
                self.User_name_text.text = self.Json_user!["user_name"] as! String
                self.original_user_name =  self.Json_user!["user_name"] as! String
                var url = URL(string: self.Json_user!["photo"] as! String)
                
                self.Profile_img.af_setImage(withURL: url!)
                
            }
        }
    }
    
    
    @IBAction func Btn_name(_ sender: Any) {
        
        if Name_text.isUserInteractionEnabled == true
        {
            Name_text.isUserInteractionEnabled = false
            Name_intructions.isHidden = true
            edit_name = false
            btn_name.setImage(#imageLiteral(resourceName: "edit"), for: UIControl.State.normal)
            Name_text.text = original_name
            
        }else{
            
            Name_text.isUserInteractionEnabled = true
            Name_intructions.isHidden = false
            edit_name = true
            btn_name.setImage(#imageLiteral(resourceName: "return"), for: UIControl.State.normal)
            
            
        }
        
    }
    
    @IBAction func Btn_username(_ sender: Any) {
        
        if User_name_text.isUserInteractionEnabled == true
        {
            User_name_text.isUserInteractionEnabled = false
            User_name_instructions.isHidden = true
            edit_user_name = false
            User_name_text.text = original_user_name
            btn_user_name.setImage(#imageLiteral(resourceName: "edit"), for: UIControl.State.normal)
            
        }else{
            
            User_name_text.isUserInteractionEnabled = true
            User_name_instructions.isHidden = false
            edit_user_name = true
            btn_user_name.setImage(#imageLiteral(resourceName: "return"), for: UIControl.State.normal)
            
        }
        
    }
    
    @IBAction func Btn_Password(_ sender: Any) {
        
        if Password_text.isUserInteractionEnabled == false {
            
            Password_text.isUserInteractionEnabled = true
            Password_instructions.isHidden = false
            Password_repeated_text.isHidden = false
            password_repeated_instructions.isHidden = false
            edit_password = true
            btn_password.setImage(#imageLiteral(resourceName: "return"), for: UIControl.State.normal)
            
        }else{
            
            Password_text.isUserInteractionEnabled = false
            Password_instructions.isHidden = true
            Password_repeated_text.isHidden = true
            password_repeated_instructions.isHidden = true
            edit_password = false
            btn_password.setImage(#imageLiteral(resourceName: "edit"), for: UIControl.State.normal)
            
        }
        
    }
    
    
    @IBAction func Check_user_name(_ sender: Any) {
        
        let url = URL(string: INIURL + "check_user_name")
        
        let header = ["Authentication":Token]
        
        let json = ["user_name": self.User_name_text.text!]
        print(json)
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON {(response) in
            print(response.value)
            if response.response!.statusCode == 200{
                
                self.User_name_instructions.text = "username disponible"
                self.User_name_instructions.textColor = UIColor.green
                
            }
            if response.response!.statusCode == 400{
                
                self.User_name_instructions.text = "este es tu username actual"
                self.User_name_instructions.textColor = UIColor.yellow
            }
            if response.response!.statusCode == 401{
                self.User_name_instructions.text = "username no disponible"
                self.User_name_instructions.textColor = UIColor.red
                
            }
        }
    }
    
    
    
    @IBAction func Check_first_password(_ sender: Any) {
        
        if Password_text.text != Password_repeated_text.text{
            
            password_repeated_instructions.text = "las contraseñas no coinciden"
            password_repeated_instructions.textColor = UIColor.red
            
        }else{
            
            password_repeated_instructions.text = "las contraseñas coinciden"
            password_repeated_instructions.textColor = UIColor.green
            
        }
        
    }
    

    @IBAction func check_confirmation_password(_ sender: Any) {
        
        if Password_text.text != Password_repeated_text.text{
            
            password_repeated_instructions.text = "las contraseñas no coinciden"
            password_repeated_instructions.textColor = UIColor.red
            
        }else{
            
            password_repeated_instructions.text = "las contraseñas coinciden"
            password_repeated_instructions.textColor = UIColor.green
            
        }

    }
    
    
    @IBAction func Btn_edit(_ sender: Any) {
        
        var json:[String:Any]?
        
        if ((edit_password) && (password_repeated_instructions.text == "las contraseñas coinciden")) {
            
             json = ["user_name": self.User_name_text.text!,"name":Name_text.text!,"password":Password_text.text!]
            print(json)
        }else{
             json = ["user_name": self.User_name_text.text!,"name":Name_text.text!]
        }
        
     
            let url = URL(string: INIURL + "update_user")
            
            let header = ["Authentication":Token]
        
            
            Alamofire.request(url!, method: .put, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON {(response) in
                
                print(response.response!.statusCode)
                
                if response.response!.statusCode == 200{
                    
                    // sacar pop up de editado
                    print("usuario editado")
                    
                }
            }
performSegue(withIdentifier: "backEdit", sender: nil)

}
    
    @IBAction func Close_session(_ sender: Any) {
        
      // borrar token, email y password de las preferencias


        UserDefaults.standard.setValue("", forKey: "token")
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "password")
        
        // perfom segue with identifier "go_login"
    }
    
    
}
