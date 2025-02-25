import SwiftUI

public struct FancyScrollView: View {
    let title: String
    let titleColor: Color
    let headerHeight: CGFloat
    let scrollUpHeaderBehavior: ScrollUpHeaderBehavior
    let scrollDownHeaderBehavior: ScrollDownHeaderBehavior
    let header: AnyView?
    let content: AnyView
    let navigationLeading: (() -> AnyView)?
    let shareURL: String
    

    public var body: some View {
        if let header = header {
            return AnyView(
                HeaderScrollView(
                    title: title,
                    titleColor: titleColor,
                    headerHeight: headerHeight,
                    scrollUpBehavior: scrollUpHeaderBehavior,
                    scrollDownBehavior: scrollDownHeaderBehavior,
                    header: header,
                    content: content,
                    navigationLeading: navigationLeading,
                    shareURL: shareURL
                )
            )
        } else {
            return AnyView(
                AppleMusicStyleScrollView {
                    VStack {
                        title != "" ? HStack {
                            Text(title)
                                .font(.custom("Non Natural Grotesk Inktrap", size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.black)
                                .padding(.horizontal, 16)
                                .fixedSize(horizontal: false, vertical: true)

                            Spacer()
                        } : nil

                        title != "" ? Spacer() : nil

                        content
                    }
                }
            )
        }
    }
}

extension FancyScrollView {
    public init<A: View, B: View>(
        title: String = "",
        titleColor: Color = Color.white,
        headerHeight: CGFloat = 300,
        scrollUpHeaderBehavior: ScrollUpHeaderBehavior = .parallax,
        scrollDownHeaderBehavior: ScrollDownHeaderBehavior = .offset,
        navigationLeading: (() -> AnyView)? = nil,
        header: () -> A?,
        shareURL: String = "",
        content: () -> B
    ) {
        self.title = title
        self.titleColor = titleColor
        self.headerHeight = headerHeight
        self.scrollUpHeaderBehavior = scrollUpHeaderBehavior
        self.scrollDownHeaderBehavior = scrollDownHeaderBehavior
        self.navigationLeading = navigationLeading
        self.header = header().map { AnyView($0) }
        self.shareURL = shareURL
        self.content = AnyView(content())
    }

    public init<A: View>(
        title: String = "",
        titleColor: Color = Color.white,
        headerHeight: CGFloat = 300,
        scrollUpHeaderBehavior: ScrollUpHeaderBehavior = .parallax,
        scrollDownHeaderBehavior: ScrollDownHeaderBehavior = .offset,
        navigationLeading: (() -> AnyView)? = nil,
        shareURL: String = "",
        content: () -> A
    ) {
        self.title = title
        self.titleColor = titleColor
        self.headerHeight = headerHeight
        self.scrollUpHeaderBehavior = scrollUpHeaderBehavior
        self.scrollDownHeaderBehavior = scrollDownHeaderBehavior
        self.navigationLeading = navigationLeading
        self.header = nil
        self.shareURL = shareURL
        self.content = AnyView(content())
    }
}

#if DEBUG
struct FancyScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FancyScrollView(
            title: "Sample Title",
            titleColor: .white,
            headerHeight: 300,
            scrollUpHeaderBehavior: .parallax,
            scrollDownHeaderBehavior: .sticky,
            navigationLeading: {
                AnyView(
                    Button(action: {}) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                )
            },
            header: {
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            },
            shareURL: "https://example.com/share",
            content: {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(0..<10) { i in
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Item \(i + 1)")
                                    .font(.headline)
                                Text("Description for item \(i + 1)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        if i < 9 {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        )
    }
}
#endif
