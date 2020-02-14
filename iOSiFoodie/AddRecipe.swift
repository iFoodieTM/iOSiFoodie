import UIKit

class AddRecipe : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleRecipe: UITextField!
    @IBOutlet weak var ingredient: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var step: UITextField!
    @IBOutlet weak var stepsTableView: UITableView!
    
    var ingredientsArray = [String]()
    var stepsArray = [String]()
    
    @IBAction func addIngredient(_ sender: Any) {
        let ingredientRecipe = ingredient.text
        if ingredientRecipe != ""{ //Comprobar que el campo no esté vacío
            ingredientsArray.append(ingredientRecipe!)
            ingredientTableView.reloadData()
            print(ingredientsArray)
            ingredient.text = "" //Reiniciar el campo de texto
        }
    }
    
    @IBAction func removeIngredient(_ sender: UIButton) {
        ingredientsArray.remove(at: sender.tag) //Eliminar elemento del Array
        let indexIngredient = IndexPath(item: sender.tag, section: 0) //Índice del elemento
        ingredientTableView.deleteRows(at: [indexIngredient], with: .right) //Eliminar la celda con animación
    }
    
    @IBAction func addStep(_ sender: Any) {
        let stepRecipe = step.text
        if stepRecipe != "" {
            stepsArray.append(stepRecipe!)
            stepsTableView.reloadData()
            print(stepsArray)
            step.text = ""
        }
    }
    
    @IBAction func removeStep(_ sender: UIButton) {
        stepsArray.remove(at: sender.tag)
        let indexStep = IndexPath(item: sender.tag, section: 0)
        stepsTableView.deleteRows(at: [indexStep], with: .right)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        super.viewDidLoad()
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
            
            cell.ingredientName.text = ingredientsArray[indexPath.row]
            return cell
        }
        
        //TableView de Pasos
        if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! StepCell
            cell.backgroundColor = UIColor(white: 1, alpha: 0) //Celda transparente
            
            let numberStepOrder = String(indexPath.row + 1) //Convertir el indexPath a String
            cell.stepOrder.text = numberStepOrder + "."
            cell.stepInformation.text = stepsArray[indexPath.row]
            return cell
        }
        return cell
    }
}
    

