//
//  CircularProgressAvailableTap.swift
//  StepEnglish2
//
//  Created by Steve on 2016. 5. 28..
//  Copyright © 2016년 H1D2 Studio. All rights reserved.
//

import Foundation

class CircularProgressWithFinishBlock : DACircularProgressView {
    private var finishBlock : (()->())? = nil

    func setProgress(progress: CGFloat, animated: Bool, initialDelay: CFTimeInterval, withDuration duration: CFTimeInterval, finish: ()->()) {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(CircularProgressWithFinishBlock._didFinish), object: nil)
        self.finishBlock = finish
        super.setProgress(progress, animated: animated, initialDelay: initialDelay, withDuration: duration)
        performSelector(#selector(CircularProgressWithFinishBlock._didFinish), withObject: nil, afterDelay: duration)
    }
    
    func stopWithoutCallingFinishBlock() {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(CircularProgressWithFinishBlock._didFinish), object: nil)
        super.setProgress(0, animated: false, initialDelay: 0, withDuration: 0)
    }
    
    private func stopWithoutCallingFinishBlock_noResetProgress() {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(CircularProgressWithFinishBlock._didFinish), object: nil)
    }

    func stopWithCallingFinishBlock() {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(CircularProgressWithFinishBlock._didFinish), object: nil)
        super.setProgress(0, animated: false, initialDelay: 0, withDuration: 0)
        _didFinish()
    }

    func _didFinish() {
        if let block = finishBlock {
            block()
        }
    }
}







