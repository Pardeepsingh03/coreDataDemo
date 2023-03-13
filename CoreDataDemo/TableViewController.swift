//
//  TableViewController.swift
//  CoreDataDemo
//
//  Created by MBA-0019 on 13/03/23.
//

import UIKit
import CoreData




class TableViewController: UITableViewController,addcontacts,addupdatedelegate {
    
    
    
    
    var data = [MyData]()
    @IBOutlet var DataTableView: UITableView!
    var firstresp = true
  var index1 = Int()
    
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyData")
        do
        {
            let result : NSArray = try managedContext.fetch(request) as NSArray
            for res in result
            {
                let note = res as! MyData
                data.append(note)
                
            }
        }
        catch
        {
            print("Error")
        }

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.name.text = data[indexPath.row].name
        cell.age.text = data[indexPath.row].age
        cell.address.text = data[indexPath.row].address
        cell.ShowImageView.layer.cornerRadius = 30
        
        let image = UIImage(data: data[indexPath.row].image ?? Data())
        cell.ShowImageView.image = image
       

        return cell
    }
    func addcontactsdata(condata: MyData) {
        data.append(condata)
        tableView.reloadData()
    }
    
    
    
    
    
           
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      
        if segue.destination is ViewController
        {
          let destination = segue.destination as! ViewController
            destination.addcontactsdelegates = self
          
        }
        else if segue.destination is UpdateViewController
        {
            let des = segue.destination as! UpdateViewController
            des.updatedelegate = self
        }
        
       
           
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index1 = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Vc = storyboard.instantiateViewController(withIdentifier: "goto") as! UpdateViewController
        
        Vc.index = indexPath.row
        
        Vc.data = data[indexPath.row]
        Vc.updatedelegate = self
        self.navigationController?.pushViewController(Vc, animated: true)
    }
  
    
    func addupdate(conn: [MyData]) {
        data[index1] = conn[index1]
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            tableView.beginUpdates()
           
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appdelegate.persistentContainer.viewContext
            managedContext.delete(data[indexPath.row])
            data.remove(at: indexPath.row)
            do{
               try managedContext.save()
            }
            catch
            {
                print("Error in deleting")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
            
            tableView.endUpdates()
        }
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
