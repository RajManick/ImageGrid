//
//  ViewController.swift
//  ImageGrid
//
//  Created by Manick on 15/04/24.
//

import UIKit

class ImageGridViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var viewModel : ImageGridViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    func setupUI(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        myCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func bind(){
        viewModel = ImageGridViewModel.init(repository: ImageGridRepository())
        viewModel?.callGridListApi()
        viewModel?.reloadCollectionView.observe(on: self, observerBlock: { [weak self] value in
            if value {
                DispatchQueue.main.async{
                    self?.myCollectionView.reloadData()
                }
            }
        })
        viewModel?.handleError.observe(on: self, observerBlock: { error in
            if !error.isEmpty {
                DispatchQueue.main.async{
                    let alertController = UIAlertController(title: ImageGridConstants.appName, message: "\(ImageGridConstants.listApiErrorHeader) :: \(error)", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: ImageGridConstants.okTitle, style: .default) { _ in
                    }
                    
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
}

extension ImageGridViewController : UICollectionViewDelegate, UICollectionViewDataSource{


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getTotalNumberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageGridConstants.CellIdentifier.imageGridCollectionViewCell, for: indexPath) as! ImageGridCollectionViewCell
        if let url = URL(string: viewModel?.getCoverageImageURL(index: indexPath.item) ?? "") {
            cell.gridImageView.loadimage(url: url)
        }
        return cell
    }
}

extension ImageGridViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = (UIScreen.main.bounds.size.width / 3) - 3
        return CGSizeMake(ceil(screenWidth), ceil(screenWidth))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
