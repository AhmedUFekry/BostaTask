//
//  AlbumsViewModel.swift
//  PhotosApp
//
//  Created by Ahmed Fekry on 09/09/2023.
//

import Foundation
import Moya
import RxSwift

protocol getAlbums {
    func getData()
}

class AlbumsViewModel : getAlbums{
  
    let disposeBag = DisposeBag()
    var usersArr : [User] = []
    var currentUser : User?
   // var albumsArr : [Albums] = []
    var bindingData:(()->())?
    
//    var ObservableAlbums: [Albums]? {
//        didSet {
//            bindingData!()
//        }
//    }
    
    var ObservableAlbums: PublishSubject<[Albums]> = .init()
    
    func getData() {
        
        let dataProvider = MoyaProvider<UserService>()
           //getting users
        
        dataProvider.request(.readUser) { result in
            switch result {
            case .success(let response):
                let users = try! JSONDecoder().decode([User].self, from: response.data)
                self.usersArr = users
                self.currentUser = self.usersArr.randomElement()
                //getting user albums
                
                    dataProvider.request(.readalbum(userId: (((self.currentUser?.id)!)))) { result in
                        switch result {
                            
                        case .success(let response):
                            
                            do{
                                let albums = try JSONDecoder().decode([Albums].self, from: response.data)
                                self.ObservableAlbums.onNext(albums)
                               // self.albumsTableView.reloadData()
                              
                            }catch let error{
                                print(error)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                
              //  self.albumsTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
                

        }
    }
    

