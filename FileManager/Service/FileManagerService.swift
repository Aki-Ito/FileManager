//
//  FileManagerService.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2023/12/07.
//

import Foundation
class FileManagerService{
    static let shared = FileManagerService()
    let fileManager = FileManager.default
    
    public func createFolder(){
        guard let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("error: no directory")
            return
        }
        
        let myAppDirectory = docDirectory.appending(path: "MyAppContents")
        do{
            try fileManager.createDirectory(atPath: myAppDirectory.absoluteString, withIntermediateDirectories: true)
        }catch{
            print("Failed Creating Folder: \(error.localizedDescription)")
        }
    }
    
    public func saveFile(file: Data, fileName: String){
        guard let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("error: no directory")
            return
        }
        
        let myAppDirectory = docDirectory.appending(path: "MyAppContents")
        let fullPath = myAppDirectory.appending(path: fileName)
        do{
            try file.write(to: fullPath)
        }catch{
            print("error: no directory")
        }
    }
    
    public func readFile(fileName: String) -> Data?{
        guard let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("error: no directory")
            return nil
        }
        
        let myAppDirectory = docDirectory.appending(path: "MyAppContents")
        let fullPath = myAppDirectory.appending(path: fileName)
        
        do{
            let fileContents = try Data(contentsOf: fullPath)
            return fileContents
        }catch{
            print("error: \(error.localizedDescription)")
        }
        return nil
    }
}
