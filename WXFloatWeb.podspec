Pod::Spec.new do |s|
  s.name = 'WXFloatWeb'
  s.version = '1.0.0'

  s.ios.deployment_target = '8.0'

  s.license = 'MIT'
  s.summary = 'WXFloatWeb'
  s.homepage = 'https://github.com/AK403/WXFloatWeb'
  s.author = { 'AK403' => 'AK403@qq.com' }
  s.source = { :git => 'https://github.com/AK403/WXFloatWeb.git', :commit => '11b24d036fd82a7835255426bb7a8995811acc33' }
  s.frameworks   = 'WebKit'  
  s.description = 'This library provides ability for App with support Floating Window and'    \
                  'WebContainerView like Wechat'

  s.requires_arc = true
  s.default_subspec = 'Core'

  s.subspec 'WXFloatSDK' do |floatSDK|
    floatSDK.ios.deployment_target = '8.0'
    floatSDK.source_files = 'WXFloatSDK/WXFloatSDK/WXFloatManager.{h,m,mm}','WXFloatSDK/WXFloatSDK/*/*.{h,m,mm}'
    floatSDK.resources = 'WXFloatSDK/WXFloatSDK/Resource/WXFloatBundle.bundle'
  end

  s.subspec 'WXStyleWebContainerView' do |styleWebView|
    styleWebView.ios.deployment_target = '8.0'
    styleWebView.source_files = 'WXStyleWebContainerView/WXStyleWebContainerView/*/*.{h,m,mm}'
    styleWebView.resources = 'WXStyleWebContainerView/WXStyleWebContainerView/Resource/WXStyleWebContainerView.bundle'
  end

  s.subspec 'WXStyleWebViewController' do |styleWebViewController|

    styleWebViewController.source_files = 'WXFloatWebDemo/WXFloatWebDemo/WXStyleWebViewController/*.{h,m}'
    styleWebViewController.resources = 'WXFloatWebDemo/WXFloatWebDemo/WXStyleWebViewController/WXStyleWebViewController.bundle'
    styleWebViewController.dependency 'WXFloatWeb/WXFloatSDK'
    styleWebViewController.dependency 'WXFloatWeb/WXStyleWebContainerView'
  end

  s.subspec 'Core' do |core|
    core.dependency 'WXFloatWeb/WXFloatSDK'
    core.dependency 'WXFloatWeb/WXStyleWebContainerView'
  end
end
