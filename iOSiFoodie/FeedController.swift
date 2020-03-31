//
//  FeedController.swift
//  iOSiFoodie
//
//  Created by Victor Garcia Torres on 26/02/2020.
//  Copyright © 2020 VictorGarcia. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage

class FeedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var json: [[String:Any]]?
    var jsonUser: [[String:Any]]?
    var jsonUserAdmin: [[String:Any]]?
    var numberJson = 0
    var url = URL(string: "")
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("?????????????????????????????????????????????????????????????????")
//
//        //self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
//        tableView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
//
//        //getUser()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.reloadData()
//    }
    override func viewDidAppear(_ animated: Bool) {
        print("?????????????????????????????????????????????????????????????????")
        tableView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        
        getApps()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberJson
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! cell
        
//        if json != nil {
//            if json![indexPath.row]["photo"] as! String == "fotoprueba.png" {
//
//                print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
//
//
//            } else {
                print(json![indexPath.row]["photo"] as! String)
                var start_url = json![indexPath.row]["photo"] as! String
                var pathImage = "http://54.226.238.184/storage/" + start_url
                url = URL(string: pathImage)
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                print(pathImage)
                print("\(url!)")
//              print("\(url!)")
            // if url as! String != "fotoprueba.png" {
                cell.recipeImg.af_setImage(withURL: url!)
                cell.recipeImg.layer.cornerRadius = cell.recipeImg.frame.height/2.5
                cell.recipeImg.layer.cornerRadius = cell.recipeImg.frame.width/2.5
                print(cell.recipeImg.af_setImage(withURL: url!))
                
//            }
            
//            }
//            url = URL(string: start_url)
//            print("\(url)" + "----------------------------------------------------------------------")
//            cell.recipeImg.af_setImage(withURL: url!)
//            cell.recipeImg.layer.cornerRadius = cell.recipeImg.frame.height/2.5
//            cell.recipeImg.layer.cornerRadius = cell.recipeImg.frame.width/2.5
//            print(cell.recipeImg.af_setImage(withURL: url!))
//            cell.recipeName.text = (json![indexPath.row]["name"]! as! String)
//
            //cell.recipeDifficult.text = ((json![indexPath.row]["difficulty"]!) as! String)
            cell.recipeName.text = (json![indexPath.row]["name"]! as! String)
            var dificultad = json![indexPath.row]["difficulty"]! as! Int
            cell.recipeDifficult.image = getDifficulty(dificultad: dificultad)
            var tiempo = json![indexPath.row]["time"]! as! Int
            cell.recipeTime.text = (String(tiempo))
            var id = json![indexPath.row]["id"]! as! Int
            cell.recipeID.text = (String(id))
            var userID = json![indexPath.row]["user_id"]! as! Int
            cell.userID.text = (String(userID))
            
            var user = getUsername(ID: userID)
            if user[""] as? String == "" {
                 user = getUsernameAdmin(ID: userID)
            }
            
            if user["user_name"] != nil {
                cell.recipeUser.text = user["user_name"] as! String
                var urlU = URL(string: user["photo"] as! String)
                cell.userImg.af_setImage(withURL: urlU!)
            }
            
        
        cell.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoceldaFinalFinalFinal (1)"))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! RecipeController
        let cell = sender as! cell
        let recipeid = cell.recipeID.text!
        let userName = cell.recipeUser.text!
        nextScreen.ID = recipeid
        nextScreen.userName = userName
        
       
    }
    func getDifficulty(dificultad: Int) -> UIImage{
        switch dificultad {
        case 1:
            return #imageLiteral(resourceName: "skull1")
        case 2:
            return #imageLiteral(resourceName: "skull3")
        case 3:
            return #imageLiteral(resourceName: "skull5")
        default:
            return #imageLiteral(resourceName: "skull6")
        }
    }
    
    func getUsername (ID: Int) -> [String:Any] {
      //var user: User = User
        var user_return: [String:Any] = ["":""]
        if jsonUser != nil {
            for user in jsonUser! {
                if user["id"] as! Int == ID {
                    user_return = user
                    return user_return

                }
            }
        }
        return user_return
    }
    func getUsernameAdmin (ID: Int) -> [String:Any] {
      //var user: User = User
        var user_return: [String:Any] = ["":""]
        if jsonUserAdmin != nil {
            for user in jsonUserAdmin! {
                if user["id"] as! Int == ID {
                    user_return = user
                    return user_return

                }
            }
        }
        return user_return
    }
    func getApps() {
        let url = URL(string: INIURL + "showAll")
        
        let header = ["Authentication": Token]
        print("=============================================================================")
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                
                self.json = response.result.value! as! [[String: Any]]
                self.numberJson = self.json!.count
                self.getUser()
                self.getUserAdmin()
                
            } else if response.response!.statusCode == 429 {
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            }
//                else {
//                let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
//                    (error) in
//                }
//                let alert = UIAlertController(title: "Error", message:
//                    "Informacion Incorrecta", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(alert1)
//                self.present(alert, animated: true, completion: nil)
//            }
        }
    }
        
        func getUser() {
            let url = URL(string: INIURL + "show_users")
            
            let header = ["Authentication": Token]
            
            Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                print("LLegga")
                print(response.response?.statusCode)
                if response.response!.statusCode == 200 {
                    print("lelee")
                    print("-------------------------------------------------")
                    print(response.value!)
                    self.jsonUser = response.value! as? [[String : Any]]
                    print("-------------------------------------------------")

                    print("Users", self.jsonUser)
                    self.tableView.reloadData()
                    
                } else {
                    let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                        (error) in
                    }
                    let alert = UIAlertController(title: "Error", message:
                        "Informacion Incorrecta", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(alert1)
                    self.present(alert, animated: true, completion: nil)
                }
            }
    }
    
    func getUserAdmin() {
              let url = URL(string: INIURL + "show_admin")
              
              let header = ["Authentication": Token]
              
              Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                  print("LLegga")
                  print(response.response?.statusCode)
                  if response.response!.statusCode == 200 {
                      print("lelee")
                      print("-------------------------------------------------")
                      print(response.value!)
                      self.jsonUserAdmin = response.value! as? [[String : Any]]
                      print("-------------------------------------------------")

                      print("Users", self.jsonUser)
                      self.tableView.reloadData()
                      
                  } else {
                      let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                          (error) in
                      }
                      let alert = UIAlertController(title: "Error", message:
                          "Informacion Incorrecta", preferredStyle: UIAlertController.Style.alert)
                      alert.addAction(alert1)
                      self.present(alert, animated: true, completion: nil)
                  }
              }
      }
}

