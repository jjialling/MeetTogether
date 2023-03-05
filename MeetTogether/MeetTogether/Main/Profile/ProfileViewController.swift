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
            
            
            view.addSubview(profileImageView)
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            profileImageView.anchor(top: view.topAnchor, paddingTop: 88, width: 120, height: 120)
            profileImageView.layer.cornerRadius = 120 / 2
            
//            view.addSubview(messageButton)
//            messageButton.anchor(top: view.topAnchor, left: view.leftAnchor,
//                                 paddingTop: 64, paddingLeft: 32, width: 32, height: 32)
//
            view.addSubview(editButton)
            editButton.anchor(top: profileImageView.topAnchor,left: profileImageView.leftAnchor, paddingTop: 94 , paddingLeft: 88, width: 25, height: 25)
            
            
            
//            editButton.anchor(top: view.topAnchor, right: view.rightAnchor,
//                                 paddingTop: 64, paddingRight: 32, width: 32, height: 32)
            
            view.addSubview(nameLabel)
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
            
//            view.addSubview(emailLabel)
//            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
            
            return view
        }()
        
        
        let profileImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "profilePic")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
//            iv.layer.borderWidth = 3
//            iv.layer.borderColor = UIColor.black.cgColor
            return iv
        }()
        
//       let messageButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.setImage(#imageLiteral(resourceName: "ic_mail_outline_white_2x").withRenderingMode(.alwaysOriginal), for: .normal)
//            button.addTarget(self, action: #selector(handleMessageUser), for: .touchUpInside)
//            return button
//        }()
//
        let editButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "pencil_icon.png"), for: .normal)
//            button.layer.borderWidth = 2
//            button.layer.borderColor = UIColor.black.cgColor
            button.backgroundColor = .white
            button.layer.cornerRadius = 25 / 2
            button.addTarget(self, action: #selector(handleEditProfilePic), for: .touchUpInside)
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
        
//        let emailLabel: UILabel = {
//            let label = UILabel()
//            label.textAlignment = .center
//            label.text = "venom@gmail.com"
//            label.font = UIFont.systemFont(ofSize: 18)
//            label.textColor = .white
//            return label
//        }()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .Neutral.whiteStroke
            
            view.addSubview(containerView)
            containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor, height: 300)
            
            
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        // MARK: - Selectors
        
        @objc func handleEditProfilePic() {
            print("Edit user profile pic here..")
        }
        
//        @objc func handleFollowUser() {
//            print("Follow user here..")
//        }
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

