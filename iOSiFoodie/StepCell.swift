import UIKit

class StepCell: UITableViewCell{
    
    @IBOutlet weak var stepInformation: UILabel!
    @IBOutlet weak var stepOrder: UILabel!
    @IBOutlet weak var deleteStepButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
