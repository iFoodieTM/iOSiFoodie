
import UIKit
import Alamofire
import AlamofireImage
import Speech
import AVFoundation


class PopSteps: UIViewController, SFSpeechRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var pasos:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pasos != nil {
            return pasos.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as! StepsCell
        
        if pasos != nil {
            print("--------------------------------", pasos[indexPath.row])
            cell.steps.text! = pasos[indexPath.row]
        }else {
            stepsTableView.reloadData()
        }
        return cell
    }
    

    @IBOutlet weak var stepsTableView: UITableView!
    @IBOutlet weak var recordButton: UIButton!
        
        @IBOutlet weak var muteButton: UIButton!
        
    
        var readingStep:String = "dpmfdpmfpdsfm"
        
        private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-ES"))!
        private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        private var recognitionTask: SFSpeechRecognitionTask?
        // Gestor de micrófono
        private let audioEngine = AVAudioEngine()
        
        var orden: String = ""
        
        
        var contador = 0
        
        var contPaso = 0
        
        let asistente = "carmela "

    //    var arrayPasosHard = ["","Paso 1. Carne, tomate y ajetes", "paso 2. Echarlo todo a la olla", "Paso 3. Ponerlo a hervir a fuego lento","paso 4. cuando parezca que esta, es que esta"]
        
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechRecognizer2 = SFSpeechRecognizer()
        

        var arraySteps: [String] = [""]
        
        var arrayPasos = 0
        
        var position = 0
        
        var num = 1
        
        var ID: String = ""
        
        var position2 = 0
        
        var isFirstTime: Bool = true
        
        
        
        
        var largo = 0
        
        var posicionVideo = 0
    
    
    var idRecipe = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe()
        stepsTableView.dataSource = self
        stepsTableView.delegate = self
    }
    
        
        
        override public func viewDidAppear(_ animated: Bool) {
            // Configure the SFSpeechRecognizer object already
            // stored in a local member variable.
          
    //        self.view.backgroundColor = UIColor(patternImage:#imageLiteral(resourceName: "fondo_IF_2 (1)"))
            
            // Transparencia del scrollView
        
            
            
            speechRecognizer.delegate = self

            // Make the authorization request
            SFSpeechRecognizer.requestAuthorization { authStatus in
                
                // The authorization status results in changes to the
                // app’s interface, so process the results on the app’s
                // main queue.
                OperationQueue.main.addOperation {
                    switch authStatus {
                    case .authorized:
                        self.recordButton.isEnabled = true
                        
                    case .denied:
                        self.recordButton.isEnabled = false
                        self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                        
                    case .restricted:
                        self.recordButton.isEnabled = false
                        self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                        
                    case .notDetermined:
                        self.recordButton.isEnabled = false
                        self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                    }
                }
            }
        }
                
                func numberToText(int: Int)->String {
                       var paso = pasos[(int-1)]
                       return "paso " + paso
                       /*
                       switch int {
                       case -2:
                           return ""
                       case -1:
                           return orden
                       case 0:
                           return orden

                       default:
                           return arrayPasos[int]
                       }*/
                   }
        
        
    //               func read1(string: String) {
    //
    //               let audioSession = AVAudioSession.sharedInstance()
    //               do {
    //                   try audioSession.overrideOutputAudioPort(.none)
    //               }
    //               catch {
    //                   print("aaaa")
    //               }
    //
    //                   // String a reproducir
    //               let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
    //                   // velocidad de reproduccion
    //                   speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.2
    //                   // idioma
    //                   speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
    //
    //                   speechSynthesizer.speak(speechUtterance)
    //
    //               print("------------ Hablando siri: ",string," --------------------------")
    //               }
    //
                   
        
        
       func read2(string: String) {
           
           let audioSession = AVAudioSession.sharedInstance()
           do {
               try audioSession.overrideOutputAudioPort(.speaker)
           }
           catch {
               print("aaaa")
           }
           
               // String a reproducir
           let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
               // velocidad de reproduccion
               speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.2
               // idioma
               speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
           
               speechSynthesizer.speak(speechUtterance)
               readingStep = string
        
           print("------------ Hablando siri: ",string," --------------------------")
        
        

           print("------------ Empezando a leer: --------------------------")
           }
    
    
        func read1(string: String) {
           
           let audioSession = AVAudioSession.sharedInstance()
           do {
               try audioSession.overrideOutputAudioPort(.speaker)
           }
           catch {
               print("aaaa")
           }
           
               // String a reproducir
           let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
               // velocidad de reproduccion
               speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.2
            
                speechUtterance.volume = 80
               // idioma
               speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
           
               speechSynthesizer.speak(speechUtterance)
               readingStep = string
        
           print("------------ Hablando siri: ",string," --------------------------")
        
        

           print("------------ Empezando a leer: --------------------------")
           }
                   
        
        
        
        func stopping() {
            self.audioEngine.stop()
            recognitionRequest!.endAudio()
            self.recordButton.isEnabled = false
            self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                do {
                               
                
                    try self.startRecording()
                    

            //                    recordButton.backgroundColor = UIColor(patternImage: mic)
                                
            //                    self.recordButton.setTitle("Grabando", for: [])
                            }
                    catch {
                            self.recordButton.setTitle("Grabación no disponible", for: [])
                    }

        }
        
            private func startRecording() throws {
                
        //         Cancelar petición anterior
    //            recognitionTask?.cancel()
    //            self.recognitionTask = nil
    //
                if isFirstTime {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.read2(string: "Hola, soy " + self.asistente + ". ¡Vamos a cocinar!")
                    self.isFirstTime = false
                    }
                    
                }else {
                    self.read2(string: "Volvemos a empezar")
                    self.contador = 0
                }
                
            
                // Configurar grabación
                
                
                let inputNode = audioEngine.inputNode
                inputNode.removeTap(onBus: 0)
                // Create and configure the speech recognition request.
                recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                guard let recognitionRequest = recognitionRequest else { fatalError("No se pudo crear la petición de reconocimiento") }
                recognitionRequest.shouldReportPartialResults = true
                
                

    //                    if #available(iOS 13, *) {
    //                        recognitionRequest.requiresOnDeviceRecognition = false
    //                    }

                
                // Configuración del micrófono
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    self.recognitionRequest?.append(buffer)
                }
                
                
                self.recordButton.isEnabled = true
                self.recordButton.setTitle("Grabando", for: [])
                
                audioEngine.prepare()
                try audioEngine.start()
               
                    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                        if let result = result {
                            
                            let mensaje = result.bestTranscription.formattedString
                            var mensajeCut = String(mensaje.dropFirst(self.contador))
                            print( "----------- mensaje: ", mensaje , " ----------------------")
        //                    print("????????????????????????????????????????????????????????????????")
                            
        //                    print("Mensaje \(mensajeCut)")
                            
                            let paso = self.textToNumber(string: mensajeCut.lowercased())
                            
                            print( "----------- mensajeCut: ", mensajeCut , " ----------------------")
                            
                            print("------------ paso: ",paso, "-------------------")
                            switch paso {
                                
                            case -2:
                                
                                mensajeCut = String(mensaje.dropFirst(self.contador))
        //                        self.contador = 0
                                
                            case 0:
                                self.stopping()
                                
                                
    //                            self.recordButton.setTitle("Desactivado", for: .disabled)
    //                            self.recognitionTask?.cancel()

                                
                            case 1:
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
        //                        self.contador = 0

                                self.read2(string: self.numberToText(int: 1))
                                mensajeCut = String(mensaje.dropFirst(self.contador))

                                
                            case 2:
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                              //                        self.contador = 0
        //
                                self.read2(string: self.numberToText(int: 2))
                                mensajeCut = String(mensaje.dropFirst(self.contador))
                                
                            case 3:
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                                ////                        //                        self.contador = 0
                                ////
                                self.read2(string: self.numberToText(int: 3))
                                mensajeCut = String(mensaje.dropFirst(self.contador))

                            case 4:

                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                                ////                        //                        self.contador = 0
                                ////
                                self.read2(string: self.numberToText(int: 4))
                                mensajeCut = String(mensaje.dropFirst(self.contador))

                            case 5:
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                                ////                        //                        self.contador = 0
                                ////
                                self.read2(string: self.numberToText(int: 5))
                                mensajeCut = String(mensaje.dropFirst(self.contador))

                            case 6:
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                                ////                        //                        self.contador = 0
                                ////
                                self.read2(string: self.numberToText(int: 6))
                                mensajeCut = String(mensaje.dropFirst(self.contador))

                            case 7:
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                                ////                        //                        self.contador = 0
                                ////
                                self.read2(string: self.numberToText(int: 7))
                                mensajeCut = String(mensaje.dropFirst(self.contador))
                                
                            case 8:
                                
                                self.contador = mensaje.count
                                print("------------ contador: ",self.contador, "-------------------")
                                ////                        //                        self.contador = 0
                                ////
                                self.read2(string: "que baile tu prima la sin dientes")
                                mensajeCut = String(mensaje.dropFirst(self.contador))
                                
                                
                                
                                
                            case 9:
                            
                            self.contador = mensaje.count
                            print("------------ contador: ",self.contador, "-------------------")
                            ////                        //                        self.contador = 0
                            ////
                            self.read2(string: "Viva!!., Cara al sol con la camisa nueva. Que tú bordaste en rojo ayer,Me hallará la muerte si me lleva Y no te vuelvo a ver. Formaré junto a los compañeros  Que hacen guardia sobre los luceros")
                            mensajeCut = String(mensaje.dropFirst(self.contador))
                            //
                            case 10:
                            
                            self.contador = mensaje.count
                            print("------------ contador: ",self.contador, "-------------------")
                            ////                        //                        self.contador = 0
                            ////
                            self.read1(string: "predicado tus muertos")
                            
                            mensajeCut = String(mensaje.dropFirst(self.contador))
                                //
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
                            default:
                                self.read2(string: self.numberToText(int: 1))
                                
                            }
                    }
                }
            }
            
        
        @IBAction func muteButton(_ sender: Any) {

         
             do {
                                muteButton.isHidden = true
                                recordButton.isHidden = false
                                try startRecording()
                                audioEngine.prepare()
                                try audioEngine.start()
                                self.recordButton.isEnabled = true

            //                    recordButton.backgroundColor = UIColor(patternImage: mic)
                                
            //                    self.recordButton.setTitle("Grabando", for: [])
                            }
                            catch {
                                self.recordButton.setTitle("Grabación no disponible", for: [])
                            }

            
        }
        
        @IBAction func recordButton(_ sender: Any) {
                
    //
    //            if audioEngine.isRunning {
    //
    //                audioEngine.stop()
    //                recognitionRequest?.endAudio()
    //                recordButton.isHidden = false
    //                muteButton.isHidden = true
    ////                self.recordButton.setTitle("Desactivado", for: .disabled)
    //
    //
    //            } else {
                   audioEngine.stop()
                   recognitionRequest?.endAudio()
                   self.muteButton.isEnabled = true

                   recordButton.isHidden = true
                   muteButton.isHidden = false
                        
                        
            }
        
        
        
            //        if #available(iOS 13, *) {
            //            recognitionRequest.requiresOnDeviceRecognition = false
            //        }

            
            func textToNumber (string: String)->Int{
                
                
                print("------------ yo digo: " ,string , " --------------------")
                if string == "" { return -2 }
                
                
                if  !speechSynthesizer.isSpeaking {
                    // TODO respuesta visual de lectura
                    print("He acabado de leer")
                } else {
                    
                }
                
                
                if string.contains(asistente+"empieza") || string.contains(asistente+"desde el principio") {
                    contPaso = 1
                    return contPaso
                }
                if string.contains(asistente + "siguiente") || string.contains(asistente + "continúa") || string.contains(asistente + "next uan") {
                    contPaso += 1
                    return contPaso
                }
                if string.contains(asistente + "repite") || string.contains(asistente + "repit") {
                    return contPaso
                }
                if string.contains(asistente + "anterior"){
                    contPaso -= 1
                    return contPaso
                }
                
                
                
                
                if string.contains(asistente + "detente") || string.contains(asistente + "calla") || string.contains(asistente+"fin") || string.contains(asistente+"no es no") || string.contains(asistente+"para") || string.contains(asistente+"stop") {
                    contPaso = 0
                    return contPaso
                }
                
                if string.contains(asistente + "paso uno") || string.contains(asistente+"paso 1") || string.contains(asistente + "uno") || string.contains(asistente+"lee el primer paso") || string.contains(asistente+"primer paso") {
                    contPaso = 1
                    return contPaso
                }
                
                if string.contains(asistente + "paso dos") || string.contains(asistente + "paso 2") || string.contains(asistente + "segundo paso") || string.contains(asistente + "lee el segundp paso") || string.contains(asistente + "lee el segundo"){
                    contPaso = 2
                    return contPaso
                }
                
                if string.contains(asistente + "paso tres") || string.contains(asistente + "step free") || string.contains(asistente + "usted free") || string.contains(asistente + "paso 3") || string.contains(asistente + "lee el tercer paso") || string.contains(asistente + "tercer paso") {
                    contPaso = 3
                    return contPaso
                }
                    
                if string.contains("paso cuatro") || string.contains(asistente + "paso cuatro") || string.contains(asistente + "lee el paso cuatro") || string.contains(asistente + "cuarto paso")  {
                    contPaso = 4
                    return contPaso
                }
                
                if string.contains(asistente + "paso cinco") || string.contains(asistente + "paso 5") || string.contains(asistente + "lee el quinto paso") || string.contains(asistente + "quinto paso") {
                    contPaso = 5
                    return contPaso
                }
                
                if string.contains(asistente + "paso seis") || string.contains(asistente + "paso 6") || string.contains(asistente + "lee el sexto paso") || string.contains(asistente + "sexto paso") {
                    contPaso = 6
                    return contPaso
                }
                
                if string.contains(asistente + "paso siete") || string.contains(asistente + "paso 7") || string.contains(asistente + "lee el séptimo paso") || string.contains(asistente + "séptimo paso") {
                    contPaso = 7
                    return contPaso
                }
                
                if string.contains(asistente + "baila") || string.contains(asistente + "paso 8") || string.contains(asistente + "lee el octavo paso") || string.contains(asistente + "octavo paso") {
                    contPaso = 8
                    return contPaso
                }
                
                if string.contains(asistente + "viva españa") || string.contains(asistente + "paso 9") || string.contains(asistente + "lee el noveno paso") || string.contains(asistente + "noveno paso") {
                    contPaso = 9
                    return contPaso
                }
                
                if string.contains(asistente + "sintagma verbal predicado") || string.contains(asistente + "paso 10") || string.contains(asistente + "lee el décimo paso") || string.contains(asistente + "décimo paso") {
                    contPaso = 10
                    return contPaso
                }
                
                if string.contains(asistente + "paso once") || string.contains(asistente + "paso 11") || string.contains(asistente + "lee el onceavo paso") || string.contains(asistente + "onceavo paso") {
                    contPaso = 11
                    return contPaso
                }
                
                if string.contains(asistente + "paso doce") || string.contains(asistente + "paso 12") || string.contains(asistente + "lee el doceavo paso") || string.contains(asistente + "doceavo paso") {
                    contPaso = 12
                    return contPaso
                }
                
                if string.contains(asistente + "paso diez") || string.contains(asistente + "paso 10") || string.contains(asistente + "lee el décimo paso") || string.contains(asistente + "décimo paso") {
                    contPaso = 10
                    return contPaso
                }
                return -2
            }
        
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getRecipe() {
        
        let url = URL(string: INIURL + "show_recipe")
        
        
        
        let header = ["Authentication": Token]
        
        
        let json = ["recipe_id": idRecipe]
        
        
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON{ (response) in
            
            
            
            if (response.response!.statusCode == 200) {
                
                print(response.value!)
                
                var receta = response.result.value as! [String: AnyObject]
                
//                self.pasos = receta["pasos"] as! [String]
                
                let arraypasos:Array<[String: Any]> = receta["pasos"]! as! Array<Any> as! Array<[String : Any]>
                
                
                
                for paso in arraypasos {
                    let instruccion = paso["instructions"]
                    let texto = "\(self.num) - " + (instruccion as! String)
                    self.pasos.append(texto)
                    
                    print("````````````````````````````````", self.pasos[(self.num-1)])
                    self.num += 1
                }
                print("ooooooooooooooooooooooooooooooooo",self.pasos)
                
                
//                self.arrayPasos = self.pasos!.count
                self.stepsTableView.reloadData()
                print("aaaa", self.arrayPasos)
//                self.arraySteps.append("Paso \(self.num). " + (instruccion as! String))
                
                
//                for paso in pasos {
//
//                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 360, height: 130))
//
//
//                    label.numberOfLines = 7
//                    label.textAlignment = .left
//
//                    let instruccion = paso["instructions"]
//
//                    label.text = "\(self.num) - " + (instruccion as! String)
//
//                    self.view.addSubview(label)
//
//                    self.largo = label.text?.count as! Int
//
//                    print("qqqqq ", label.text?.count as Any , String(self.position))
//
//
//
//
////                    self.position += 130
////                    label.center = CGPoint(x: 210, y: 130 + self.position)
//                    self.arraySteps.append("Paso \(self.num). " + (instruccion as! String))
//
//                    self.num += 1
//                }
            
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
}
}

