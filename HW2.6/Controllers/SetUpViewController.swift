import UIKit

class SetUpViewController: UIViewController {
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redInputField: UITextField!
    @IBOutlet weak var greenInputField: UITextField!
    @IBOutlet weak var blueInputField: UITextField!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet var stackLabel: [UILabel]!
    @IBOutlet var stackInput: [UITextField]!
    @IBOutlet var stackSlider: [UISlider]!
    
    enum stackType {
        case sliders, labels
    }
    
    var delegate: screenColorDelegate!
    var redValue: CGFloat = 0, greenValue: CGFloat = 0, blueValue: CGFloat = 0, alphaValue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        resultView.layer.cornerRadius = 15
        resultView.backgroundColor = UIColor(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        showValues(for: stackType.sliders)
        
        // добавляем кнопку Done в клавиатуру и делегатов текстовых полей
        addDoneButton()
        redInputField.delegate = self
        greenInputField.delegate = self
        blueInputField.delegate = self
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        switch sender.tag {
        case 0: redValue = CGFloat(redSlider.value)
        case 1: greenValue = CGFloat(greenSlider.value)
        case 2: blueValue = CGFloat(blueSlider.value)
        default: break
        }
        // вызов функций смены цвета view и значений лейблов
        changeColorView()
        showValues(for: stackType.labels)
    }
    
    // функция отображения значений в лейблах и положения слайдера
    private func showValues(for field: stackType) {
        switch field {
        case .sliders:
            redSlider.setValue(Float(redValue), animated: true)
            greenSlider.setValue(Float(greenValue), animated: true)
            blueSlider.setValue(Float(blueValue), animated: true)
            fallthrough
        case .labels:
            for each in 0...2 {
                stackLabel[each].text = String(format: "%.2f", stackSlider[each].value)
                stackInput[each].text = String(format: "%.2f",stackSlider[each].value)
            }
        }
    }
    
    // функция отображения нового цвета
    private func changeColorView() {
        resultView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }
    
    @IBAction func donePressed() {
        delegate.updateScreen(resultView.backgroundColor!)
        dismiss(animated: true)
    }
}

extension SetUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = Float(textField.text!) else {return}
        switch textField.tag {
        case 0: redValue = CGFloat(newValue)
        case 1: greenValue = CGFloat(newValue)
        case 2: blueValue = CGFloat(newValue)
        default: break
        }
        showValues(for: stackType.sliders)
        changeColorView()
    }
    
    // функция добавления кнопки done в клавиатуру
    private func addDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        toolBar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))]
        redInputField.inputAccessoryView = toolBar
        greenInputField.inputAccessoryView = toolBar
        blueInputField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction()
    {
        view.endEditing(true)
    }
}

