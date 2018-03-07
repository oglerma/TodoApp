//
//  AddToDoViewController.swift
//  TodoApp
//
//  Created by Ociel Lerma on 3/6/18.
//  Copyright © 2018 Ociel Lerma. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    //Mark: Outlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentedView: UISegmentedControl!
    @IBOutlet weak var doneBtn: UIButton!
    
    // Bottom will be used to when we need to add the height of the key board.
    // THe height is located in the keyboardWillShow()
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Listen to our Key Board Notification. What this does is that when we add
        // an observer we get the information that just happened and if the information
        // that just happened, which is when we type inside of the text field, we will
        // get the keyboard height and assign it to our contraint.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(with: )), name: .UIKeyboardDidShow, object: nil)
        
        // This will essentially start the keyboard before the we press inside. As
        // soon as we move to the page.
        textView.becomeFirstResponder()
    }
    

    // Since we are using the selector we will be using @objc
    @objc func keyboardWillShow(with notification: Notification){
       // This key is what we will need to know that it touched inside of the
        // Text field
        let key = "UIKeyboardFrameEndUserInfoKey"
        //I am using Guard to unwrapp the optional. if it doesnt unwrap then i return
       // This notification is going to give is the frame of the keyword.
        guard let keyBoardFrame = notification.userInfo?[key] as? NSValue else {return}
        
        // This is to get the Keyboard height that will pop up when we are inside of
        // the text area. We add this height to our constant that we made for our bottom
        // constraint.
        // I added 10 so that the Bottom button is not so close to the bottom
        let keyboardHeight = keyBoardFrame.cgRectValue.height + 10
        
        // When the keyboard goes up our bottom constraint which is attached to our buttom will
        // Go up as well and won't be covered by the keyboard.
        bottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.3){
            // Here we will update the constrainnt autolayout. So when it is
            // activated it will move the contraint with a duration of 0.3 sec
            self.view.layoutIfNeeded()
        }
        
    }

    @IBAction func cancel_btn_clicked(_ sender: Any) {
        //This will dismiss our ViewController and will go back to the last controller
        dismiss(animated: true)
        // This will make the keyboard disappear faster
        textView.resignFirstResponder()
        print("IM in cacel")
    }
    

    @IBAction func done_btn_clicked(_ sender: Any) {
    }

}


