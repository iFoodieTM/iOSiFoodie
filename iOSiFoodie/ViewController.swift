//
//  ViewController.swift
//  PruebasiFoodie
//
//  Created by alumnos on 24/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var userUserName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    var json: [[String:Any]]?
    var jsonUser: [String:Any]?
    var numberJson = 0
    var url = URL(string: "")
    var user_id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoIFOODIE"))
        self.tableview.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        getUser()
        if user_id != 0{
            getApps()
        }
        setUser()
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberJson
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! cell
        
        if json != nil {
            var start_url = json![indexPath.row]["photo"] as! String
            
            url = URL(string: start_url)
            cell.recipeImg.af_setImage(withURL: url!)
            cell.recipeImg.layer.cornerRadius = cell.recipeImg.frame.height/2
            print(cell.recipeImg.af_setImage(withURL: url!))
            cell.recipeName.text = (json![indexPath.row]["name"]! as! String)
            
            //cell.recipeDifficult.text = ((json![indexPath.row]["difficulty"]!) as! String)
           
            var dificultad = json![indexPath.row]["difficulty"]! as! Int
            cell.recipeDifficult.image = getDifficulty(dificultad: dificultad)
            var tiempo = json![indexPath.row]["time"]! as! Int
            cell.recipeTime.text = (String(tiempo))
            var id = json![indexPath.row]["id"]! as! Int
            cell.recipeID.text = (String(id))
            
        }
        if jsonUser != nil {
            print(jsonUser!)
            var urlUser  = URL(string: jsonUser!["photo"] as! String)
            userImg.af_setImage(withURL: urlUser!)
            userUserName.text = jsonUser!["user_name"] as! String
        }
        
        cell.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "fondoceldaFinalFinalFinal"))
        return cell
    }
    
    
    
    
    @IBAction func edit_profile(_ sender: Any) {
        self.performSegue(withIdentifier: "editProfile", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if edit.isTouchInside == true {
            let nextScreen = segue.destination as! EditProfile
        } else {
            let nextScreen = segue.destination as! RecipeController
            let cell = sender as! cell
            let recipeid = cell.recipeID.text!
            let userName = userUserName.text!
            nextScreen.ID = recipeid
            nextScreen.userName = userName
        }
    }
    
    func setUser () {
        if jsonUser != nil {
            print("Se va a imprimir")
            var urlUser  = URL(string: jsonUser!["photo"] as! String)
            print(urlUser!, "Nombre")
            userImg.af_setImage(withURL: urlUser!)
            userImg.layer.cornerRadius = userImg.frame.height/2
            userUserName.text = jsonUser!["user_name"] as! String
        }
    }
    
    func getDifficulty(dificultad: Int) -> UIImage{
        switch dificultad {
        case 1:
            return #imageLiteral(resourceName: "skull0")
        case 2:
            return #imageLiteral(resourceName: "skull1")
        case 3:
            return #imageLiteral(resourceName: "skull3")
        case 4:
            return #imageLiteral(resourceName: "skull4")
        case 5:
            return #imageLiteral(resourceName: "skull5")
        default:
            return #imageLiteral(resourceName: "skull6")
        }
    }
    func getApps() {
        let url = URL(string: INIURL + "showAllFromUser")
        let jsonId = ["user_id": user_id]
        
        let header = ["Authentication": Token]
        
        Alamofire.request(url!, method: .post, parameters: jsonId, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response?.statusCode)
            print("recipe")
            if response.response!.statusCode == 200 {
                self.json = response.result.value as? [[String: Any]]
                self.numberJson = self.json!.count
                self.tableview.reloadData()
                print(self.json!)
                
            }
        }
    }
    
    func getUser() {
        let url = URL(string: INIURL + "show_user")
        
        let header = ["Authentication": Token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response?.statusCode)
            print("user")
            if response.response!.statusCode == 200 {
                print(response.result.value!)
                self.jsonUser = response.result.value as? [String: Any]
                self.user_id = self.jsonUser!["id"] as! Int
                if self.json == nil {
                    self.viewDidLoad()
                }
                
                print(self.jsonUser!)
            }
        }
    }
}














































//  ViewController.swift
//  PruebaSiri
//
//  Created by alumnos on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
//
//import UIKit
//import AVFoundation
//import Speech
//
//
//class ViewController: UIViewController, SFSpeechRecognizerDelegate {
//
//    
//    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-ES"))!
//    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    private var recognitionTask: SFSpeechRecognitionTask?
//    // Gestor de micrófono
//    private let audioEngine = AVAudioEngine()
//    
//    @IBOutlet weak var text: UILabel!
//
//    @IBOutlet weak var text2: UILabel!
//
//    @IBOutlet weak var recordButton: UIButton!
//
//    var terminado = false
//    var contador = 0
//
//    let speechSynthesizer = AVSpeechSynthesizer()
//    let speechRecognizer2 = SFSpeechRecognizer()
//
//    override public func viewDidAppear(_ animated: Bool) {
//        // Configure the SFSpeechRecognizer object already
//        // stored in a local member variable.
//        speechRecognizer.delegate = self
//
//        // Make the authorization request
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//
//            // The authorization status results in changes to the
//            // app’s interface, so process the results on the app’s
//            // main queue.
//            OperationQueue.main.addOperation {
//                switch authStatus {
//                case .authorized:
//                    self.recordButton.isEnabled = true
//                    
//                case .denied:
//                    self.recordButton.isEnabled = false
//                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
//
//                case .restricted:
//                    self.recordButton.isEnabled = false
//                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
//
//                case .notDetermined:
//                    self.recordButton.isEnabled = false
//                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
//                }
//            }
//        }
//    }
//    
//    private func startRecording() throws {
//        
//        // Cancelar petición anterior
//        //        recognitionTask?.cancel()
//        //        self.recognitionTask = nil
//
//        // Configurar grabación
//
//        let audioSession = AVAudioSession.sharedInstance()
//        
//        let inputNode = audioEngine.inputNode
//
//        // Create and configure the speech recognition request.
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//        guard let recognitionRequest = recognitionRequest else { fatalError("No se pudo crear la petición de reconocimiento") }
//        recognitionRequest.shouldReportPartialResults = true
//
//        // Configuración del micrófono
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//            self.recognitionRequest?.append(buffer)
//        }
//
//        self.recordButton.isEnabled = true
//        self.recordButton.setTitle("Grabando", for: [])
//
//        audioEngine.prepare()
//        try audioEngine.start()
//
//        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//            if let result = result {
//
//                let mensaje = result.bestTranscription.formattedString
//
//                let mensajeCut = String(mensaje.dropFirst(self.contador))
//                print("Mensaje \(mensajeCut)")
//                if  (mensajeCut.contains("paso uno") || mensajeCut.contains("Paso uno")) && self.contador != mensaje.count {
//                    self.contador = mensaje.count
//
//                    print(self.contador)
//                    print("Text \(mensaje)")
//
//                    self.recordButton.setTitle("aaaaaaa...", for: .disabled)
//                    self.read2(string: self.text.text!)
//
//                } else if (mensajeCut.contains("paso dos") || mensajeCut.contains("Paso dos")) && self.contador != mensaje.count {
//                    print("qwertyuiop")
//
//                    self.contador = mensaje.count
//                    
//                    self.recordButton.setTitle("aaaaaaa...", for: .disabled)
//                    self.read2(string: self.text2.text!)
//
//
//                } else if (mensajeCut.contains("para") || mensajeCut.contains("Para")) && self.contador != mensaje.count {
//
//                    self.audioEngine.stop()
//                    recognitionRequest.endAudio()
//                    self.recordButton.isEnabled = false
//                    self.recordButton.setTitle("Desactivado", for: .disabled)
//                    self.recognitionTask?.cancel()
//                }
//            }
//        }
//    }
//
//
//    @IBAction func recordButton(_ sender: Any) {
//
//        if audioEngine.isRunning {
//            audioEngine.stop()
//            recognitionRequest?.endAudio()
//            recordButton.isEnabled = false
//            recordButton.setTitle("Parando", for: .disabled)
//        } else {
//
//            do {
//                try startRecording()
//                recordButton.setTitle("Parar grabación", for: [])
//            } catch {
//                recordButton.setTitle("Grabación no disponible", for: [])
//            }
//        }
//    }
//    
//    func textToNumber (string: String)->Int{
//        
//        if string == "Paso uno" || string == "paso uno" || string == "Paso 1" || string == "paso 1" {
//            return 1
//        }else if string == "Paso dos" || string == "paso dos" || string == "Paso 2" || string == "paso 2" {
//            return 2
//        }else {
//            return 0
//        }
//    }
//
//    func numberToText(int: Int)->String {
//        if int == 1 {
//            return text.text!
//        } else if int == 2 {
//            return text2.text!
//        } else {
//            return "lo siento no he podido entenderte, repite"
//        }
//    }
//
//
//
//    func read2(string: String) {
//
//        // Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            
//            try audioSession.overrideOutputAudioPort(.speaker)
//        }
//        catch {
//            print("aaaa")
//        }
//        // String a reproducir
//        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
//        // velocidad de reproduccion
//        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
//        // idioma
//        speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
//        
//        speechSynthesizer.speak(speechUtterance)
//        
//        print("-------------------------------------------------")
//    }
//
//}
//
