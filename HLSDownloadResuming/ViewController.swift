//
//  ViewController.swift
//  HLSDownloadResuming
//
//  Created by trungducc on 4/24/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!

    @IBOutlet weak var button: UIButton!

    var assetDownloadURLSession: AVAssetDownloadURLSession!

    var downloadTask: AVAssetDownloadTask!

    var destinationURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        createDownloadSession()
    }

    func createDownloadSession() {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "HLSDownloadResuming")
        assetDownloadURLSession = AVAssetDownloadURLSession(configuration: backgroundConfiguration, assetDownloadDelegate: self, delegateQueue: OperationQueue.main)
    }

    func restoreDownloadTask() {
        let url = (destinationURL != nil) ? destinationURL! : URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8")!
        let urlAsset = AVURLAsset(url: url)
        downloadTask = assetDownloadURLSession.makeAssetDownloadTask(asset: urlAsset, assetTitle: "master", assetArtworkData: nil, options: nil)
    }

    func resume() {
        downloadTask.resume()
        button.setTitle("Pause", for: .normal)
    }

    func cancel() {
        downloadTask.cancel()
        button.setTitle("Resume", for: .normal)
    }

    @IBAction func buttonDidTouch(_ sender: Any) {
        if downloadTask != nil, downloadTask.state == .running {
            cancel()
        } else {
            restoreDownloadTask()
            resume()
        }
    }
}

extension ViewController: AVAssetDownloadDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard error != nil else {
            return // Download task is completed
        }
        // Download task is cancelled or something goes wrong, create new download task from current the partially downloaded file to resume
        button.setTitle("Resume", for: .normal)
    }

    func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didFinishDownloadingTo location: URL) {
        destinationURL = location
    }

    func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didLoad timeRange: CMTimeRange, totalTimeRangesLoaded loadedTimeRanges: [NSValue], timeRangeExpectedToLoad: CMTimeRange) {
        var percentageComplete = 0.0
        // Iterate over loaded time ranges
        for value in loadedTimeRanges {
            // Unpack CMTimeRange value
            let loadedTimeRange = value.timeRangeValue
            percentageComplete += loadedTimeRange.duration.seconds / timeRangeExpectedToLoad.duration.seconds
        }
        progressView.setProgress(Float(percentageComplete), animated: true)
    }
}

