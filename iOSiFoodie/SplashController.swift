import UIKit
import Alamofire

var email: String! = ""
var password: String! = ""
let INIURL:String = "http://54.226.238.184/api/"
class SplashController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondo_IF_2 (1)"))
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "email") == nil && UserDefaults.standard.string(forKey: "password") == nil{
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "password")
        }
        
        if UserDefaults.standard.string(forKey: "email") != "" && UserDefaults.standard.string(forKey: "password") != ""{
//            print(UserDefaults.standard.string(forKey: "email")!)
            
            email = UserDefaults.standard.string(forKey: "email")!
            password = UserDefaults.standard.string(forKey: "password")!
            print("---------------")
            postUserNew(user: user)
            
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.performSegue(withIdentifier: "GoToLogin", sender: nil)
            }
        }
    }
    
    
    
    func postUserNew(user: User) {
        let url = URL(string: INIURL+"login")
        let json = ["email": email!,
                    "password": password!]
        print(json)
        print("ruben")
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            if (response.response!.statusCode == 201) {
                print("WWWWWW")
                let json = response.result.value as! String
                Token = json 
                UserDefaults.standard.set(Token, forKey: "token")
                print(UserDefaults.standard.set(Token, forKey: "token"))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.performSegue(withIdentifier: "userSaved", sender: nil)
                }
            }
            if (response.response!.statusCode == 401)  {
                print("EEEEE")
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
