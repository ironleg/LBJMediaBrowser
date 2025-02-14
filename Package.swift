// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LBJMediaBrowser",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "LBJMediaBrowser",
      targets: ["LBJMediaBrowser"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/Alamofire/AlamofireImage.git",from: "4.2.0")
    ),
    .package(
      url: "https://github.com/ironleg/LBJImagePreviewer.git",from: "0.0.1")
  ],
  targets: [
    .target(
      name: "LBJMediaBrowser",
      dependencies: ["AlamofireImage", "LBJImagePreviewer"],
      resources: [.process("PreviewContent")]
    ),
    .testTarget(
      name: "LBJMediaBrowserTests",
      dependencies: ["LBJMediaBrowser"],
      resources: [.process("Resources/Images")]
    )
  ]
)
