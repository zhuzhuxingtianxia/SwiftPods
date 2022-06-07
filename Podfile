source "https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"

project 'SwiftPods.xcodeproj'

# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'SwiftPods' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  #网络请求库
  pod 'Alamofire', '~> 5.4.4'
  #解析库
  pod 'SwiftyJSON', '~> 5.0.1'
  pod 'HandyJSON', '~> 5.0.1'
#  pod 'ObjectMapper', '~> 3.4.2'
# MJ的纯swift解析框架，Xcode11开始支持
#  pod 'KakaJSON', '~> 1.0.0'

  #类似SDWebImage 还有AlamofireImage
  pod 'Kingfisher', '~> 4.0'
  # 类似Kingfisher 图片管理类库
 # pod 'Nuke', :git => 'https://github.com/kean/Nuke', :branch => 'master'
 
  #数据库
#  pod 'RealmSwift', '~> 3.13.1'

  #图片预览
  pod 'SKPhotoBrowser', '~> 6.1.0'
  # 相册图片选择库
 # pod "BSImagePicker", "~> 3.1"
 # pod 'CLImagePickerTool', :git => 'https://github.com/Darren-chenchen/CLImagePickerTool.git'
  
  #banner滚动图片
#  pod 'FSPagerView','~> 0.8.2'
  #tabpage分页
#  pod 'DNSPageView', '~> 1.1.6'
  #跑马灯
#  pod 'JXMarqueeView', '~> 0.0.7'
  #滚动页
#  pod 'LTScrollView', '~> 0.2.1'
  #播放网络音频
#  pod 'StreamingKit', '~> 0.1.30'
  #消息弹框
#  pod 'SwiftMessages', '~> 6.0.2'
  # 可动画的TabBarController
# pod 'RAMAnimatedTabBarController'

#  pod 'JXSegmentedView', '~> 1.2.7'# 分页控制
#  pod 'EasyListView', '~> 1.2.2'# 快速搭建静态列表
#  pod 'ActiveLabel', '~> 1.1.0'# Label部分内容点击
#  pod 'BonMot', '~> 5.6.0'# attributedString的简化
#  pod 'RZColorfulSwift' # 富文本框架，支持展开收起
  # Socket通信
#  pod 'SwiftSocket'
  # 编码数据结构，比较难用
#  pod 'ProtocolBuffers-Swift'


  #下拉刷新
  pod 'SwiftPullToRefresh', '~> 3.0.0'
  pod 'ESPullToRefresh', '~> 2.9.3'
  #加载中 swift4.x
  pod 'PKHUD', '~> 5.0'
  # 样式比较多
  pod 'NVActivityIndicatorView', '~>  5.1.1'
  
  #toast提示
  pod 'Toast-Swift', '~> 5.0.1'
  
  #布局库  其前身是 Masonry
  #学习参考：http://blog.csdn.net/jsd0915/article/details/77852822
  pod 'SnapKit', '~> 5.0.0'
  #响应式
  pod 'RxSwift',    '~> 5.1.0'
  pod 'RxCocoa',    '~> 5.1.0'
  # RxSwift对tableView的扩展
  # pod 'RxDataSources', '~> 3.1.0'
  
  
  # 网络管理库 桥接Alamofire与Rx框架
  # pod 'Moya', '~> 15.0'
  # Spring - 动画框架
  
  #图表库
  pod 'Charts', '~> 4.0.0'
  
  # 日历 该组件存在一定问题，实际项目不可使用
  pod 'CVCalendar', '~> 1.7.0'

  # 识别库要iOS13可用于学习 依赖GPUImage 引入报错太多不可用
  # pod 'GPUImage2', :podspec => './GPUImage2.podspec'
   # :git => "https://github.com/NMAC427/SwiftOCR.git", :branch => 'master'
   # pod 'SwiftOCR', :podspec => './SwiftOCR.podspec'
   # pod 'GPUImage'
  
  # Pods for SwiftPods

  target 'SwiftPodsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftPodsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


target 'SpeakEnglish' do
    use_frameworks!
    
    #网络请求库
    pod 'Alamofire', '~> 5.4.4'
    #解析库
    pod 'HandyJSON', '~> 5.0.1'
    #类似SDWebImage 还有AlamofireImage
    pod 'Kingfisher', '~> 4.0'

    target 'SpeakEnglishTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'SpeakEnglishUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end



