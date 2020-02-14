import UIKit

class IngredientCell : UITableViewCell {
    
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var deleteIngredientButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
