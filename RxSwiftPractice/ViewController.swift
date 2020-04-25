//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 西尾純輝 on 2020/04/13.
//  Copyright © 2020 Junki Nishio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController {

    //V
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var rxLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //filterで対象を2文字以上にし、表示
        let observable = Observable.of("A","AB","ABC","B")
        
        _ = observable.filter{ 2 <= $0.count}
            
            // AB,ABC
            .subscribe(onNext:{ print($0)})
        
            //配列要素ごとに出力
        _ = Observable.from([1,2,3,4,5,"a"])
            .subscribe(onNext:{ print($0)})
        
         //mapを使って各要素を変換して
        _ = Observable.from([1,2,3,4,5]).map {$0 * 2}
            .subscribe(onNext:{print($0)})
        
        //subjectを使った処理
        let subject = PublishSubject<String>()
        
        
        //subscribeの処理
        _ = subject.subscribe(onNext: {
            print("onNext:", $0)
        })
        
        //ストリームに流す
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        
        
        bindButton()
        bindCountToLabel()
        
    }
    
    //以下、ボタンを押すとラベルが＋１される処理
    
    //M
    private let countLabel: BehaviorRelay<Int> =
    BehaviorRelay(value: 0)
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    
    //ボタンが押されたらRelayに通知
    private func bindButton() {
        //VM
        rxButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.countLabel.accept(self!.countLabel.value + 1)}).disposed(by: disposeBag)
        
    }
    
    //通知後、ラベルに反映
    
    private func bindCountToLabel() {
        
        //VM
        countLabel.asObservable().map{String($0)}.bind(to: rxLabel.rx.text).disposed(by: disposeBag)
    }
}

