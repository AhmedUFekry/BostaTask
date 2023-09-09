//
//  PhotosViewModel.swift
//  PhotosApp
//
//  Created by Ahmed Fekry on 09/09/2023.
//

import Foundation
import Moya
import RxSwift
protocol getPhotos {
    func getPhotos(albumId : Int)
}

class PhotosViewModel : getPhotos{
  
  let disposeBag = DisposeBag()
  
    var bindingPhotos:(()->())?
    
//    var ObservablePhotos: [Photos]? {
//        didSet {
//            bindingPhotos!()
//        }
//    }
    
    var ObservablePhotos: PublishSubject<[Photos]> = .init()

    
    func getPhotos(albumId : Int) {
        
        let dataProvider = MoyaProvider<UserService>()
           //getting photos
        dataProvider.request(.readpicture(albumId: albumId)) { result in
            switch result {
                
            case .success(let response):
                
                do{
                    let photos = try JSONDecoder().decode([Photos].self, from: response.data)
                    dump(photos)
                    self.ObservablePhotos.onNext(photos)
                   // self.photosCollectionView.reloadData()
                   
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
       
        }
    }
