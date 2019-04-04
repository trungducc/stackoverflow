//
//  ViewController.swift
//  MovpkgToMp4
//
//  Created by coccoc on 4/4/19.
//  Copyright © 2019 trungduc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: Properties

    /// The AVAssetDownloadURLSession to use for managing AVAssetDownloadTasks.
    private var assetDownloadURLSession: AVAssetDownloadURLSession?

    /// The download task used to download hls file
    private var downloadTask: AVAssetDownloadTask?

    // Movpkg file location after downloaded
    private var destinationUrl: URL?

    // Progress view used to present download progress
    @IBOutlet weak var progressView: UIProgressView!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        startDownloadTask()
    }

    // MARK: Private

    private func startDownloadTask() {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "MovpkgToMp4-Identifier")
        assetDownloadURLSession = AVAssetDownloadURLSession(configuration: backgroundConfiguration, assetDownloadDelegate: self, delegateQueue: OperationQueue.main)

        guard let url = URL(string: "http://cdnapi.kaltura.com/p/1878761/sp/187876100/playManifest/entryId/1_usagz19w/flavorIds/1_5spqkazq,1_nslowvhp,1_boih5aji,1_qahc37ag/format/applehttp/protocol/http/a.m3u8") else {
            fatalError("URL Error")
        }
        let urlAsset = AVURLAsset(url: url)

        downloadTask = assetDownloadURLSession?.makeAssetDownloadTask(asset: urlAsset, assetTitle: "master", assetArtworkData: nil, options: nil)
        downloadTask?.resume()
    }
}

extension ViewController: AVAssetDownloadDelegate {
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

    func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, didFinishDownloadingTo location: URL) {
        destinationUrl = location
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error as NSError? {
            switch (error.domain, error.code) {
            case (NSURLErrorDomain, NSURLErrorCancelled):
                fatalError("File is existed. Please try to remove the app and run again.")

            case (NSURLErrorDomain, NSURLErrorUnknown):
                fatalError("Downloading HLS streams is not supported in the simulator.")

            default:
                fatalError("An unexpected error occured \(error.domain)")
            }
        }

        guard let destinationUrl = destinationUrl else {
            fatalError("Can't find location for movpkg file")
        }

        let movpkgAsset = AVAsset(url: destinationUrl)
        print("Movpkg file is downloaded at \(destinationUrl.path)")
        print("Video duration: \(movpkgAsset.duration.seconds) seconds")

        fatalError("Movpkg file is downloaded. Please help to convert |movpkgAsset| to mp4 file. Thanks!")
    }
}

