//
//  LaunchViewController.swift
//  Demo
//
//  Created by Bernard Musaj on 10.04.21.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        startProgress()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func startProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {

            self.progressView.setProgress(1.0, animated: false)

            UIView.animate(withDuration: 1) { [unowned self] in
                self.progressView.layoutIfNeeded()
            } completion: {[unowned self] _ in
                self.performSegue(withIdentifier: "postList", sender: self)
            }
        }
    }
}
