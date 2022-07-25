//
// PhotoViewController.swift
// Photos
//
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var detailPhoto: ImageLoader!
    @IBOutlet weak var shareBtn: UIButton!
    var imgUrl : URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.shareBtn.setBackgroundColor(color: .blue, forState: .normal)
        self.shareBtn.setTitle("Share", for:.normal)
        self.detailPhoto.contentMode = .scaleToFill
        self.detailPhoto.loadImageWithUrl(imgUrl)
    }

    @IBAction func shareOnFacebook(_ sender: UIButton)
    {
        let item = self.detailPhoto.image
        let activityViewController = UIActivityViewController(activityItems: [item!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            // Here: exclude all ActivityType except postToFacebook ...
        ]

        present(activityViewController, animated: true)
    }
    
    @IBAction func dismissView(_ sender: UIButton){
        self.dismiss(animated: true)
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
