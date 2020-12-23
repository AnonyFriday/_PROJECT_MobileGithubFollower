//
//  Constants.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 28/10/20.
//

import UIKit

//MARK: SFS Symbols Images
enum SFSymnbols {
    
    static let haveName             = UIImage(systemName: "person.fill")
    static let noName               = UIImage(systemName: "person.fill.questionmark")
    static let haveLocation         = UIImage(systemName: "mappin.and.ellipse")
    static let noLocation           = UIImage(systemName: "mappin.slash")
    static let repos                = UIImage(systemName: "folder.fill")
    static let gists                = UIImage(systemName: "text.alignleft")
    static let following            = UIImage(systemName: "person.3.fill")
    static let followers            = UIImage(systemName: "suit.heart.fill")
    static let thumbUpFavorite      = UIImage(systemName: "hand.thumbsup.fill")
}

//MARK: Images
enum AssestImages {
    
    static let emptyStatelogo       = UIImage(named: "empty-state-logo")
    static let ghLogo               = UIImage(named: "gh-logo")
    static let avatarPlaceholder    = UIImage(named: "avatar-placeholder")
}

//MARK: Screen Size Property
enum ScreenSizeProperty {
    static let width                = UIScreen.main.bounds.size.width
    static let height               = UIScreen.main.bounds.size.height
    static let maxLength            = max(ScreenSizeProperty.width, ScreenSizeProperty.height)
    static let minLength            = min(ScreenSizeProperty.width, ScreenSizeProperty.height)
}

//MARK: Device Types
enum DeviceTypes {
    
    static let idiom                = UIDevice.current.userInterfaceIdiom
    static let nativeScale          = UIScreen.main.nativeScale
    static let scale                = UIScreen.main.scale
    
    //MARK: -- iPhone
    static let iPhoneSEGen1                     = idiom == .phone && ScreenSizeProperty.maxLength == 568.0
    static let iPhoneSEGen2_Standard            = idiom == .phone && ScreenSizeProperty.maxLength == 667.0
    static let iPhoneSEGen2_Zoomed              = idiom == .phone && ScreenSizeProperty.maxLength == 568.0 && nativeScale > scale
    
    static let iPhone8_Standard                 = idiom == .phone && ScreenSizeProperty.maxLength == 667.0
    static let iPhone8_Zoomed                   = idiom == .phone && ScreenSizeProperty.maxLength == 568.0 && nativeScale > scale
    
    static let iPhone8PlusStandard              = idiom == .phone && ScreenSizeProperty.maxLength == 736.0
    static let iPhone8PlusZoomed                = idiom == .phone && ScreenSizeProperty.maxLength == 667.0 && nativeScale > scale
    
    static let iPhoneX_Standard                 = idiom == .phone && ScreenSizeProperty.maxLength == 812.0
    static let iPhoneX_Zoomed                   = idiom == .phone && ScreenSizeProperty.maxLength == 693.0 && nativeScale > scale
    
    static let iPhoneXR_Standard                = idiom == .phone && ScreenSizeProperty.maxLength == 896.0
    static let iPhoneXR_Zoomed                  = idiom == .phone && ScreenSizeProperty.maxLength == 896.0 && nativeScale > scale
    
    static let iPhoneXs_Standard                = idiom == .phone && ScreenSizeProperty.maxLength == 812.0
    static let iPhoneXs_Zoomed                  = idiom == .phone && ScreenSizeProperty.maxLength == 693.0 && nativeScale > scale
    
    static let iPhoneXsMax_Standard             = idiom == .phone && ScreenSizeProperty.maxLength == 896.0
    static let iPhoneXsMax_Zoomed               = idiom == .phone && ScreenSizeProperty.maxLength == 812.0 && nativeScale > scale
    
    static let iPhone11_Standard                = idiom == .phone && ScreenSizeProperty.maxLength == 896.0
    static let iPhone11_Zoomed                  = idiom == .phone && ScreenSizeProperty.maxLength == 812.0 && nativeScale > scale
    
    static let iPhone11Pro_Standard             = idiom == .phone && ScreenSizeProperty.maxLength == 812.0
    static let iPhone11Pro_Zoomed               = idiom == .phone && ScreenSizeProperty.maxLength == 693.0 && nativeScale > scale
    
    static let iPhone11ProMax_Standard          = idiom == .phone && ScreenSizeProperty.maxLength == 896.0
    static let iPhone11ProMax_Zoomed            = idiom == .phone && ScreenSizeProperty.maxLength == 812.0 && nativeScale > scale
    
    static let iPhone12Mini_Standard            = idiom == .phone && ScreenSizeProperty.maxLength == 812.0
    static let iPhone12Mini_Zoomed              = idiom == .phone && ScreenSizeProperty.maxLength == 693.0 && nativeScale > scale
    
    static let iPhone12_Standard                = idiom == .phone && ScreenSizeProperty.maxLength == 844.0
    static let iPhone12_Zoomed                  = idiom == .phone && ScreenSizeProperty.maxLength == 693.0 && nativeScale > scale
    
    static let iPhone12Pro_Standard             = idiom == .phone && ScreenSizeProperty.maxLength == 844.0
    static let iPhone12Pro_Zoomed               = idiom == .phone && ScreenSizeProperty.maxLength == 693.0 && nativeScale > scale
    
    static let iPhone12ProMax_Standard          = idiom == .phone && ScreenSizeProperty.maxLength == 926.0
    static let iPhone12ProMax_Zoomed            = idiom == .phone && ScreenSizeProperty.maxLength == 812.0 && nativeScale > scale
    
    //MARK: -- iPad
    static let iPad                   = idiom == .pad   && ScreenSizeProperty.maxLength >= 1024.0
    
    //MARK: -- iPod
    static let iPod7th                = idiom == .phone && ScreenSizeProperty.maxLength == 568.0
    
}


