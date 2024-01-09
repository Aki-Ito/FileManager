//
//  VideoListViewController.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2024/01/07.
//

import UIKit
import SwiftData

@available(iOS 17, *)
class VideoListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let fileManagerService = FileManagerService.shared
    public var videos = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        self.fetchData()
    }
    
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "videoCell")
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    
    private func fetchData(){
        SwiftDataService.shared.fetchVideo { data, error in
            if let error{
                print(error)
            }
            
            if let data{
                self.videos = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    private func convertToImage(path: String) -> UIImage?{
        let data = fileManagerService.readFile(fileName: path)
        if let data{
            return UIImage(data: data)
        }else{
            return nil
        }
    }
    
}

@available(iOS 17, *)
extension VideoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCollectionViewCell
        cell.label.text = videos[indexPath.row].title
        let image = convertToImage(path: videos[indexPath.row].title)
        if let image{
            cell.imageView.image = image
        }
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 40
        let cellSize : CGFloat = self.view.bounds.width - horizontalSpace
        return CGSize(width: cellSize, height: cellSize/3)
    }
    
    
}
