//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 西尾純輝 on 2020/04/13.
//  Copyright © 2020 Junki Nishio. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //filterで対象を2文字以上にし、表示
        let observable = Observable.of("A","AB","ABC","B")
        
        _ = observable.filter{ 2 <= $0.count}
            .subscribe(onNext:{ print($0)})
        
        
        //subjectを使った処理
        let subject = PublishSubject<String>()
        
        subject.subscribe(onNext: {
            print("onNext:", $0)
        })
        
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        
        
        
        
        
    }
    
}

