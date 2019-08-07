//
//  RxSwiftVC.swift
//  SwiftPods
//
//  Created by Jion on 2017/7/25.
//  Copyright © 2017年 天天. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class RxSwiftVC: UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        //用户名是否有效
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map{ str -> Bool in
                print("str:",str)
                return str.count >= minimalUsernameLength
                
            }
            .share(replay: 1)
        _ = usernameValid.subscribe(onNext: { (valid) in
            
            if valid{
                let index = self.usernameOutlet.text!.index(self.usernameOutlet!.text!.startIndex, offsetBy:minimalUsernameLength)
                
                self.usernameOutlet.text = String(self.usernameOutlet!.text![..<index])
            }
        })
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength }
            .share(replay:1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid){ $0 && $1 }
            .share(replay:1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe({ [weak self] _ in  self?.showAlert() })
            .disposed(by: disposeBag)
        
        example()
    }

    func example() {
        let observable = Observable.of("A","B","C")
        observable.do(onNext: { (el) in
            print("Intercepted Next：", el)
        }, onError: { (error) in
            print("Intercepted Error：", error)
        }, onCompleted: {
            print("Intercepted Completed")
        }, onSubscribe: {
            print("Intercepted Subscribe")
        }, onSubscribed: {
            print("Intercepted Subscribed")
        }, onDispose: {
            print("Intercepted onDispose")
        }).subscribe(onNext: { (element) in
            print(element)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("oncomp")
        }, onDisposed: {
            print("disposed")
        }).dispose()
        //当文本框内容改变时，将内容输出到控制台上
        usernameOutlet.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
        
    }
    
    func showAlert() {
        let alertView = UIAlertView(title: "RxExample", message: "This is wonderful", delegate: nil, cancelButtonTitle: "OK")
        
        alertView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
