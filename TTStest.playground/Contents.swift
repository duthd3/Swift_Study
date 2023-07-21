import AVFoundation

class TTSManager {
    var timer : Timer?
    static let shared = TTSManager()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    internal func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(fun), userInfo: nil, repeats: false)
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    @objc func fun() {
        print("hello")
    }
}

TTSManager.shared.play("안녕하세요")

