import AVKit
import SwiftUI

struct PagingVideoView<Placeholder: View, Failure: View, Content: View>: View {

  @EnvironmentObject
  private var browser: LBJPagingBrowser

  private let video: MediaVideoType
  private let placeholder: (MediaType) -> Placeholder
  private let failure: (Error) -> Failure
  private let content: (MediaLoadedResult) -> Content

  init(
    video: MediaVideoType,
    @ViewBuilder placeholder: @escaping (MediaType) -> Placeholder,
    @ViewBuilder failure: @escaping (Error) -> Failure,
    @ViewBuilder content: @escaping (MediaLoadedResult) -> Content
  ) {
    self.video = video
    self.placeholder = placeholder
    self.failure = failure
    self.content = content
  }

  var body: some View {
    if let status = browser.videoStatus(for: video) {
      switch status {
      case .idle:
        placeholder(video)
      case .loaded(let previewImage, let videoUrl):
        content(.video(video: video, previewImage: previewImage, videoUrl: videoUrl))
      case .failed(let error):
        failure(error)
      }
    } else {
      placeholder(video)
    }
  }
}

extension PagingVideoView where
Placeholder == MediaPlaceholderView,
Failure == PagingMediaErrorView,
Content == GridMediaLoadedResultView {

  init(video: MediaVideoType) {
    self.init(
      video: video,
      placeholder: { _ in MediaPlaceholderView() },
      failure: { PagingMediaErrorView(error: $0) },
      content: { GridMediaLoadedResultView(result: $0) }
    )
  }
}

struct PagingVideoView_Previews: PreviewProvider {
  static var previews: some View {
    let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
    let video = MediaURLVideo(
      videoUrl: url,
      previewImageUrl: URL(string: "https://www.example.com/test.png")!
    )
    PagingVideoView(video: video)
      .environmentObject(LBJPagingBrowser(medias: [video]))
  }
}
