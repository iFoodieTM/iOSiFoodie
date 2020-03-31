
import UIKit

import AVKit

import Alamofire

import AlamofireImage

import WebKit

import AVFoundation

import Speech

import SwiftUI


class RecipeController : UIViewController, SFSpeechRecognizerDelegate {
    var relleno = false

    
    @IBOutlet weak var longitud: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewFondo: UIView!
    
//
//    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-ES"))!
//    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    private var recognitionTask: SFSpeechRecognitionTask?
//    // Gestor de micrófono
//    private let audioEngine = AVAudioEngine()
//    
//    var orden: String = ""
//    
//    
//    var contador = 0
//    
//    var contPaso = 0
//    
//    let asistente = "carmela "
//
////    var arrayPasosHard = ["","Paso 1. Carne, tomate y ajetes", "paso 2. Echarlo todo a la olla", "Paso 3. Ponerlo a hervir a fuego lento","paso 4. cuando parezca que esta, es que esta"]
//    
//    let speechSynthesizer = AVSpeechSynthesizer()
//    let speechRecognizer2 = SFSpeechRecognizer()
//    
//    
//    
//    
//    
    
    @IBOutlet weak var textName: UILabel!
    
    @IBOutlet weak var imageRecipe: UIImageView!
    
    @IBOutlet weak var textDifficulty: UILabel!
    
    @IBOutlet weak var textTime: UILabel!
    
    @IBOutlet weak var textUser: UILabel!
    
    @IBOutlet weak var textDescription: UILabel!
    
    @IBOutlet weak var ingredientsTitle: UILabel!
    
    @IBOutlet weak var seeMoreIngredients: UIButton!
    
    @IBOutlet weak var textSteps: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    
    
    var arraySteps: [String] = [""]
    
    var arrayPasos = 0
    
    var position = 0
    
    var num = 1
    
    var ID: String = ""
    
    var position2 = 0
    
    var isFirstTime: Bool = true
    
    
    var videoCode = ""
    
    var userName = ""
    
    
    
    var largo = 0
    
    var posicionVideo = 0
    
    
    override public func viewDidAppear(_ animated: Bool) {
        // Configure the SFSpeechRecognizer object already
        // stored in a local member variable.
        
        getUser()
        
        getRecipe()
        
//        self.view.backgroundColor = UIColor(patternImage:#imageLiteral(resourceName: "fondo_IF_2 (1)"))
        
        // Transparencia del scrollView
        
        viewFondo.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        
//
//
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
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
//
//
//            func numberToText(int: Int)->String {
//
//                   return arraySteps[int]
//                   /*
//                   switch int {
//                   case -2:
//                       return ""
//                   case -1:
//                       return orden
//                   case 0:
//                       return orden
//
//                   default:
//                       return arrayPasos[int]
//                   }*/
//               }
//
//
////               func read1(string: String) {
////
////               let audioSession = AVAudioSession.sharedInstance()
////               do {
////                   try audioSession.overrideOutputAudioPort(.none)
////               }
////               catch {
////                   print("aaaa")
////               }
////
////                   // String a reproducir
////               let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
////                   // velocidad de reproduccion
////                   speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.2
////                   // idioma
////                   speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
////
////                   speechSynthesizer.speak(speechUtterance)
////
////               print("------------ Hablando siri: ",string," --------------------------")
////               }
////
//
//
//
//               func read2(string: String) {
//
//                   let audioSession = AVAudioSession.sharedInstance()
//                   do {
//                       try audioSession.overrideOutputAudioPort(.speaker)
//                   }
//                   catch {
//                       print("aaaa")
//                   }
//
//                       // String a reproducir
//                   let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
//                       // velocidad de reproduccion
//                       speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.2
//                       // idioma
//                       speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
//
//                       speechSynthesizer.speak(speechUtterance)
//
//                   print("------------ Hablando siri: ",string," --------------------------")
//                   }
//
//
//
//
//    func stopping() {
//        self.audioEngine.stop()
//        recognitionRequest!.endAudio()
//        self.recordButton.isEnabled = false
//        self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
//            do {
//
//
//                try self.startRecording()
//
//
//        //                    recordButton.backgroundColor = UIColor(patternImage: mic)
//
//        //                    self.recordButton.setTitle("Grabando", for: [])
//                        }
//                catch {
//                        self.recordButton.setTitle("Grabación no disponible", for: [])
//                }
//
//    }
//
//        private func startRecording() throws {
//
//    //         Cancelar petición anterior
////            recognitionTask?.cancel()
////            self.recognitionTask = nil
////
//            if isFirstTime {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.read2(string: "Hola, soy " + self.asistente + ". ¡Vamos a cocinar!")
//                self.isFirstTime = false
//                }
//
//            }else {
//                self.read2(string: "Volvemos a empezar")
//                self.contador = 0
//            }
//
//
//            // Configurar grabación
//
//
//            let inputNode = audioEngine.inputNode
//            inputNode.removeTap(onBus: 0)
//            // Create and configure the speech recognition request.
//            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//            guard let recognitionRequest = recognitionRequest else { fatalError("No se pudo crear la petición de reconocimiento") }
//            recognitionRequest.shouldReportPartialResults = true
//
//
//
////                    if #available(iOS 13, *) {
////                        recognitionRequest.requiresOnDeviceRecognition = false
////                    }
//
//
//            // Configuración del micrófono
//            let recordingFormat = inputNode.outputFormat(forBus: 0)
//            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//                self.recognitionRequest?.append(buffer)
//            }
//
//
//            self.recordButton.isEnabled = true
//            self.recordButton.setTitle("Grabando", for: [])
//
//            audioEngine.prepare()
//            try audioEngine.start()
//
//                recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//                    if let result = result {
//
//                        let mensaje = result.bestTranscription.formattedString
//                        var mensajeCut = String(mensaje.dropFirst(self.contador))
//                        print( "----------- mensaje: ", mensaje , " ----------------------")
//    //                    print("????????????????????????????????????????????????????????????????")
//
//    //                    print("Mensaje \(mensajeCut)")
//
//                        let paso = self.textToNumber(string: mensajeCut.lowercased())
//
//                        print( "----------- mensajeCut: ", mensajeCut , " ----------------------")
//
//                        print("------------ paso: ",paso, "-------------------")
//                        switch paso {
//                        case -2:
//
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//    //                        self.contador = 0
//
//                        case 0:
//                            self.stopping()
//
//
////                            self.recordButton.setTitle("Desactivado", for: .disabled)
////                            self.recognitionTask?.cancel()
//
//
//                        case 1:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//    //                        self.contador = 0
//
//                            self.read2(string: self.numberToText(int: 1))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//
//                        case 2:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                          //                        self.contador = 0
//    //
//                            self.read2(string: self.numberToText(int: 2))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 3:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 3))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 4:
//
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 4))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 5:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 5))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 6:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 6))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 7:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 7))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//    //
//    //                    case 8:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 9:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 10:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 11:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 12:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 13:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 14:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 15:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//                        default:
//                            self.read2(string: self.numberToText(int: 1))
//
//                        }
//                }
//            }
//        }
//
//
//    @IBAction func muteButton(_ sender: Any) {
//
//
//         do {
//                            muteButton.isHidden = true
//                            recordButton.isHidden = false
//                            try startRecording()
//                            audioEngine.prepare()
//                            try audioEngine.start()
//                            self.recordButton.isEnabled = true
//
//        //                    recordButton.backgroundColor = UIColor(patternImage: mic)
//
//        //                    self.recordButton.setTitle("Grabando", for: [])
//                        }
//                        catch {
//                            self.recordButton.setTitle("Grabación no disponible", for: [])
//                        }
//
//
//    }
//
//    @IBAction func recordButton(_ sender: Any) {
//
////
////            if audioEngine.isRunning {
////
////                audioEngine.stop()
////                recognitionRequest?.endAudio()
////                recordButton.isHidden = false
////                muteButton.isHidden = true
//////                self.recordButton.setTitle("Desactivado", for: .disabled)
////
////
////            } else {
//               audioEngine.stop()
//               recognitionRequest?.endAudio()
//               self.muteButton.isEnabled = true
//
//               recordButton.isHidden = true
//               muteButton.isHidden = false
//
//
//        }
//
//
//
//        //        if #available(iOS 13, *) {
//        //            recognitionRequest.requiresOnDeviceRecognition = false
//        //        }
//
//
//        func textToNumber (string: String)->Int{
//
//
//            print("------------ yo digo: " ,string , " --------------------")
//            if string == "" { return -2 }
//
//            if string.contains(asistente+"empieza") || string.contains(asistente+"desde el principio") {
//                contPaso = 1
//                return contPaso
//            }
//            if string.contains(asistente + "siguiente") || string.contains(asistente + "continúa") {
//                contPaso += 1
//                return contPaso
//            }
//            if string.contains(asistente + "repite") {
//                return contPaso
//            }
//            if string.contains(asistente + "anterior"){
//                contPaso -= 1
//                return contPaso
//            }
//
//
//
//
//            if string.contains(asistente + "detente") || string.contains(asistente + "calla") || string.contains(asistente+"fin") || string.contains(asistente+"no es no") || string.contains(asistente+"para") {
//                contPaso = 0
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso uno") || string.contains(asistente+"paso 1") || string.contains(asistente+"lee el primer paso") || string.contains(asistente+"primer paso") {
//                contPaso = 1
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso dos") || string.contains(asistente + "paso 2") || string.contains(asistente + "segundo paso") || string.contains(asistente + "lee el segundp paso") || string.contains(asistente + "lee el segundo"){
//                contPaso = 2
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso tres") || string.contains(asistente + "paso 3") || string.contains(asistente + "lee el tercer paso") || string.contains(asistente + "tercer paso") {
//                contPaso = 3
//                return contPaso
//            }
//
//            if string.contains("paso cuatro") || string.contains(asistente + "paso cuatro") || string.contains(asistente + "lee el paso cuatro") || string.contains(asistente + "cuarto paso")  {
//                contPaso = 4
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso cinco") || string.contains(asistente + "paso 5") || string.contains(asistente + "lee el quinto paso") || string.contains(asistente + "quinto paso") {
//                contPaso = 5
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso seis") || string.contains(asistente + "paso 6") || string.contains(asistente + "lee el sexto paso") || string.contains(asistente + "sexto paso") {
//                contPaso = 6
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso siete") || string.contains(asistente + "paso 7") || string.contains(asistente + "lee el séptimo paso") || string.contains(asistente + "séptimo paso") {
//                contPaso = 7
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso ocho") || string.contains(asistente + "paso 8") || string.contains(asistente + "lee el octavo paso") || string.contains(asistente + "octavo paso") {
//                contPaso = 8
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso nueve") || string.contains(asistente + "paso 9") || string.contains(asistente + "lee el noveno paso") || string.contains(asistente + "noveno paso") {
//                contPaso = 9
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso diez") || string.contains(asistente + "paso 10") || string.contains(asistente + "lee el décimo paso") || string.contains(asistente + "décimo paso") {
//                contPaso = 10
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso once") || string.contains(asistente + "paso 11") || string.contains(asistente + "lee el onceavo paso") || string.contains(asistente + "onceavo paso") {
//                contPaso = 11
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso doce") || string.contains(asistente + "paso 12") || string.contains(asistente + "lee el doceavo paso") || string.contains(asistente + "doceavo paso") {
//                contPaso = 12
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso diez") || string.contains(asistente + "paso 10") || string.contains(asistente + "lee el décimo paso") || string.contains(asistente + "décimo paso") {
//                contPaso = 10
//                return contPaso
//            }
//            return -2
//        }
//
//
//
//
//
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if button.isTouchInside {
            let nextScreen = segue.destination as! PopSteps
            let recipeID = ID
            nextScreen.idRecipe = recipeID
        } else {
            let nextScreen = segue.destination as! PopRecipe
            let recipeID = ID
            nextScreen.idRecipe = recipeID
        }
    }
    
    
    
    func getUser() {
        
        self.textUser.text! = userName
        
    }
    
    
    
    func getRecipe() {
        
        let url = URL(string: INIURL + "show_recipe")
        
        
        
        let header = ["Authentication": Token]
        
        
        
        let json = ["recipe_id": ID]
        
        
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON{ (response) in
            
            
            
            if (response.response!.statusCode == 200) {
                
                print(response.value!)
                
                var receta = response.result.value as! [String: AnyObject]
                
                
                
                let nombreReceta = receta["recipe"]!["name"]!
                
                let imagenReceta = URL(string: (receta["recipe"]!["photo"] as! String?)!)
                
                print(receta["recipe"]!["photo"] as! String?)
                print("----------------------------------------------")
                let videoReceta = receta["recipe"]!["video"]!
                
                let tiempoReceta = receta["recipe"]!["time"]! as! Int
                
                let dificultadReceta = receta["recipe"]!["difficulty"]! as! Int
                
                let descripcionReceta = receta["recipe"]!["description"]!
                
                
                
                self.textName.text = nombreReceta! as? String
                
                self.imageRecipe.af_setImage(withURL: imagenReceta!)
                
                self.videoCode = videoReceta as? String ??  ""
                
                self.textTime.text = (String(tiempoReceta)) + " min"
                
                self.textDifficulty.text = (String(dificultadReceta))
                
                self.textDescription.text = descripcionReceta as? String
                
                
                
                if self.textDescription.text!.count < 100 {
                    
                    self.ingredientsTitle.center = CGPoint(x: 90, y: 350)
                    
                    self.seeMoreIngredients.center = CGPoint(x: 65, y: 375)
                    
                    self.textSteps.center = CGPoint(x: 60, y: 425)
                    
                    self.position = -200
                    
                    self.posicionVideo = 750
                    
                    self.textDescription.sizeToFit()
                    
                    
                    
                }
                
                
                
                // Rellenar los pasos en la vista
//
//                let pasos:Array<[String: Any]> = receta["pasos"]! as! Array<Any> as! Array<[String : Any]>
//
//                self.arrayPasos = pasos.count
//
//                print("aaaa", self.arrayPasos)
//
//
//
//                for paso in pasos {
//
//                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 360, height: 130))
//
//                    label.numberOfLines = 6
//
//                    label.textAlignment = .left
//
//                    let instruccion = paso["instructions"]
//
//                    label.text = "\(self.num) - " + (instruccion as! String)
//
//                    self.viewFondo.addSubview(label)
//
//
//
//                    self.largo = label.text?.count as! Int
//
//                    print("qqqqq ", label.text?.count as Any , String(self.position))
//
//                    switch self.largo {
//
//                    case 0...51:
//
//                        self.position += 30
//
//                        break
//
//                    case 150...200:
//
//                        self.position += 115
//
//                        break
//
//                    default:
//
//                        self.position += 80
//
//                        break
//
//                    }
//
//
//
//                    label.center = CGPoint(x: 210, y: 640 + self.position)
//
//                    self.arraySteps.append("Paso \(self.num). " + (instruccion as! String))
//
//                    self.num += 1
//
//
//
//
//
//                }
//
                print(self.arraySteps)
                
                
                
                // Rellenar las categorias en la vista
                
                let categorias:Array<[String: Any]> = receta["category"]! as! Array<Any> as! Array<[String: Any]>
                
                
                
                if self.relleno == false {
                    
                    for i in categorias {
                        
                        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
                        
                        label.center = CGPoint(x: 150 + self.position2, y: 240)
                        
                        label.textAlignment = .left
                        
                        let category = i["name"]
                        
                        label.text = (category as! String)
                        
                        self.viewFondo.addSubview(label)
                        
                        self.position2 += 100
                        self.relleno = true
                    }
                    
                }
                    

//                for i in categorias {
//
//                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
//
//                    label.center = CGPoint(x: 150 + self.position2, y: 240)
//
//                    label.textAlignment = .left
//
//                    let category = i["name"]
//
//                    label.text = (category as! String)
//
//                    self.viewFondo.addSubview(label)
//
//                    self.position2 += 100
//
//                }
                
                
                
                self.cargar()
                
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
    
    
    
    func cargar() {
        
        if videoCode != "" {
            
            let video = WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
            
            video.center = CGPoint(x: 210, y: 780)
            
            viewFondo.addSubview(video)
            
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            
            video.load(URLRequest(url: url!))
                        
              
              print("posicion: ",position)
            
        }
    }
        
//        private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-ES"))!
//        private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//        private var recognitionTask: SFSpeechRecognitionTask?
//        // Gestor de micrófono
//        private let audioEngine = AVAudioEngine()
//
//        var orden: String = ""
//
//        @IBOutlet weak var text: UILabel!
//
//        @IBOutlet weak var text2: UILabel!
//
//        @IBOutlet weak var text3: UILabel!
//
//        @IBOutlet weak var recordButton: UIButton!
//
//        var contador = 0
//
//        var contPaso = 0
//
//        let asistente = "carmela "
//
//        var arrayPasos = ["","Paso 1. Carne, tomate y ajetes", "paso 2. Echarlo todo a la olla", "Paso 3. Ponerlo a hervir a fuego lento","paso 4. cuando parezca que esta, es que esta"]
//
//        let speechSynthesizer = AVSpeechSynthesizer()
//        let speechRecognizer2 = SFSpeechRecognizer()
//
//        override public func viewDidAppear(_ animated: Bool) {
//            // Configure the SFSpeechRecognizer object already
//            // stored in a local member variable.
//            speechRecognizer.delegate = self
//
//            // Make the authorization request
//            SFSpeechRecognizer.requestAuthorization { authStatus in
//
//                // The authorization status results in changes to the
//                // app’s interface, so process the results on the app’s
//                // main queue.
//                OperationQueue.main.addOperation {
//                    switch authStatus {
//                    case .authorized:
//                        self.recordButton.isEnabled = true
//
//                    case .denied:
//                        self.recordButton.isEnabled = false
//                        self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
//
//                    case .restricted:
//                        self.recordButton.isEnabled = false
//                        self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
//
//                    case .notDetermined:
//                        self.recordButton.isEnabled = false
//                        self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
//                    }
//                }
//            }
//        }
//
//        private func startRecording() throws {
//
//    //         Cancelar petición anterior
//            recognitionTask?.cancel()
//            self.recognitionTask = nil
//
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.read2(string: "Hola, soy " + self.asistente + ". ¡Vamos a cocinar!")
//            }
//
//            // Configurar grabación
//
//
//
//
//            let inputNode = audioEngine.inputNode
//
//            // Create and configure the speech recognition request.
//            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//            guard let recognitionRequest = recognitionRequest else { fatalError("No se pudo crear la petición de reconocimiento") }
//            recognitionRequest.shouldReportPartialResults = true
//
//            // Configuración del micrófono
//            let recordingFormat = inputNode.outputFormat(forBus: 0)
//            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//                self.recognitionRequest?.append(buffer)
//            }
//
//
//            self.recordButton.isEnabled = true
//            self.recordButton.setTitle("Grabando", for: [])
//
//            audioEngine.prepare()
//            try audioEngine.start()
//
//                recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//                    if let result = result {
//
//                        let mensaje = result.bestTranscription.formattedString
//                        var mensajeCut = String(mensaje.dropFirst(self.contador))
//                        print( "----------- mensaje: ", mensaje , " ----------------------")
//    //                    print("????????????????????????????????????????????????????????????????")
//
//    //                    print("Mensaje \(mensajeCut)")
//
//                        let paso = self.textToNumber(string: mensajeCut.lowercased())
//
//                        print( "----------- mensajeCut: ", mensajeCut , " ----------------------")
//
//                        print("------------ paso: ",paso, "-------------------")
//                        switch paso {
//                        case -2:
//
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//    //                        self.contador = 0
//
//                        case 0:
//                            self.audioEngine.stop()
//                            recognitionRequest.endAudio()
//                            self.recordButton.isEnabled = false
//                            self.recordButton.setTitle("Desactivado", for: .disabled)
//                            self.recognitionTask?.cancel()
//
//                        case 1:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//    //                        self.contador = 0
//
//                            self.read2(string: self.numberToText(int: 1))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//
//    //                        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")
//
//
//                        case 2:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//    ////                        //                        self.contador = 0
//    ////
//                            self.read2(string: self.numberToText(int: 2))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 3:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 3))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 4:
//
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 4))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 5:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 5))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 6:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 6))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//
//                        case 7:
//                            self.contador = mensaje.count
//                            print("------------ contador: ",self.contador, "-------------------")
//                            ////                        //                        self.contador = 0
//                            ////
//                            self.read2(string: self.numberToText(int: 7))
//                            mensajeCut = String(mensaje.dropFirst(self.contador))
//    //
//    //                    case 8:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 9:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 10:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 11:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 12:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 13:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 14:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//    //
//    //                    case 15:
//    //
//    //                        self.contador = mensaje.count
//    //                        self.read2(string: self.numberToText(int: 3))
//                        default:
//                            self.read2(string: self.numberToText(int: 1))
//
//                        }
//                }
//            }
//        }
//
//
//        @IBAction func recordButton(_ sender: Any) {
//
//            if audioEngine.isRunning {
//
//                audioEngine.stop()
//                recognitionRequest?.endAudio()
//                recordButton.isEnabled = false
//                self.recordButton.setTitle("Parando", for: .disabled)
//
//            } else {
//                do {
//
//                    try startRecording()
//                    audioEngine.prepare()
//                    try audioEngine.start()
//                    self.recordButton.isEnabled = true
//                    self.recordButton.setTitle("Grabando", for: [])
//
//                } catch {
//                    recordButton.setTitle("Grabación no disponible", for: [])
//                }
//            }
//        }
//        //        if #available(iOS 13, *) {
//        //            recognitionRequest.requiresOnDeviceRecognition = false
//        //        }
//
//
//        func textToNumber (string: String)->Int{
//
//
//            print("------------ yo digo: " ,string , " --------------------")
//            if string == "" { return -2 }
//
//            if string.contains(asistente+"empieza") || string.contains(asistente+"desde el principio") {
//                contPaso = 1
//                return contPaso
//            }
//            if string.contains(asistente + "siguiente") || string.contains(asistente + "continúa") {
//                contPaso += 1
//                return contPaso
//            }
//            if string.contains(asistente + "repite") {
//                return contPaso
//            }
//            if string.contains(asistente + "anterior"){
//                contPaso -= 1
//                return contPaso
//            }
//
//
//
//
//            if string.contains(asistente + "detente") || string.contains(asistente + "calla") || string.contains(asistente+"fin") || string.contains(asistente+"no es no") || string.contains(asistente+"para") {
//                contPaso = 0
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso uno") || string.contains(asistente+"paso 1") || string.contains(asistente+"lee el primer paso") || string.contains(asistente+"primer paso") {
//                contPaso = 1
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso dos") || string.contains(asistente + "paso 2") || string.contains(asistente + "segundo paso") || string.contains(asistente + "lee el segundp paso") || string.contains(asistente + "lee el segundo"){
//                contPaso = 2
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso tres") || string.contains(asistente + "paso 3") || string.contains(asistente + "lee el tercer paso") || string.contains(asistente + "tercer paso") {
//                contPaso = 3
//                return contPaso
//            }
//
//            if string.contains("paso cuatro") || string.contains(asistente + "paso cuatro") || string.contains(asistente + "lee el paso cuatro") || string.contains(asistente + "cuarto paso")  {
//                contPaso = 4
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso cinco") || string.contains(asistente + "paso 5") || string.contains(asistente + "lee el quinto paso") || string.contains(asistente + "quinto paso") {
//                contPaso = 5
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso seis") || string.contains(asistente + "paso 6") || string.contains(asistente + "lee el sexto paso") || string.contains(asistente + "sexto paso") {
//                contPaso = 6
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso siete") || string.contains(asistente + "paso 7") || string.contains(asistente + "lee el séptimo paso") || string.contains(asistente + "séptimo paso") {
//                contPaso = 7
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso ocho") || string.contains(asistente + "paso 8") || string.contains(asistente + "lee el octavo paso") || string.contains(asistente + "octavo paso") {
//                contPaso = 8
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso nueve") || string.contains(asistente + "paso 9") || string.contains(asistente + "lee el noveno paso") || string.contains(asistente + "noveno paso") {
//                contPaso = 9
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso diez") || string.contains(asistente + "paso 10") || string.contains(asistente + "lee el décimo paso") || string.contains(asistente + "décimo paso") {
//                contPaso = 10
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso once") || string.contains(asistente + "paso 11") || string.contains(asistente + "lee el onceavo paso") || string.contains(asistente + "onceavo paso") {
//                contPaso = 11
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso doce") || string.contains(asistente + "paso 12") || string.contains(asistente + "lee el doceavo paso") || string.contains(asistente + "doceavo paso") {
//                contPaso = 12
//                return contPaso
//            }
//
//            if string.contains(asistente + "paso diez") || string.contains(asistente + "paso 10") || string.contains(asistente + "lee el décimo paso") || string.contains(asistente + "décimo paso") {
//                contPaso = 10
//                return contPaso
//            }
//            return -2
//        }
//
//
//        func numberToText(int: Int)->String {
//
//            return arrayPasos[int]
//            /*
//            switch int {
//            case -2:
//                return ""
//            case -1:
//                return orden
//            case 0:
//                return orden
//
//            default:
//                return arrayPasos[int]
//            }*/
//        }
//
//
//
//        func read2(string: String) {
//
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.overrideOutputAudioPort(.speaker)
//            }
//            catch {
//                print("aaaa")
//            }
//
//                // String a reproducir
//            let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
//                // velocidad de reproduccion
//                speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 1.9
//                // idioma
//                speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
//
//                speechSynthesizer.speak(speechUtterance)
//
//            print("------------ Hablando siri: ",string," --------------------------")
//            }
//
    }

















    //
    //                    case 4:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 5:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 6:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 7:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 8:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 9:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 10:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 11:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 12:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 13:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 14:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))
    //
    //                    case 15:
    //
    //                        self.contador = mensaje.count
    //                        self.read2(string: self.numberToText(int: 3))

    
    
    
    
    
    
    

