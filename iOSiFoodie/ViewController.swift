//
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
