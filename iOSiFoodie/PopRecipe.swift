//
//  PopRecipe.swift
//  iOSiFoodie
//
//  Created by Victor Garcia Torres on 05/03/2020.
//  Copyright © 2020 VictorGarcia. All rights reserved.
//

import UIKit

import Alamofire

import AlamofireImage



class PopRecipe: UIViewController {

    

    var position = 0

    var num = 1

    

    var idRecipe = ""

    

    override func viewDidLoad() {

        super.viewDidLoad()


        

        getRecipe()

    }

    

    func getRecipe() {

        let url = URL(string: INIURL + "show_recipe")

        

        let header = ["Authentication": Token]
        

        let json = ["recipe_id": idRecipe]

        

        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON{ (response) in

            

            if (response.response!.statusCode == 200) {

                print(response.value!)

                var receta = response.result.value as! [String: AnyObject]

                

                let ingredientes:Array<[String: Any]> = receta["ingredientes"]! as! Array<Any> as! Array<[String : Any]>

                

                for paso in ingredientes {

                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))

                    label.center = CGPoint(x: 180, y: 285 + self.position)

                    label.textAlignment = .left

                    let ingrediente = paso["name"]

                    label.text = "\(self.num))  " + (ingrediente as! String)

                    self.view.addSubview(label)

                    self.position += 40

                    self.num += 1

                }

                

            }

            if (response.response!.statusCode == 401)  {

                let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {

                    (error) in

                }

                let alert = UIAlertController(title: "Error", message:

                    "Email o contraseña incorrectos", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(alert1)

                self.present(alert, animated: true, completion: nil)

            }

        }

    }

    

    

    @IBAction func back(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

    

    

    

}
