//
//  LoginViewController.swift
//  ReactiveTutorial
//
//  Created by Serkan Mehmet Malagiç on 23.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.usernameTextPublishSubject).disposed(by: disposeBag)
        passwordTextfield.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)

        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map{$0 ? 1 : 0.1}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)

    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
     
}

class LoginViewModel {
    let usernameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(
            usernameTextPublishSubject.asObservable().startWith(""),
            passwordTextPublishSubject.asObservable().startWith(""))
            .map { username , password in
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }

}
