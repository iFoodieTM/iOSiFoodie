
import Alamofire
import UIKit

var user = User()



class RegisterController: UIViewController {
    
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var photoInput: UIImageView!
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
    
        if let url = URL(string: "/Users/victor/Desktop/iOSiFoodie/iOSiFoodie/Assets.xcassets/descarga.imageset/descarga.jpeg"), let html = try? String(contentsOf: url, encoding: .utf8)
        {
            print(html)
        }
    }
    
    @IBAction func register(_ sender: Any) {


        var errores = false

        if(nameInput.text!.isEmpty){
            errores = true
        }else{
            user.name = nameInput.text!
        }

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
            
            user.name = nameInput.text!
            user.email = emailInput.text!
            user.userName = userNameInput.text!
            user.password = passwordInput.text!
            user.photo =  "descarga"
            //user.imageProfile = photoInput.image.
            postUser(user: user)
            // crear usuario en la api
            print("nombre: ", user.name
                + " Email: ", user.email
                + " user_name: ", user.userName
                + " Password: ", user.password
                + " photo: ",  user.photo)
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
        let url = URL(string: "http://localhost:8888/APIiFoodie/public/index.php/api/register")
        let json = ["name": user.name,
                    "user_name": user.userName,
                    "email": user.email,
                    "password": user.password,
                    "photo": user.photo
            ] as [String : Any]

        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.response!.statusCode)
        }
    }
}
