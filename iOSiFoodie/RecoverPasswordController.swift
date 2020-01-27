
import Foundation
import UIKit


class RecoverPasswordController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func sendEmail(_ sender: Any) {
        
    }
}
