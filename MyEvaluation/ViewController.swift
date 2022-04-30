//
//  ViewController.swift
//  MyEvaluation
//
//  Created by الياسي on 30/04/2022.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var excellentLabel: UILabel!
    var excellent :Int?
    @IBOutlet weak var goodLabel: UILabel!
    var good:Int?
    @IBOutlet weak var weakLabel: UILabel!
    var weak:Int?
    var myevaluationData = [MyEvaluationData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Collectionmessage()
        // Do any additional setup after loading the view.
    }
    @IBAction func excellentButton(_ sender: Any) {
        excellent = ((excellent ?? 0) + 1)
        excellentLabel.text = "\(excellent ?? 0)"
         message(excellent ?? 0 ,good: good ?? 0 ,weak: weak ?? 0 )
    }
    
    @IBAction func goodButton(_ sender: Any) {
        good =  ((good   ?? 0) + 1)
        goodLabel.text = "\(good ?? 0)"
        message(excellent ?? 0 ,good: good ?? 0 ,weak: weak ?? 0 )
        Collectionmessage()
    }
    @IBAction func weakButton(_ sender: Any) {
        weak = ((weak  ?? 0) + 1)
        weakLabel.text = "\(weak ?? 0)"
        message(excellent ?? 0 ,good: good ?? 0 ,weak: weak ?? 0 )
        Collectionmessage()
    }
    func message(_ excellent:Int? ,good:Int?,weak:Int?) {
  
        let rootRef = Database.database().reference()
        let user1 = [ "excellent":excellent ?? 0   ,
                     "good":good ?? 0,
                     "weak":weak ??  0  ,
                     ] as [String : Any]

        rootRef.child("MyEvaluation").child("A").setValue(user1)


    }
    func Collectionmessage() {
       let  refDataBase =  Database.database().reference().child("MyEvaluation")

        refDataBase.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.myevaluationData.removeAll()
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    if let usersObject = item.value as? [String: AnyObject] {
                      
                    let excellent = usersObject["excellent"] as? Int
                    let good = usersObject["good"] as? Int
                    let weak = usersObject["weak"] as? Int
                    
                        let user = MyEvaluationData(excellent: excellent ?? 0 , good: good ?? 0, weak: weak ?? 0)

                       
                            self.myevaluationData.append(user)
                        
                        self.tableView.reloadData()
                      }}
                
             self.tableView.reloadData()
//                self.scrollToBottom()
            } else {
             // self.tableView.refreshControl?.endRefreshing()
            }

        }}
}

extension ViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myevaluationData.count
    }
 
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
      
        cell.myEvaluation(myevaluationData[indexPath.row])
        return cell
        }
       
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
//              //  vc.title = chatdata[indexPath.row].title
//
//        vc.name = chatdata[indexPath.row].name
//        vc.id = chatdata[indexPath.row].id
//        vc.logo = chatdata[indexPath.row].logo
//                self.navigationController?.pushViewController(vc, animated: true)
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//
//       }
}
//print(excellent,good,weak)
struct MyEvaluationData {
    var excellent: Int?
    var good: Int?
    var weak: Int?
    
    init(excellent: Int, good: Int, weak: Int){
    self.excellent = excellent
    self.good = good
    self.weak = weak
    
    }
}
