
import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,MessageInputBarDelegate {
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LogInViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    let commentBar = MessageInputBar()
    var showCommentBar = false
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
            return commentBar
        }
        
    override var canBecomeFirstResponder: Bool {
            return showCommentBar
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
                 if posts != nil {
                     self.posts = posts!
                     self.tableView.reloadData()
                 }
             }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
               let comments = (post["comments"] as? [PFObject]) ?? []
               
               if indexPath.row == 0 {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
                    
                   
                    
                    let user = post["author"] as! PFUser
                    cell.usernameLabel.text = user.username
                    cell.captionLabel.text = post["caption"] as? String
                    
                    let imageFile = post["image"] as! PFFileObject
                    let urlString = imageFile.url!
                    let url = URL(string: urlString)!
                    
                    cell.photoView.af_setImage(withURL: url)
                    
                    return cell
               } else if indexPath.row <= comments.count{
                   let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
                   
                   let comment = comments[indexPath.row - 1]
                   cell.commentLabel.text = comment["text"] as? String
                   
                   let user = comment["author"] as! PFUser
                   cell.nameLabel.text = user.username
                   
                   return cell
               } else {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
                   return cell
               }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let post = posts[indexPath.section]
            let comments = (post["comments"] as? [PFObject]) ?? []
            
            if indexPath.row == comments.count + 1{
                showCommentBar = true
                becomeFirstResponder()
                commentBar.inputTextView.becomeFirstResponder()
                
                selectedPost = post
            }
        }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
            //Create the comment
            let comment = PFObject(className: "comments")
            comment["text"] = text
            comment["post"] = selectedPost
            comment["author"] = PFUser.current()

            selectedPost.add(comment, forKey: "comments")
            selectedPost.saveInBackground{ (success, error) in
                if success {
                    print("comment saved")
                } else {
                    print("error saving comment")
                }
                }
            
            tableView.reloadData()
            
            //Clear and dismiss the keyboard bar
            commentBar.inputTextView.text = nil
            showCommentBar = false
            becomeFirstResponder()
            commentBar.inputTextView.resignFirstResponder()
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
