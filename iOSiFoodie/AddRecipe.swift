import UIKit

class AddRecipe : UIViewController {
    
    @IBOutlet weak var titleRecipe: UITextField!
    @IBOutlet weak var ingText: UITextField!
    @IBOutlet weak var masIng: UIButton!
    @IBOutlet weak var menosIng: UIButton!
    
    var label = UILabel()
    
    var lastY: CGFloat = 100
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func addIngrediente(_ sender: Any) {
//        let contentView = UIView()
//        addViewsTo(contentView)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(contentView)
//
//        // Add size constraints to the content view (260, 30)
//        NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal,
//                           toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 260.0).isActive = true
//        NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal,
//                           toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 10.0).isActive = true
//        // Add position constraints to the content view (horizontal center, 100 from the top)
//        NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: lastY).isActive = true
//        NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
//
//        // Update last Y position to have the gaps between views to be 10
//        lastY += 20
//    }
    
//    func addViewsTo(_ contentView: UIView) {
//        // Add a label with size of (100, 30)
//        label = UILabel()
//        label.text = ingText.text
//        label.frame = CGRect(x: 10.0, y: 130.0, width: 100.0, height: 30.0)
//        contentView.addSubview(label)
//    }
}
