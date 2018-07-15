import UIKit

class CropCreateVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var btnNumberOfRooms: UIButton!
    @IBOutlet weak var cropNameField: UITextField!
    
    @IBOutlet weak var createCrop: UIButton!
    
    
    var isTableVisible = false
    var mainLib = lib.getMainLibrary()
    var profName = ""
    var cropSelected = false
    var libIndex = 0
    var gardenIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cropSelected = false
        cropNameField?.delegate = self
        createCrop?.isUserInteractionEnabled = false
        createCrop?.alpha = 0.5
        tblDropDown.delegate = self
        tblDropDown.dataSource = self
        tblDropDownHC.constant = 0
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainLib.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "numberofcrops")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "numberofcrops")
        }
        cell?.textLabel?.text = mainLib[indexPath.row].getName()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        libIndex = indexPath.row
        btnNumberOfRooms.setTitle(mainLib[libIndex].getName(), for: .normal)
        btnNumberOfRooms.setBackgroundImage(UIImage(named: mainLib[libIndex].getImage()), for: .normal)
        cropSelected = true
        UIView.animate(withDuration: 0.5) {
            self.tblDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
        
    }

    @IBAction func selectNumberOfRooms(_ sender : AnyObject) {
        
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
             self.tblDropDownHC.constant = 44.0 * 3.0
            } else {
                self.tblDropDownHC.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        let text = (cropNameField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            if cropSelected{
                createCrop?.isUserInteractionEnabled = true
                createCrop?.isEnabled = true
                createCrop?.alpha = 1.0
            }
        } else {
            createCrop.isUserInteractionEnabled = false
            createCrop.isEnabled = false
            createCrop.alpha = 0.5
        }
        return true
    }
    
    
    
    @IBAction func AddCrop(_ sender: Any) {

        print("ADDING CROP");
        //print("{}",GardenList[gardenIndex]?.gardenName)
        //let cropIndex = GardenList[gardenIndex]?.getSize()
        
        profName = cropNameField.text!
        let newCropProf = CropProfile(cropInfo : mainLib[libIndex], cropName : profName)
        GardenList[gardenIndex]?.cropProfile.append(newCropProf)
        print("1Number of Crops = {}", GardenList[gardenIndex]!.getSize())
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as!GardenCropList
        profName = cropNameField.text!
        let newCropProf = CropProfile(cropInfo : mainLib[libIndex], cropName : profName)
        nextController.addCropProf(cropProf: newCropProf)
    }
*/
}
