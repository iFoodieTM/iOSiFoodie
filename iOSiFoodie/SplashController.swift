import UIKit
import Alamofire

var email: String! = nil
var password: String! = nil

class SplashController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "email") != nil && UserDefaults.standard.string(forKey: "password") != nil{
            print(UserDefaults.standard.string(forKey: "email")!)
            
            print(UserDefaults.standard.string(forKey: "password")!)
            email = UserDefaults.standard.string(forKey: "email")!
            password = UserDefaults.standard.string(forKey: "password")!
            postUserNew(user: user)
            
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.performSegue(withIdentifier: "GoToLogin", sender: nil)
            }
        }
    }
    
    
    
    func postUserNew(user: User) {
        let url = URL(string: "http://localhost:8888/APIiFoodie/public/index.php/api/login")
        let json = ["email": email!,
                    "password": password!]
        print(json)
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if (response.response!.statusCode == 201) {
                let json = response.result.value as! [String:Any]
                Token = json["token"] as! String
                UserDefaults.standard.set(Token, forKey: "token")
                print(UserDefaults.standard.set(Token, forKey: "token"))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.performSegue(withIdentifier: "userSaved", sender: nil)
                }
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
