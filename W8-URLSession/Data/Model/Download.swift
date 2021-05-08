//
//  Download.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 05/05/2021.
//

import Foundation

class Download: NSObject {
    var url: URL
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    
    init(url: URL) {
        self.url = url
    }
}
