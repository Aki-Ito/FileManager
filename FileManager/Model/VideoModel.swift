//
//  VideoModel.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2024/01/06.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
final class VideoModel{
    @Attribute(.unique) var id: String
    var videoPath: String
    var title: String
    var memo: String
    var createdAt: Date
    
    init(id: String, videoPath: String, title: String, createdAt: Date, memo: String) {
        self.id = id
        self.videoPath = videoPath
        self.title = title
        self.createdAt = createdAt
        self.memo = memo
    }
}
