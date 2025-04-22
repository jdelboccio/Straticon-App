import SwiftUI
import UIHelpersDark

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let snippet: String
    let imageName: String?
    var isLiked: Bool = false
}

struct NewsFeedView: View {
    @State private var newsItems: [NewsItem] = [
        NewsItem(title: "New Project Launch", snippet: "We are excited to announce the launch of our new project in downtown.", imageName: "building.2"),
        NewsItem(title: "Safety Training Update", snippet: "Mandatory safety training scheduled for next week.", imageName: nil),
        NewsItem(title: "Company Picnic", snippet: "Join us for the annual company picnic this Saturday!", imageName: "leaf.arrow.circlepath")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach($newsItems) { $item in
                    NewsCardView(newsItem: $item)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("News")
            .background(AppTheme.backgroundDark)
        }
    }
}

struct NewsCardView: View {
    @Binding var newsItem: NewsItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(newsItem.title)
                .interFont(size: 20, weight: .thin)
                .foregroundColor(AppTheme.primaryColor)

            Text(newsItem.snippet)
                .interFont(size: 16, weight: .thin)
                .foregroundColor(.white)

            if let imageName = newsItem.imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(AppTheme.cornerRadius)
                    .padding(.vertical, 4)
                    .foregroundColor(AppTheme.primaryColor)
            }

            HStack {
                Spacer()
                Button(action: {
                    newsItem.isLiked.toggle()
                }) {
                    Image(systemName: newsItem.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(newsItem.isLiked ? AppTheme.secondaryColor : .gray)
                        .scaleEffect(newsItem.isLiked ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: newsItem.isLiked)
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel(newsItem.isLiked ? "Unlike" : "Like")
            }
        }
        .padding()
        .cardStyle()
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
            .preferredColorScheme(.dark)
    }
}
