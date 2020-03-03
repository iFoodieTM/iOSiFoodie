//
//  PruebaId.swift
//  iOSiFoodie
//
//  Created by Victor Garcia Torres on 26/02/2020.
//  Copyright © 2020 VictorGarcia. All rights reserved.
//

//
//  idcontroller.swift
//  PruebasiFoodie
//
//  Created by alumnos on 26/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import UIKit
class PruebaId: UIViewController {
    
    var ID: String = ""
    @IBOutlet weak var id: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id.text = ID
    }
}
