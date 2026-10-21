//
//  DanmakuQueuePool.swift
//  DanmakuKit
//
//  Created by Q YiZhong on 2020/8/16.
//

import Foundation

class DanmakuQueuePool {
    let name: String

    private var queues: [DispatchQueue] = []

    let queueCount: Int

    private var counter: Int = 0

    init(name: String, queueCount: Int, qos: DispatchQoS) {
        self.name = name
        self.queueCount = queueCount
        for _ in 0..<queueCount {
            let queue = DispatchQueue(label: name, qos: qos, attributes: [], autoreleaseFrequency: .inherit, target: nil)
            queues.append(queue)
        }
    }

    var queue: DispatchQueue {
        return getQueue()
    }

    private func getQueue() -> DispatchQueue {
        if counter == Int.max {
            counter = 0
        }
        let queue = queues[counter % queueCount]
        counter += 1
        return queue
    }
}
