//
//  ProfileViewController.swift
//  MeetTogether
//
//  Created by Elias Rodriguez on 2023/3/5.
//

import UIKit

class ProfileViewController: UIViewController {

        // MARK: - Properties
        
        private lazy var containerView: UIView = {
            let view = UIView()
            
//            view.backgroundColor = .blue
            
            view.addSubview(profileImageView)
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            profileImageView.anchor(top: view.topAnchor, paddingTop: 88, width: 120, height: 120)
            profileImageView.layer.cornerRadius = 120 / 2
            

            view.addSubview(editButton)
            editButton.anchor(top: profileImageView.topAnchor,left: profileImageView.leftAnchor, paddingTop: 94 , paddingLeft: 88, width: 25, height: 25)
            
            
            view.addSubview(nameLabel)
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
            
            view.addSubview(editProfileLabel)
            editProfileLabel.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 80,paddingLeft: 75)
            
            view.addSubview(myInterestLabel)
            myInterestLabel.anchor(top: editProfileLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 45, paddingLeft: 75)
            
            view.addSubview(logoutLabel)
            logoutLabel.anchor(top: myInterestLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 45, paddingLeft: 75)
            
            view.addSubview(editProfileIconImageView)
            editProfileIconImageView.anchor(top: nameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 80, paddingRight: 17, width: 25, height: 25)
            
            view.addSubview(myInterestIconImageView)
            myInterestIconImageView.anchor(top: editProfileLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 45, paddingRight: 17, width: 25, height: 25)
            
            view.addSubview(logoutIconImageView)
            logoutIconImageView.anchor(top: myInterestLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 45, paddingRight: 17, width: 25, height: 25)
            
            view.addSubview(editProfileImageView)
            editProfileImageView.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 80, paddingLeft: 15, width: 25, height: 25)

            view.addSubview(myInterestImageView)
            myInterestImageView.anchor(top: editProfileLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 45, paddingLeft: 15, width: 25, height: 25)

            view.addSubview(logoutImageView)
            logoutImageView.anchor(top: myInterestLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 45, paddingLeft: 15, width: 25, height: 25)
            
            return view
        }()
      
//    private lazy var profileSelectionView: UIView = {
//        let bottomView = UIView()
//
//        bottomView.backgroundColor = .blue
//
//        view.addSubview(profileImageView)
//        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        profileImageView.anchor(top: view.topAnchor, paddingTop: 88, width: 120, height: 120)
//        profileImageView.layer.cornerRadius = 120 / 2
//
//
//        return bottomView
//    }()
        
        
        let profileImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "profilePic")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
    
        let editProfileImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "icon_edit")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()

        let myInterestImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "icon_heart 1")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()

        let logoutImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "icon_logout")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()

        
        let editProfileIconImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "Icon_right_direction")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
        
        let myInterestIconImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "Icon_right_direction")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
           
        let logoutIconImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "Icon_right_direction")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
        

        let editButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "pencil_icon.png"), for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 25 / 2
            button.addTarget(ProfileViewController.self, action: #selector(handleEditProfilePic), for: .touchUpInside)
            return button
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "Charles Barkley"
            label.font = UIFont.boldSystemFont(ofSize: 26)
            label.textColor = .black
            return label
        }()
        
        let myInterestLabel: UILabel = {
            let label = UILabel()
            label.text = "My Interests"
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textColor = .black
            return label
        }()
    
        let editProfileLabel: UILabel = {
            let label = UILabel()
            label.text = "Edit Profile"
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textColor = .black
            return label
        }()
    
        let logoutLabel: UILabel = {
            let label = UILabel()
            label.text = "Logout"
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textColor = .black
            return label
        }()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .Neutral.whiteStroke
            
            view.addSubview(containerView)
            containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor, height: 700)
//            view.addSubview(profileSelectionView)
//            containerView.anchor(top: containerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor ,right: view.rightAnchor)
            
            
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        // MARK: - Selectors
        
        @objc func handleEditProfilePic() {
            print("Edit user profile pic here..")
        }
        

    }

    extension UIColor {
        static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        }
        
        static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
    }

    extension UIView {
        
        func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                    paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
            }
            
            if let bottom = bottom {
                if let paddingBottom = paddingBottom {
                    bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
                }
            }
            
            if let right = right {
                if let paddingRight = paddingRight {
                    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
                }
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }

