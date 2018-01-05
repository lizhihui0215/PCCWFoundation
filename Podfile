# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


platform :ios, '8.0'

workspace 'PCCWFoundation'

def libraries
    pod 'AFNetworking'
    pod 'Realm'
    pod 'UITableView+FDTemplateLayoutCell'
    pod 'MJRefresh'
    pod 'MBProgressHUD'
    pod 'WebViewJavascriptBridge'
    pod 'Masonry'
    pod 'BlocksKit'
    pod 'libextobjc'
    pod 'FDStackView'
    # https://github.com/icanzilb/JSONModel
    pod 'JSONModel'
    # https://github.com/hackiftekhar/IQKeyboardManager
    pod 'IQKeyboardManager'

    # https://github.com/rs/SDWebImage
    pod 'SDWebImage'
    # https://github.com/dzenbot/DZNEmptyDataSet
    pod 'DZNEmptyDataSet'
    # https://github.com/robbiehanson/KissXML
    pod 'KissXML'

    # https://github.com/kelp404/CocoaSecurity
    pod 'CocoaSecurity'

    # https://github.com/romaonthego/RESideMenu
    pod 'RESideMenu'

    # https://github.com/sebyddd/SDVersion
    pod 'SDVersion'

    # https://github.com/soffes/sskeychain
    pod 'SSKeychain'
    # https://github.com/thisandagain/color
    pod 'EDColor'
    #https://github.com/steipete/Aspects 面向切面
    #https://github.com/oarrabi/OAStackView UIStackView iOS 7.0以上
    #https://github.com/Augustyniak/RATreeView  展开列表
    #https://github.com/mxcl/PromiseKit 异步框架
end

target 'PCCWFoundation' do
    inhibit_all_warnings!
    use_frameworks!

    libraries

    target 'PCCWFoundation Example' do
        project 'iOS Example/PCCWFoundation Example.xcodeproj'

    end

end
