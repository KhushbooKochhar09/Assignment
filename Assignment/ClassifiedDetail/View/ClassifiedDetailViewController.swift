import UIKit
import SDWebImage

class ClassifiedDetailViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var presenter: ClassifiedDetailPresenterProtocol?
    var classifiedImages: [String]?
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizationConstant.detailVCTitle
        //collectionView.register(ClassifiedDetailCollectionViewCell.self, forCellWithReuseIdentifier: Constant.CellIdentifier.imageDetailCell)
        presenter?.showClassifiedDetail()
    }
}

extension ClassifiedDetailViewController: ClassifiedDetailViewProtocol {
    
     func showClassifiedDetail(for classified: Product) {
        nameLabel.text = classified.name
        priceLabel.text = classified.price
        classifiedImages = classified.imageURL
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
     }
}

extension ClassifiedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classifiedImages?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.imageDetailCell, for: indexPath) as! ClassifiedDetailCollectionViewCell
        if let imgURL = URL(string: classifiedImages?[indexPath.item] ?? "") {
        cell.productDetailImageView.sd_setImage(with: imgURL, placeholderImage: nil, options: [], progress: nil, completed: nil)
        }
        return cell
    }
}

extension ClassifiedDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width)
    }
}

class ClassifiedDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productDetailImageView: UIImageView!
}
