import UIKit
import Alamofire

public class AddIngredientsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryAlreadyAdded: UILabel!
    
    var selectedCategory = ""
    var categoryName: String = ""
    
    var categoriesDeletedArray: [String] = []
    var categoriesArray: [String] = []
    var categoriesSelectedArray: [String] = []
    var ingredientsArray = [String]()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryTableView.backgroundColor = UIColor(white: 1, alpha: 0)
        ingredientTableView.backgroundColor = UIColor(white: 1, alpha: 0)
        getCategories()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        if recipe != nil {
            setDataRecipe()
        }
    }
        
    public func getCategories() -> [String] {
        let url = URL(string: (INIURL + "show_categories"))
        let header = ["Authentication": Token]
        
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            print("El código de respuesta de la petición ha sido:", response.response?.statusCode)
            
            if response.response!.statusCode == 200{
                let json = response.value! as! [[String: Any]]
                print (json)
                for item in json{
                    
                    if self.selectedCategory == "" {
                        self.selectedCategory = item["name"] as! String
                    }
                    
                    self.categoriesArray.append(item["name"] as! String)
                }
                print("Las categorías registradas en la Base de Datos son:", self.categoriesArray)
                self.categoryPicker.selectRow(1, inComponent: 0, animated: true)
                self.categoryTableView.reloadData()
                self.categoryPicker.reloadAllComponents()
                
            }else{
                print("Petición incorrecta")
            }
        }
        return categoriesArray
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
    }
     
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return categoriesArray.count
    }
     
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return categoriesArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoriesArray[row]
        print("La categoria seleccionada es:", selectedCategory, row)
    }
    
    @IBAction func addCategory(_ sender: Any) {
        print("AÑADIDA",selectedCategory)
        if !categoriesSelectedArray.contains(selectedCategory) {
            categoriesSelectedArray.append(selectedCategory)
            print(categoriesSelectedArray)
            categoryTableView.reloadData()
        }else{
            categoryAlreadyAdded.isHidden = false
        }
        if categoryAlreadyAdded.isHidden == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.categoryAlreadyAdded.isHidden = true
            }
        }
    }
    
    @IBAction func removeCategory(_ sender: UIButton) {
        print(sender.tag)
        
        categoriesSelectedArray.remove(at: sender.tag) //Eliminar elemento del Array
        let indexCategory = IndexPath(item: sender.tag, section: 0) //Índice del elemento
        categoryTableView.deleteRows(at: [indexCategory], with: .right) //Eliminar la celda con animación
        categoryPicker.reloadAllComponents()
        
        print("Los ingredientes restantes son:", categoriesSelectedArray)
    }
    
    @IBAction func addIngredient(_ sender: Any) {
        let ingredientRecipe = ingredientName.text
        if !ingredientRecipe!.isEmpty && ingredientRecipe != " " && !(ingredientRecipe?.contains("  "))! && !ingredientsArray.contains(ingredientRecipe!){ //Comprobar que el campo no esté vacío, espacios y que no se repita
            ingredientsArray.append(ingredientRecipe!)
            ingredientTableView.reloadData()
            print(ingredientsArray)
            ingredientName.text = "" //Reiniciar el campo de texto
        }
    }
    
    @IBAction func removeIngredient(_ sender: UIButton) {
        print(sender.tag)
        ingredientsArray.remove(at: sender.tag) //Eliminar elemento del Array
        let indexIngredient = IndexPath(item: sender.tag, section: 0) //Índice del elemento
        ingredientTableView.deleteRows(at: [indexIngredient], with: .right) //Eliminar la celda con animación
        print(ingredientsArray)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return categoriesSelectedArray.count
        }
        if tableView.tag == 1 {
            return ingredientsArray.count
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //TableView de Categorías
        if tableView.tag == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.backgroundColor = UIColor(white: 1, alpha: 0) //Celda transparente
            
            cell.category.text = categoriesSelectedArray[indexPath.row]
            cell.deleteCategoryButton.tag = indexPath.row
            return cell
        }
        
        //TableView de Ingredientes
        if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
            cell.backgroundColor = UIColor(white: 1, alpha: 0) //Celda transparente
            
            cell.ingredientName.text = ingredientsArray[indexPath.row] //Mostrar el ingrediente escrito
            cell.deleteIngredientButton.tag = indexPath.row
            return cell
        }
        return cell
    }
    
    @IBAction func next(_ sender: Any) {
        fillRecipe()
    }
    
    public func fillRecipe(){
        if !categoriesArray.isEmpty && !ingredientsArray.isEmpty{
            recipe?.categories = categoriesSelectedArray
            recipe?.ingredients = ingredientsArray
        }else{
            let alert  = UIAlertController(title: "No se puede continuar", message: "Faltan campos obligatorios por rellenar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func setDataRecipe(){
        categoriesSelectedArray = recipe!.categories
        ingredientsArray = recipe!.ingredients
        print("Categorias:",recipe?.categories as Any)
        print("Ingredientes:",recipe?.ingredients as Any)
        categoryTableView.reloadData()
        ingredientTableView.reloadData()
    }
}
