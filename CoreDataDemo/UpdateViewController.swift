//
//  UpdateViewController.swift
//  CoreDataDemo
//
//  Created by MBA-0019 on 13/03/23.
//

import UIKit
import CoreData

protocol addupdatedelegate
{
    func addupdate(conn : [MyData])
}

class UpdateViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var UpdateImage: UIImageView!
    @IBOutlet weak var Updateaddress: UITextField!
    @IBOutlet weak var Updateage: UITextField!
    @IBOutlet weak var Updatename: UITextField!
    var index = Int()
    var Uname = String()
    var Uage = String()
    var Uaddress = String()
    var Uimage = UIImage()
    var updatedelegate : addupdatedelegate?
    var data = MyData()
    override func viewDidLoad() {
        super.viewDidLoad()
        Updatename.text = data.name
        Updateage.text = data.age
        Updateaddress.text = data.address
        UpdateImage.image = UIImage(data: data.image ?? Data())!
        UpdateImage.layer.cornerRadius = UpdateImage.frame.height/2
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func UpdateData(_ sender: Any) {
        
        _ = UpdateImage.image?.jpegData(compressionQuality: 0.75)
        let png = UpdateImage.image?.pngData()
        
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appdelegate.persistentContainer.viewContext
       
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MyData")
        do
        {
            let dataset = try managedContext.fetch(fetchRequest) as! [MyData]
            dataset[index].name = Updatename.text
            dataset[index].age = Updateage.text
            dataset[index].address = Updateaddress.text
            dataset[index].image = png
            
            try managedContext.save()
            updatedelegate?.addupdate(conn: dataset)
            navigationController?.popViewController(animated: true)
            
        }
        catch
        {
            print("Error in Update")
        }
        
    }
    @IBAction func UpdateChooseImage(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        {
            UpdateImage.image = image
        }
            
        picker.dismiss(animated: true)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
