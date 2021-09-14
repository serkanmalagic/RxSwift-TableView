//
//  RxTableViewController.swift
//  ReactiveTutorial
//
//  Created by Serkan Mehmet Malagiç on 14.09.2021.
//

import UIKit
import RxSwift

struct Product {
    let imageName : String
    let title : String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItems(){
        let products = [
            Product(imageName: "house", title: "serkan1"),
            Product(imageName: "gear", title: "serkan2"),
            Product(imageName: "person.circle", title: "serkan3"),
            Product(imageName: "airplane", title: "serkan4"),
            Product(imageName: "bell", title: "serkan4")
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
}

class RxTableViewController: UIViewController {

    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
        
    }
    func bindTableData(){
    
        // Bind items to table
        viewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self )
        ){row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
            
        }.disposed(by: bag)
        
        //  Bind a model selected handler
        
        tableView.rx.modelSelected(Product.self).bind{ product in
            print(product.title, product.imageName)
        }.disposed(by: bag)
        
        // Fetch items
        viewModel.fetchItems()
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
