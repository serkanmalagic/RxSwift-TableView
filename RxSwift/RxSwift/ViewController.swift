//
//  ViewController.swift
//  RxSwift
//
//  Created by Serkan Mehmet Malagiç on 14.09.2021.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addAction(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondVCSB") as? SecondViewController
//        vc?.selectedCharacter
//            .subscribe(onNext: { [weak self] character in
//                        self?.statusLabel.text = "Hello \(character)"
//                    }).disposed(by: disposeBag)
//
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

