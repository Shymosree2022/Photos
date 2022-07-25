//
// ViewController.swift
// Photos
//
//

import UIKit

class ViewController: UIViewController {
    var viewModel = PhotoViewModel()
    var page: Int = 1
    let totalPage : Int = 10
    var isPageRefreshing:Bool = false
    let loading = UIActivityIndicatorView()
    @IBOutlet weak var photoCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoCollection.delegate = self
        self.photoCollection.dataSource = self
        self.photoCollection.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.photoCollection.register(UINib(nibName: "ActivityIndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityIndicatorCollectionViewCell")
        self.viewModel.fetchData(param: "page=\(page)&per_page=15")
        bindViewModel()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        viewModel.photoListBinding = { [weak self] (_, success) in
            DispatchQueue.main.async {
                self?.photoCollection?.reloadData()
            }
        }
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

extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photoList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (page < totalPage) && indexPath.row == self.viewModel.photoList.count - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityIndicatorCollectionViewCell", for: indexPath) as! ActivityIndicatorCollectionViewCell
            cell.loader.startAnimating()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PhotoCollectionViewCell
            //let imgUrl = URL(string: self.viewModel.movieList[indexPath.item].urls.small)
            if let url = URL(string: self.viewModel.photoList[indexPath.item].urls.smallS3) {
                cell.photoImage.loadImageWithUrl(url)
            }
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.getSelectedPhoto(photoId: self.viewModel.photoList [indexPath.item].id,completion:{ [weak self] result in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.async {
                let modalViewController = weakSelf.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
                modalViewController.modalPresentationStyle = .overCurrentContext
                if let url = URL(string: result.urls.small) {
                    modalViewController.imgUrl = url
                }
                weakSelf.present(modalViewController, animated: true, completion: nil)
            }
            
        })
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("indexpath is \(indexPath)")
        if (page < totalPage) && indexPath.row == self.viewModel.photoList.count - 1{
            //loading.startAnimating()
            page = page + 1
            print("page loading \(page)")
            self.viewModel.fetchData(param: "page=\(page)&per_page=15")
            // Call API here
        } else {
            //loading.stopAnimating()
        }
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 5, right:0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}

