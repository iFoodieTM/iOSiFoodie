import UIKit
import AlamofireImage
import Alamofire

class AddRecipe: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var titleRecipe: UITextField!
    @IBOutlet weak var ingredient: UITextField!
    @IBOutlet weak var step: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var stepsTableView: UITableView!
    
    @IBOutlet weak var viewRecipeButton: UIButton!
    @IBOutlet weak var viewPhotoButton: UIButton!
    @IBOutlet weak var viewVideoButton: UIButton!
    @IBOutlet weak var deletePhotoButton: UIButton!
    @IBOutlet weak var deleteVideoButton: UIButton!
    
    var descriptionRecipe = "Esta receta es muy saludable"
    
    var imagePicker : UIImagePickerController?
    var ingredientsArray = [String]()
    var stepsArray = [String]()

    var uploadedImage : UIImage!
    
    var categorias = ["Carne"]
    
    var tiempo = 45
    
    var dificultad = 4
    
    public func showViewRecipeButton(){
        if !titleRecipe.text!.isEmpty && !ingredientsArray.isEmpty && !stepsArray.isEmpty{
            viewRecipeButton.isHidden = false
        }else{
            viewRecipeButton.isHidden = true
        }
    }
    
    @IBAction func titleChanged(_ sender: UITextField) {
        showViewRecipeButton()
    }
    
    @IBAction func deleteUploadedButton(_ sender: Any) {
        uploadedImage = nil
        let alert = UIAlertController(title: "Imagen eliminada", message: "Puedes volver a elegir una imagen para tu receta", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        viewPhotoButton.isHidden = true
        deletePhotoButton.isHidden = true
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
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
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
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        uploadedImage = info[.originalImage] as? UIImage
        print("La imagen es: " , uploadedImage!)
        viewPhotoButton.isHidden = false
        deletePhotoButton.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRecipePopUp" {
            let RecipePopUp = segue.destination as! ViewRecipePopUp //ViewController al que pasar la información
            RecipePopUp.titleRecipe = titleRecipe.text! // variable del viewB que recibe lo que le envias de viewA
            RecipePopUp.ingredients = ingredientsArray
            RecipePopUp.steps = stepsArray
            RecipePopUp.image = uploadedImage
        }
        if segue.identifier == "viewImagePopUp" {
            let ImagePopUp = segue.destination as! ViewImagePopUp
            ImagePopUp.image = uploadedImage
        }
    }

    @IBAction func uploadVideo(_ sender: Any) {
        let alert = UIAlertController(title: "Elegir vídeo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveRecipe(_ sender: Any) {
        postRecipe()
        self.ingredientsArray.removeAll()
        self.stepsArray.removeAll()
        self.stepsTableView.reloadData()
        self.ingredientTableView.reloadData()
        self.titleRecipe.text! = ""
        viewRecipeButton.isHidden = true
        viewPhotoButton.isHidden = true
    }
    
    
    
    
    
    
    
    
    
    @IBAction func addIngredient(_ sender: Any) {
        let ingredientRecipe = ingredient.text
        if ingredientRecipe != "" && !(ingredientRecipe?.contains("  "))!{ //Comprobar que el campo no esté vacío
            ingredientsArray.append(ingredientRecipe!)
            ingredientTableView.reloadData()
            print(ingredientsArray)
            ingredient.text = "" //Reiniciar el campo de texto
            showViewRecipeButton()
        }
    }
    
    @IBAction func removeIngredient(_ sender: UIButton) {
        print(sender.tag)
        ingredientsArray.remove(at: sender.tag) //Eliminar elemento del Array
        let indexIngredient = IndexPath(item: sender.tag, section: 0) //Índice del elemento
        ingredientTableView.deleteRows(at: [indexIngredient], with: .right) //Eliminar la celda con animación
        print(ingredientsArray)
        showViewRecipeButton()
    }
    
    @IBAction func addStep(_ sender: Any) {
        let stepRecipe = step.text
        if stepRecipe != "" {
            stepsArray.append(stepRecipe!)
            stepsTableView.reloadData()
            print(stepsArray)
            step.text = ""
            showViewRecipeButton()
        }
    }
    
    @IBAction func removeStep(_ sender: UIButton) {
        print(sender.tag)
        stepsArray.remove(at: sender.tag)
        let indexStep = IndexPath(item: sender.tag, section: 0)
        stepsTableView.deleteRows(at: [indexStep], with: .right)
        print(stepsArray)
        showViewRecipeButton()
        showViewRecipeButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        ingredientTableView.backgroundColor = UIColor(white: 1, alpha: 0) //Fondo del TableView transparente
        stepsTableView.backgroundColor = UIColor(white: 1, alpha: 0)
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = 1
        switch tableView {
            case ingredientTableView:
                return ingredientsArray.count
            case stepsTableView:
                return stepsArray.count
            default:
                print("Error al cargar")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //TableView de Ingredientes
        if tableView.tag == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
            cell.backgroundColor = UIColor(white: 1, alpha: 0) //Celda transparente
            
            cell.ingredientName.text = ingredientsArray[indexPath.row] //Mostrar el ingrediente escrito
            cell.deleteIngredientButton.tag = indexPath.row
            return cell
        }
        
        //TableView de Pasos
        if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! StepCell
            cell.backgroundColor = UIColor(white: 1, alpha: 0) //Celda transparente
            
            let numberStepOrder = String(indexPath.row + 1) //Convertir el indexPath a String
            cell.stepOrder.text = numberStepOrder + "." //Mostrar el número del paso
            cell.stepInformation.text = stepsArray[indexPath.row] //Mostrar la información del paso escrito
            cell.deleteStepButton.tag = indexPath.row
            return cell
        }
        return cell
    }
    
    public func postRecipe(){
        let url = URL(string: "http://localhost:8888/APIiFoodie/public/index.php/api/recipes")
        
        let json = ["name" : titleRecipe.text!,
                    "ingredients" : ingredientsArray,
                    "steps" : stepsArray,
                    "categories" : categorias,
                    "difficulty" : dificultad,
                    "time" : tiempo,
                    "description": descriptionRecipe] as [String : Any]
        
        print (json)
        
        print ("token", Token)
        
        let Token = UserDefaults.standard.string(forKey: "token")
        
        let header = ["Authentication": Token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header as! HTTPHeaders).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            print(response)
            print(statusCode!)
            
            if statusCode == 200{
                let alert = UIAlertController(title: "Receta subida", message: "Tu nueva receta está disponible para que otros usuarios puedan verla", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else if statusCode == 500{
                let alert = UIAlertController(title: "Aviso", message: "Tienes que rellenar los campos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else if statusCode == 401{
                let alert = UIAlertController(title: "Aviso", message: "Tienes que rellenar los campos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Peticion incorrecta")
            }
        }
    }
}
    

