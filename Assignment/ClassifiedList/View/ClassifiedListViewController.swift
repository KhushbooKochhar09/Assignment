import Foundation
import UIKit
import SDWebImage
import Toast_Swift

struct ActivityIndicator {
    static var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
}

class ClassifiedListViewController: UIViewController {
    var presenter: ClassifiedListPresenterProtocol?
    var classifiedList: [Product]?
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.fetchClassifiedList()
    }
    
    // MARK: UI Update
    func setup() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = LocalizationConstant.listVCTitle
        view.backgroundColor = .white
        view.addSubview(listTableView)
        listTableView.backgroundColor = .white
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.allowsMultipleSelection = true
        listTableView.isUserInteractionEnabled = true
        listTableView.accessibilityIdentifier = Constant.tableAccessibilityIdentifier
        listTableView.tableFooterView = UIView()
    }
    
}

extension ClassifiedListViewController: ClassifiedListViewProtocol {
    func hideLoading() {
        ActivityIndicator.activityIndicator.stopAnimating()
    }
    
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.messageColor = UIColor.white
            style.backgroundColor = Constant.appToastMessageBackgroundColor
            self.view.makeToast(errorMessage, duration: 2.0, position: .top, style: style)
        }
    }
    
    func showNoDataLabel() {
        let noDataLabel: UILabel = UILabel(frame: self.listTableView.bounds)
        noDataLabel.text = LocalizationConstant.noClassifieds
        noDataLabel.textAlignment = .center
        noDataLabel.sizeToFit()
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.listTableView.backgroundView = noDataLabel
        }
        listTableView.reloadData()
    }
    
    func showProducts(with classified: [Product]) {
        listTableView.backgroundView = nil
        classifiedList = classified
        classifiedList?.isEmpty ?? true ? self.showNoDataLabel() : nil
        listTableView.reloadData()
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.activityIndicator.color = UIColor.gray
            if !self.view.subviews.contains(ActivityIndicator.activityIndicator) {
                self.view.addSubview(ActivityIndicator.activityIndicator)
                ActivityIndicator.activityIndicator.center = self.view.center
            }
            ActivityIndicator.activityIndicator.startAnimating()
        }
    }
    
}

extension ClassifiedListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.listCell) as! ClassifiedTableViewCell
        cell.backgroundColor = .clear
        if let classifiedList = self.classifiedList {
            let product = classifiedList[indexPath.row]
            cell.nameLabel.text = product.name
            cell.priceLabel.text = product.price
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classifiedList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ClassifiedTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = self.classifiedList else {return}
        _ = presenter?.showClassifiedDetail(product: list[indexPath.row])
    }
    
}

class ClassifiedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
}

extension ClassifiedListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classifiedList?[collectionView.tag].imageThumbnailURL.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.imageCell, for: indexPath) as! ClassifiedCollectionViewCell
        let imgURL = URL(string: classifiedList?[collectionView.tag].imageThumbnailURL[indexPath.item] ?? "")
        cell.productImageView.sd_setImage(with: imgURL, placeholderImage: nil, options: [], progress: nil, completed: nil)
        return cell
    }
    
}

extension ClassifiedListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
}
