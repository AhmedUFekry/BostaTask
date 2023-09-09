//
//  PhotosViewController.swift
//  PhotosApp
//
//  Created by Ahmed Fekry on 09/09/2023.
//

import UIKit
import Kingfisher
class PhotosViewController: UIViewController {
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    let searchController = UISearchController()
    var albumeId: Int?
    var albumName: String?
    var photosArr: [Photos]?
    var photoFilter: [Photos] = []
    var photoViewModel: PhotosViewModel?
    //var photos: Photos?
    var isSearchBarEmpty: Bool{
            return searchController.searchBar.text!.isEmpty
        }
    var isFiltering : Bool{
            return searchController.isActive && !isSearchBarEmpty
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        title = albumName
        photoViewModel = PhotosViewModel()
        photoViewModel?.bindingPhotos = { [self] in
            self.photosArr = photoViewModel?.ObservablePhotos
            DispatchQueue.main.async {
                 self.photosCollectionView.reloadData()
            }
            
        }
        photoViewModel?.getPhotos(albumId: albumeId!)
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhotosViewController: UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering{
            return photoFilter.count
        }else {
            return photosArr?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionViewCell", for: indexPath) as! photosCollectionViewCell
        if isFiltering{
            cell.photoImageView.kf.setImage(with: URL(string: photoFilter[indexPath.row].url ?? "no"),placeholder: UIImage(named: "no"))
        }else{
            cell.photoImageView.kf.setImage(with: URL(string: photosArr![indexPath.row].url ?? "no"),placeholder: UIImage(named: "no"))
        }
        return cell
    }
    
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 600, height: 600)
        }*/
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            
            return CGSize(width:self.view.frame.width*0.30, height: self.view.frame.height*0.10)

        }
    
    
    
    
}

//------------------for-------------search-----------------
extension PhotosViewController: UISearchResultsUpdating, UISearchBarDelegate{

    func makeSearchBar(){

            searchController.searchResultsUpdater = self
            searchController.searchBar.tintColor = .black
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search for Pictures"
            let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField

            textFieldInsideSearchBar?.textColor = .black
            navigationItem.searchController = searchController
            definesPresentationContext = false
                
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        photoFilter = (photosArr)!.filter({ filter in
                return filter.title!.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        photosCollectionView.reloadData()
    }

}
