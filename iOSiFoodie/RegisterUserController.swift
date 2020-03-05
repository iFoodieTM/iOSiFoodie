
import Alamofire
import UIKit

var user = User()

class RegisterUserController: UIViewController {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var password2Input: UITextField!
    
    @IBOutlet weak var badUser: UILabel!
    @IBOutlet weak var badEmail: UILabel!
    @IBOutlet weak var emptyEmail: UILabel!
    @IBOutlet weak var emptyPass: UILabel!
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
    
        if let url = URL(string: "/Users/victor/Desktop/iOSiFoodie/iOSiFoodie/Assets.xcassets/descarga.imageset/descarga.jpeg"), let html = try? String(contentsOf: url, encoding: .utf8)
        {
            print(html)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    @IBAction func register(_ sender: Any) {

        print(isValidEmail(string: emailInput.text!))

        var errores = false

        if(userNameInput.text!.isEmpty){
            errores = true
            badUser.isHidden = false
        }else{
            badUser.isHidden = true
            user.userName = userNameInput.text!
        }

        if(emailInput.text!.isEmpty){
            print("NOOOOOOOOO")
            errores = true
            emptyEmail.isHidden = false
            badEmail.isHidden = true
        } else if !(isValidEmail(string: emailInput.text!)){
            errores = true
            emptyEmail.isHidden = true
            badEmail.isHidden = false
        } else {
            print("estefaniaaaaaaa")
            emptyEmail.isHidden = true
            badEmail.isHidden = true
            user.email = emailInput.text!
        }

        if passwordInput.text!.isEmpty || password2Input.text!.isEmpty{
            errores = true
            emptyPass.isHidden = false
        }else if passwordInput.text! == password2Input.text!{
            user.password = passwordInput.text!
            emptyPass.isHidden = true
        } else {
            let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                (error) in
            }
            let alert = UIAlertController(title: "Aviso", message:
                "Las contraseñas no coinciden", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(alert1)
            self.present(alert, animated: true, completion: nil)
            emptyPass.isHidden = true
        }
        
        if(!errores){
            
            user.userName = userNameInput.text!
            user.email = emailInput.text!
            user.password = passwordInput.text!
            //user.imageProfile = photoInput.image.
            postUser(user: user)
            
            // crear usuario en la api
            print("UserName: ", user.userName
                + "Email: ", user.email
                + "Password: ", user.password
                + "Password2: ", user.password2)
        }else{
            
            let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                (error) in
            }
            let alert = UIAlertController(title: "Aviso", message:
                "Hay uno o varios campos vacíos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(alert1)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func postUser(user: User) {
        print("Username: ", user.userName)
        print("Email: ", user.email)
        print("Password: ", user.password)
        
        let url = URL(string: INIURL+"store")
        
        let json = ["user_name": user.userName,
                    "email": user.email,
                    "password": user.password] as [String : Any]

        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                
                let json = response.result.value as! [String:Any]
                Token = json["token"] as! String
                UserDefaults.standard.set(Token, forKey: "token")
                self.performSegue(withIdentifier: "RegisterSuccess", sender: nil)
                print(Token)
            }else{
                
                let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                    (error) in
                }
                
                let alert = UIAlertController(title: "Aviso", message:
                    "Informacion incorrecta", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
