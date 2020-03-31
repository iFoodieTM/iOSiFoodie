import UIKit
import AlamofireImage
import Alamofire

var recipe : Recipe?

class AddRecipe: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var requiredField: UILabel!
    @IBOutlet weak var titleRecipe: UITextField!
    @IBOutlet weak var deletePhotoButton: UIButton!
    @IBOutlet weak var deleteVideoButton: UIButton!
    @IBOutlet weak var imageRecipeView: UIImageView!
    @IBOutlet weak var addVideoURL: UITextField!
    @IBOutlet weak var viewVideoURL: UILabel!
    @IBOutlet weak var timeRecipe: UITextField!
    @IBOutlet weak var descriptionRequired: UILabel!
    @IBOutlet weak var timeRequired: UILabel!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var difficultyButton1: UIButton!
    @IBOutlet weak var difficultyButton2: UIButton!
    @IBOutlet weak var difficultyButton3: UIButton!
    @IBOutlet weak var viewFields: UIView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var descriptionRecipe: UITextView!
    
    var imagePicker : UIImagePickerController?
    
    var ingredientsArray = [String]()
    var stepsArray = [String]()
    
    var uploadedImage : UIImage!
    
    var time = 0
    
    var difficulty = 0
    
    var URL : String = ""
    
    var videoURL: String = ""
    
    var urlImage = Data.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        difficulty1()
        descriptionRecipe.delegate = self
        descriptionRecipe.layer.cornerRadius = 4
        timeRecipe.layer.cornerRadius = 4
        addVideoURL.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if recipe != nil{
            setDataRecipe()
        }
    }
    
    @IBAction func next(_ sender: Any) {
            fillRecipe()
    }
    
    @IBAction func timeRequired(_ sender: Any) {
        if timeRecipe.text!.isEmpty{
            timeRequired.isHidden = false
        }else{
            timeRequired.isHidden = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if descriptionRecipe.text!.isEmpty{
            descriptionRequired.isHidden = false
            print("Descripción vacía")
        }else{
            descriptionRequired.isHidden = true
        }
        
        if (descriptionRecipe.text!.count > 150) {
            descriptionRecipe.deleteBackward()
        }
    }
    
    @IBAction func maxNumbers(_ sender: UITextField) {
        checkMaxLength(textField: timeRecipe, maxLength: 3)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
    
    @IBAction func difficulty1(_ sender: Any) {
        difficulty1()
    }
    
    public func difficulty1(){
        difficulty = 1
        difficultyButton1.alpha = 1
        difficultyButton2.alpha = 0.5
        difficultyButton3.alpha = 0.5
    }
    
    @IBAction func difficulty2(_ sender: Any) {
        difficulty = 2
        difficultyButton1.alpha = 0.5
        difficultyButton2.alpha = 1
        difficultyButton3.alpha = 0.5
    }
    
    @IBAction func difficulty3(_ sender: Any) {
        difficulty = 3
        difficultyButton1.alpha = 0.5
        difficultyButton2.alpha = 0.5
        difficultyButton3.alpha = 1
    }
    
    @IBAction func titleChanged(_ sender: UITextField) {
        if (titleRecipe.text!.isEmpty){
            requiredField.isHidden = false
        }else{
            requiredField.isHidden = true
        }
        checkMaxLength(textField: titleRecipe, maxLength: 30)
    }
    
    @IBAction func deleteUploadedButton(_ sender: Any) {
        uploadedImage = nil
        let alert = UIAlertController(title: "Imagen eliminada", message: "Puedes volver a elegir una imagen para tu receta", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        deletePhotoButton.isHidden = true
        imageRecipeView.image = nil
        changePhotoButton.isHidden = true
        addPhotoButton.isHidden = false
        viewFields.center = CGPoint (x : 200, y: 350)
        viewImage.center = CGPoint (x : 200, y: 550)
        viewImage.isHidden = true
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Elegir imagen", message: "Los usuarios podrán verla al entrar a tu receta", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Elegir imagen", message: "Los usuarios podrán verla al entrar a tu receta", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Error", message: "Tu dispositivo no tiene cámara o tiene un fallo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker = UIImagePickerController()
            imagePicker!.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imagePicker!.allowsEditing = true
            imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker!, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Error", message: "No tienes permisos para acceder a la Galería", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        uploadedImage = info[.originalImage] as? UIImage
        print("La imagen es: " , uploadedImage!)
        deletePhotoButton.isHidden = false
        imageRecipeView.image = uploadedImage
        changePhotoButton.isHidden = false
        addPhotoButton.isHidden = true
        setImage()
    }
    
    @IBAction func addVideoURL(_ sender: Any) {
        if addVideoURL.text != ""{
            URL = addVideoURL.text!
            viewVideoURL.text = URL
            viewVideoURL.isHidden = false
            deleteVideoButton.isHidden = false
        }
        if !(addVideoURL.text?.contains("https://youtu.be/"))! || (addVideoURL.text?.contains(" "))!{
            viewVideoURL.isHidden = true
            deleteVideoButton.isHidden = true
            deleteVideoButton.isHidden = true
            let alert = UIAlertController(title: "URL de vídeo no compatible o mal escrita", message: "La URL puede que esté mal escrita o que no sea procedente de la aplicación de Youtube", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if addVideoURL.text != "" && (addVideoURL.text?.contains("https://youtu.be/"))! && !(addVideoURL.text?.contains(" "))!{
            let alert = UIAlertController(title: "URL de vídeo añadida", message: "Podrás ver cómo queda el vídeo en tu receta cuando acabes de rellenar los datos de tu nueva receta", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            videoURL = addVideoURL.text!
        }
    }
    
    @IBAction func deleteVideoURL(_ sender: Any) {
        URL = ""
        viewVideoURL.text = ""
        addVideoURL.text = ""
        viewVideoURL.isHidden = true
        deleteVideoButton.isHidden = true
    }
    
    public func setDataRecipe(){
        titleRecipe.text = recipe?.title
        descriptionRecipe.text = recipe?.description
        
        time = recipe!.time
        timeRecipe.text = String(recipe!.time)
        
        difficulty = recipe!.difficulty
        
        if recipe?.video != ""{
            addVideoURL.text = "https://youtu.be/\(String(describing: recipe!.video))"
        }
        
        var urlImage : Data? = nil
        if recipe?.image != nil{
            urlImage = recipe?.image
        }
        
        var image : UIImage?
        
        if urlImage != nil{
            image = UIImage(data: urlImage!)
            imageRecipeView.image = image
            deletePhotoButton.isHidden = false
        }else{
            image = nil
        }
    }
    
    public func fillRecipe(){
        let time = Int(timeRecipe.text!) ?? 0
        var urlImage : Data? = nil
        if uploadedImage != nil{
            urlImage = uploadedImage.jpegData(compressionQuality: 0.5)!
        }
        
        var codeVideo: String.SubSequence = ""
        if !addVideoURL.text!.isEmpty{
            print("URL VIDEO",videoURL)
            codeVideo = (videoURL.dropFirst(17)) //Código del vídeo a partir de la barra
            print("El código del vídeo de Youtube es:", codeVideo)
        }
        
        if !titleRecipe.text!.isEmpty && !titleRecipe.text!.contains("  ") && titleRecipe.text != " " && !descriptionRecipe.text!.isEmpty && !descriptionRecipe.text!.contains("  ") && descriptionRecipe.text != " " && time != 0 && difficulty != 0 {
            recipe = Recipe(title: titleRecipe.text!, description: descriptionRecipe.text!, time: time, difficulty: difficulty, categories: [], ingredients: [], steps: [], image: urlImage, video: String(codeVideo))
        }else{
            let alert  = UIAlertController(title: "No se puede continuar", message: "Faltan campos obligatorios por rellenar", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func setImage(){
        viewFields.center = CGPoint (x : 200, y: 560)
        viewImage.center = CGPoint (x : 200, y: 240)
        viewImage.isHidden = false
    }
}

