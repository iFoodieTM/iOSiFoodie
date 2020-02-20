import Alamofire
import UIKit
var Token = ""

class LoginController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var emailEmpty: UILabel!
    @IBOutlet weak var passEmpty: UILabel!
    @IBOutlet weak var emailBad: UILabel!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    @IBAction func login(_ sender: Any) {
        var errores = false
        if(emailInput.text!.isEmpty){
            print("NOOOOOOOOO")
            errores = true
            emailEmpty.isHidden = false
            emailBad.isHidden = true
        } else if !(isValidEmail(string: emailInput.text!)){
            errores = true
            emailEmpty.isHidden = true
            emailBad.isHidden = false
        } else {
            emailEmpty.isHidden = true
            emailBad.isHidden = true
            user.email = emailInput.text!
        }
        
        if(passwordInput.text!.isEmpty){
            errores = true
            passEmpty.isHidden = false
        }else{
            user.password = passwordInput.text!
            passEmpty.isHidden = true
        }
        
        if(!errores){
            postUser(user: user)
        }
        
    }
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/iFoodieAPI/public/index.php/api/login")
        let json = ["email": user.email,
                    "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if (response.response!.statusCode == 201) {
                let json = response.result.value as! [String:Any]
                Token = json["token"] as! String
                print(Token)
            self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
            }
            if (response.response!.statusCode == 401)  {
            let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                (error) in
            }
            let alert = UIAlertController(title: "Error", message:
                "Email o contraseña incorrectos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(alert1)
            self.present(alert, animated: true, completion: nil)
        }
      }
    }
}
