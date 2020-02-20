
import UIKit

public class ViewImagePopUp: UIViewController{
    
    @IBOutlet weak var imageRecipe: UIImageView!
    
    var image : UIImage?
    
    public override func viewDidLoad() {
        imageRecipe.image = image
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func comeBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
