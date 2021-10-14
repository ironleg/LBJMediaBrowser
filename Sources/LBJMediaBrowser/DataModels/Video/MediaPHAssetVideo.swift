import Photos

/// 代表视频格式是 `PHAsset` 的视频类型。
/// A video type with a `PHAsset` object whose `mediaType` is `video`.
public struct MediaPHAssetVideo: MediaPHAssetVideoType {

  public let id = UUID().uuidString
  public let asset: PHAsset

  /// 创建 `MediaPHAssetVideo` 对象。Creates a `MediaPHAssetVideo` object.
  /// - Parameter asset: `mediaType` 是 `video` 的 `PHAsset` 对象。A  `PHAsset` object whose `mediaType` is `video`.
  public init(asset: PHAsset) {
    guard asset.mediaType == .video else {
      fatalError("[MediaPHAssetVideo] The `asset` should be a type of video.")
    }
    self.asset = asset
  }
}

extension MediaPHAssetVideo: Equatable { }
