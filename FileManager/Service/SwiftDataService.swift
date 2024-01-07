//
//  SwiftDataService.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2023/12/14.
//

import Foundation
import SwiftData

//MARK: CRUD OPERATION
@available(iOS 17, *)
class SwiftDataService{
    static let shared = SwiftDataService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init(){
        do{
            container = try ModelContainer(for: VideoModel.self)
            if let container{
                context = ModelContext(container)
            }
        }catch{
            
        }
    }
    
    func saveVideo(videoPath: String){
        if let context{
            let savedVideo = VideoModel(id: UUID().uuidString, videoPath: videoPath, title: "", createdAt: Date(), memo: "")
        }
    }
    
    func fetchVideo(onCompletion: @escaping([VideoModel]?, Error?) -> Void){
        let descriptor = FetchDescriptor<VideoModel>(sortBy: [SortDescriptor<VideoModel>(\.createdAt)])
        
        if let context{
            do{
                let data = try context.fetch(descriptor)
                onCompletion(data, nil)
            }catch{
                onCompletion(nil, error)
            }
        }
    }
    
    func updateVideo(videoModel: VideoModel, newTitle: String, newMemo: String){
        videoModel.title = newTitle
        videoModel.memo = newMemo
    }
    
    func deleteVideo(videoModel: VideoModel){
        if let context{
            context.delete(videoModel)
        }
    }
}
