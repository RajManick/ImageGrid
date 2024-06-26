//
//  ImageGridObservable.swift
//  ImageGrid
//
//  Created by Manick on 15/04/24.
//

import Foundation


final class ImageGridObservable<Value> {
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }

    private var observers = [Observer<Value>]()

    var value: Value {
        didSet { notifyObservers() }
    }

    init(_ value: Value) {
        self.value = value
    }

    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(value)
    }

    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            observer.block(value)
        }
    }
}
