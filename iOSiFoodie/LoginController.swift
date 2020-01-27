import Alamofire
import UIKit


class LoginController: UIViewController {
    
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login(_ sender: Any) {
        var errores = false
        if(emailInput.text!.isEmpty){
            errores = true
        }else{
            user.email = emailInput.text!
        }
        
        if(passwordInput.text!.isEmpty){
            errores = true
        }else{
            user.password = passwordInput.text!
        }
        
        if(!errores){
            postUser(user: user)
        }else{
            let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                (error) in
            }
            let alert = UIAlertController(title: "Error", message:
                "Hay uno o varios campos vacíos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(alert1)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/APIBienestapp/public/index.php/api/login")
        let json = ["email": user.email,
                    "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            if (response.response!.statusCode == 201) {
            self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
            }
            if (response.response!.statusCode == 401)  {
            let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                (error) in
            }
            let alert = UIAlertController(title: "Error", message:
                "Informacion Incorrecta", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(alert1)
            self.present(alert, animated: true, completion: nil)
        }
    }
    }
    
}
