import SwiftUI

struct GridURLVideoView<Placeholder: View, Content: View>: View {

  private let urlVideo: MediaURLVideo
  private let placeholder: () -> Placeholder
  private let content: (MediaLoadedResult) -> Content

  init(
    urlVideo: MediaURLVideo,
    @ViewBuilder placeholder: @escaping () -> Placeholder,
    @ViewBuilder content: @escaping (MediaLoadedResult) -> Content
  ) {
    self.urlVideo = urlVideo
    self.placeholder = placeholder
    self.content = content
  }
  
  var body: some View {
    if let previewUrl = urlVideo.previewImageUrl {
      GridURLImageView(
        urlImage: .init(imageUrl: previewUrl),
        placeholder: placeholder,
        progress: { _ in EmptyView() },
        failure: { _ in
          content(.video(
            video: urlVideo,
            previewImage: nil,
            videoUrl: urlVideo.videoUrl
          ))
        },
        content: { result in
          if case let .image(_, uiImage) = result {
            content(.video(
              video: urlVideo,
              previewImage: uiImage,
              videoUrl: urlVideo.videoUrl
            ))
          }
        }
      )
    } else {
      content(.video(
        video: urlVideo,
        previewImage: nil,
        videoUrl: urlVideo.videoUrl
      ))
    }
  }
}

extension GridURLVideoView where
Placeholder == MediaPlaceholderView,
Content == GridMediaLoadedResultView {

  init(urlVideo: MediaURLVideo) {
    self.init(
      urlVideo: urlVideo,
      placeholder: { MediaPlaceholderView() },
      content: { GridMediaLoadedResultView(result: $0) }
    )
  }
}

struct GridMediaURLVideoView_Previews: PreviewProvider {
  static var previews: some View {
    GridURLVideoView(urlVideo: MediaURLVideo.templates[0])
  }
}
