//
//  ViewController.swift
//  MoyaDemo
//
//  Created by Ahmed Fekry on 08/09/2023.
//

import UIKit
import RxSwift
class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!
    var usersArr: [User] = []
    var albumsArr: [Albums] = []
    var currentUser: User?
    var albumsViewModel: AlbumsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsViewModel = AlbumsViewModel()
        
        albumsViewModel?.getData()
        
        albumsViewModel?.ObservableAlbums.subscribe(onNext: { [weak self] albums in
            self?.albumsArr = albums
            self?.usersArr = self?.albumsViewModel!.usersArr ?? []
            self?.currentUser = self?.albumsViewModel?.currentUser
            self?.userNameLabel.text = self?.currentUser?.name
            self?.albumsTableView.reloadData()
            
            if let adress = self?.currentUser?.address{
                self?.userAddressLabel.text = "\(adress.street), \(adress.suite), \(adress.city), \(adress.zipcode)"
            }
            
        }).disposed(by: albumsViewModel!.disposeBag)
        
//        albumsViewModel?.bindingData = { [self] in
//            albumsArr = albumsViewModel!.ObservableAlbums!
//            usersArr = albumsViewModel!.usersArr
//            currentUser = albumsViewModel?.currentUser
//            DispatchQueue.main.async {
//                self.userNameLabel.text = self.currentUser?.name
//                if let adress = self.currentUser?.address{
//                    self.userAddressLabel.text = "\(adress.street), \(adress.suite), \(adress.city), \(adress.zipcode)"
//                }
//                self.albumsTableView.reloadData()
//            }
//
//        }
        
    }
    
    
    
    
}

extension ViewController : UITableViewDataSource , UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "AlbumsTableViewCell", for: indexPath) as? AlbumsTableViewCell)!
        
        cell.albumNameLabel.text = albumsArr[indexPath.row].title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let photosVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        photosVC.albumName = self.albumsArr[indexPath.row].title
        photosVC.albumeId = self.albumsArr[indexPath.row].id
        self.navigationController?.pushViewController(photosVC, animated: true)
        
    }
    
    
    
    
    
}


