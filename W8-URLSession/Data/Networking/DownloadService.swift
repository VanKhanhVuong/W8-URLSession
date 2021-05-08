//
//  DownloadService.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 05/05/2021.
//

import Foundation

class DownloadService: NSObject {
    var activeDownloads: [URL: Download] = [:]
    
    lazy var downloadsSession: URLSession = {
      let configuration = URLSessionConfiguration.default
      return URLSession(configuration: configuration,
                        delegate: self,
                        delegateQueue: nil)
    }()
}

extension DownloadService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        print("Finished downloading to \(location).")
    }
}
