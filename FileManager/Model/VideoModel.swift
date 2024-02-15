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
    //MARK: Pathの最後の要素(lastPathComponent)のみを保存するようにする
    var videoPath: String
    //MARK: Pathの最後の要素(lastPathComponent)のみを保存するようにする
    var imagePath: String
    var title: String
    var memo: String
    var createdAt: Date
    
    init(id: String, videoPath: String, imagePath: String, title: String, createdAt: Date, memo: String) {
        self.id = id
        self.videoPath = videoPath
        self.imagePath = imagePath
        self.title = title
        self.createdAt = createdAt
        self.memo = memo
    }
}
