import UIKit

public class ViewRecipePopUp: UIViewController {
    
    @IBOutlet weak var nameRecipe: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var timeRecipe: UILabel!
    @IBOutlet weak var descriptionRecipe: UILabel!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var scrollViewLength: NSLayoutConstraint!
    @IBOutlet weak var difficultyImage: UIImageView!
    
    var titleRecipe : String = ""
    var categories = [String]()
    var ingredients = [String]()
    var steps = [String]()
    var image = Data?.self
    
    var num = 1
    var positionY = 0
    var positionX = 0
    
    var videoCode : String = ""
    
    @IBAction func comeBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    public override func viewDidLoad() {
        
        nameRecipe.text = recipe?.title
        descriptionRecipe.text = recipe?.description
        timeRecipe.text = String(recipe!.time)
        categories = recipe!.categories
        ingredients = recipe!.ingredients
        videoCode = recipe!.video
        print ("EL CÓDIGO DE VÍDEO QUE HA LLEGADO ES:", videoCode)
        
        var image = UIImage(named: "recipe-default")
        if recipe?.image != nil{
            image = UIImage(data: (recipe!.image!))
        }
        imageRecipe.image = image
        
        switch recipe!.difficulty{
        case 1:
            difficultyImage.image = UIImage(named: "skull0")
            break
        case 2:
            difficultyImage.image = UIImage(named: "skull1")
            break
        case 3:
            difficultyImage.image = UIImage(named: "skull3")
            break
        case 4:
            difficultyImage.image = UIImage(named: "skull4")
            break
        case 5:
            difficultyImage.image = UIImage(named: "skull5")
            break
        default:
            difficultyImage.image = UIImage(named: "skull6")
        }
        
        setCategories()
        setSteps()
        setVideo()
    }
    
    public func setCategories(){
        for category in categories{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
            label.center = CGPoint(x: 198 + self.positionX, y: 400)
            label.textAlignment = .left
            label.text = category
            self.scrollView.addSubview(label)
            self.positionX += 100
        }
    }
    
    public func setSteps(){
        for paso in steps{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
            label.numberOfLines = 6
            label.textAlignment = .left
            label.text = "\(self.num). " + paso
            self.scrollView.addSubview(label)
            let stepLength = label.text?.count as! Int
            switch stepLength{
            case 0...51:
                self.positionY += 30
                break
            case 150...200:
                self.positionY += 115
                break
            default:
                self.positionY += 80
            }
            label.center = CGPoint(x: 196, y: 550 + self.positionY)
            self.positionY += 40
            self.num += 1
        }
    }
    
    public func setVideo(){
        switch steps.count{
        case 0...3:
            if recipe?.video != ""{
                let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
                video.center = CGPoint (x : 210, y: 900)
                self.scrollView.addSubview(video)
                let urlVideo = (URL(string: "https://youtu.be/\(videoCode)") ?? nil)!
                video.loadRequest(URLRequest(url: urlVideo))
            }
            break
            case 4...6:
                if recipe?.video != ""{
                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
                    video.center = CGPoint (x : 210, y: 950)
                    self.scrollView.addSubview(video)
                    let urlVideo = (URL(string: "https://youtu.be/\(videoCode)") ?? nil)!
                    video.loadRequest(URLRequest(url: urlVideo))
                }
                break
            case 7...10:
                if recipe?.video != ""{
                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
                    if self.positionY > 150{
                        scrollViewLength.constant = scrollViewLength.constant + 800
                        video.center = CGPoint(x: 210, y: 1200)
                    }else{
                        scrollViewLength.constant = scrollViewLength.constant + 600
                        video.center = CGPoint(x: 210, y: 950)
                    }
                
                    scrollView.addSubview(video)
                    let urlVideo = URL(string: "https://youtu.be/\(videoCode)")
                    video.loadRequest(URLRequest(url: urlVideo!))
                }
                break
            case 11...15:
                if recipe?.video != ""{
                    scrollViewLength.constant = scrollViewLength.constant + 600
                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
                    video.center = CGPoint (x : 210, y: 900)
                    self.scrollView.addSubview(video)
                    let urlVideo = URL(string: "https://youtu.be/\(videoCode)")
                    video.loadRequest(URLRequest(url: urlVideo!))
                }
                break
            case 14...18:
                if recipe?.video != ""{
                    scrollViewLength.constant = scrollViewLength.constant + 650
                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
                    video.center = CGPoint (x : 210, y: 1000)
                    self.scrollView.addSubview(video)
                    let urlVideo = URL(string: "https://youtu.be/\(videoCode)")
                    video.loadRequest(URLRequest(url: urlVideo!))
                }
                break
            default:
                break
        }
    }
}


//import UIKit
//
//public class ViewRecipePopUp: UIViewController {
//
//    @IBOutlet weak var nameRecipe: UILabel!
//    @IBOutlet weak var imageRecipe: UIImageView!
//    @IBOutlet weak var timeRecipe: UILabel!
//    @IBOutlet weak var descriptionRecipe: UILabel!
//    @IBOutlet weak var scrollView: UIView!
//    @IBOutlet weak var scrollViewLength: NSLayoutConstraint!
//    @IBOutlet weak var difficultyImage: UIImageView!
//
//    var titleRecipe : String = ""
//    var categories = [String]()
//    var ingredients = [String]()
//    var steps = [String]()
//    var image = Data?.self
//
//    var num = 1
//    var positionY = 0
//    var positionX = 0
//
//    var videoCode : String = ""
//
//    @IBAction func comeBack(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    public override func viewDidLoad() {
//        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
//
//        nameRecipe.text = recipe?.title
//        descriptionRecipe.text = recipe?.description
//        timeRecipe.text = String(recipe!.time)
//        categories = recipe!.categories
//        ingredients = recipe!.ingredients
//        videoCode = recipe!.video
//        print ("EL CÓDIGO DE VÍDEO QUE HA LLEGADO ES:", videoCode)
//
//        var image = UIImage(named: "recipe-default")
//        if recipe?.image != nil{
//            image = UIImage(data: (recipe!.image)!)
//        }
//        imageRecipe.image = image
//
//        switch recipe!.difficulty{
//        case 1:
//            difficultyImage.image = UIImage(named: "skull0")
//            break
//        case 2:
//            difficultyImage.image = UIImage(named: "skull1")
//            break
//        case 3:
//            difficultyImage.image = UIImage(named: "skull3")
//            break
//        case 4:
//            difficultyImage.image = UIImage(named: "skull4")
//            break
//        case 5:
//            difficultyImage.image = UIImage(named: "skull5")
//            break
//        default:
//            difficultyImage.image = UIImage(named: "skull6")
//        }
//
//        setCategories()
//        setSteps()
//        setVideo()
//    }
//
//    public func setCategories(){
//        for category in categories{
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
//            label.center = CGPoint(x: 198 + self.positionX, y: 400)
//            label.textAlignment = .left
//            label.text = category
//            self.scrollView.addSubview(label)
//            self.positionX += 100
//        }
//    }
//
//    public func setSteps(){
//        for paso in steps{
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
//            label.numberOfLines = 6
//            label.textAlignment = .left
//            label.text = "\(self.num). " + paso
//            self.scrollView.addSubview(label)
//            let stepLength = label.text?.count as! Int
//            switch stepLength{
//            case 0...51:
//                self.positionY += 30
//                break
//            case 150...200:
//                self.positionY += 115
//                break
//            default:
//                self.positionY += 80
//            }
//            label.center = CGPoint(x: 196, y: 550 + self.positionY)
//            self.positionY += 40
//            self.num += 1
//        }
//    }
//
//    public func setVideo(){
//        switch steps.count{
//        case 0...3:
//            if recipe?.video != ""{
//                let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
//                video.center = CGPoint (x : 210, y: 900)
//                self.scrollView.addSubview(video)
//                let urlVideo = (URL(string: "https://youtu.be/\(videoCode)") ?? nil)!
//                video.loadRequest(URLRequest(url: urlVideo))
//            }
//            break
//            case 4...6:
//                if recipe?.video != ""{
//                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
//                    video.center = CGPoint (x : 210, y: 950)
//                    self.scrollView.addSubview(video)
//                    let urlVideo = (URL(string: "https://youtu.be/\(videoCode)") ?? nil)!
//                    video.loadRequest(URLRequest(url: urlVideo))
//                }
//                break
//            case 7...10:
//                if recipe?.video != ""{
//                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
//                    if self.positionY > 150{
//                        scrollViewLength.constant = scrollViewLength.constant + 800
//                        video.center = CGPoint(x: 210, y: 1200)
//                    }else{
//                        scrollViewLength.constant = scrollViewLength.constant + 600
//                        video.center = CGPoint(x: 210, y: 950)
//                    }
//
//                    scrollView.addSubview(video)
//                    let urlVideo = URL(string: "https://youtu.be/\(videoCode)")
//                    video.loadRequest(URLRequest(url: urlVideo!))
//                }
//                break
//            case 11...15:
//                if recipe?.video != ""{
//                    scrollViewLength.constant = scrollViewLength.constant + 600
//                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
//                    video.center = CGPoint (x : 210, y: 900)
//                    self.scrollView.addSubview(video)
//                    let urlVideo = URL(string: "https://youtu.be/\(videoCode)")
//                    video.loadRequest(URLRequest(url: urlVideo!))
//                }
//                break
//            case 14...18:
//                if recipe?.video != ""{
//                    scrollViewLength.constant = scrollViewLength.constant + 650
//                    let video = UIWebView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
//                    video.center = CGPoint (x : 210, y: 1000)
//                    self.scrollView.addSubview(video)
//                    let urlVideo = URL(string: "https://youtu.be/\(videoCode)")
//                    video.loadRequest(URLRequest(url: urlVideo!))
//                }
//                break
//            default:
//                break
//        }
//    }
//}
