import SwiftUI

struct RemoteImage: View {
    let url: URL
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView() // Show a loading indicator
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
            case .failure:
                Image(systemName: "exclamationmark.triangle") // Show an error icon
                    .frame(width: width, height: height)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    let imgURL = URL(string: "https://i.ibb.co/D77n08V/ironman.jpg")!
    RemoteImage(url: imgURL, width: 200, height: 200)
}
