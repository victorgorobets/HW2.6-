import UIKit

protocol screenColorDelegate {
    func updateScreen(_ value: UIColor)
}

class PrimeViewController: UIViewController, screenColorDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setUpVC = segue.destination as! SetUpViewController
        setUpVC.delegate = self
        view.backgroundColor?.getRed(&setUpVC.redValue, green: &setUpVC.greenValue, blue: &setUpVC.blueValue, alpha: &setUpVC.alphaValue)
    }

    func updateScreen(_ value: UIColor) {
    view.backgroundColor = value
       }
}


