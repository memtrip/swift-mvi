import AVKit
import AVFoundation
import MediaPlayer

final class SoundPlayer : NSObject {
    
    static let shared = SoundPlayer()

    var player: AVPlayer?
    var isPlaying = false
    
    func play(url: String) {
        if (!isPlaying) {
            if player != nil {
                player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: url)!))
            } else {
                player = AVPlayer(playerItem: AVPlayerItem(url: URL(string: url)!))
            }
            
            if let player = self.player {
                player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions(), context: nil)
                player.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: NSKeyValueObservingOptions(), context: nil)
                player.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: NSKeyValueObservingOptions(), context: nil)
                player.play()
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "rate" {
            audioReady()
        }
        
        if keyPath == "playbackLikelyToKeepUp" {
            audioReady()
        }
        
        if keyPath == "playbackBufferFull" {
            audioReady()
        }
    }
    
    private func audioReady() {
        if player?.rate == 0 {
            isPlaying = false
        } else {
            isPlaying = true
        }
    }
}
