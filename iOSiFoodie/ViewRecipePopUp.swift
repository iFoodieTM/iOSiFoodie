import UIKit

public class ViewRecipePopUp: UIViewController {
    
    @IBOutlet weak var nameRecipe: UILabel!
    @IBOutlet weak var ingredientsRecipe: UILabel!
    @IBOutlet weak var stepsRecipe: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    
    var titleRecipe : String = ""
    var ingredients = [String]()
    var steps = [String]()
    var image : UIImage?
    
    
    @IBAction func comeBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    public override func viewDidLoad() {
        nameRecipe.text = titleRecipe
        ingredientsRecipe.text = ingredients.joined(separator: ", ")
        stepsRecipe.text = steps.joined(separator: ", ")
        imageRecipe.image = image
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        //
    }
    
    
}
