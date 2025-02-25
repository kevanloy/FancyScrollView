import SwiftUI

public struct FancyScrollView: View {
    let title: String
    let titleColor: Color
    let headerHeight: CGFloat
    let scrollUpHeaderBehavior: ScrollUpHeaderBehavior
    let scrollDownHeaderBehavior: ScrollDownHeaderBehavior
    let header: AnyView?
    var shareURL: String = ""
    let content: AnyView
    let navigationLeading: (() -> AnyView)?
    

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
                    shareURL: shareURL
                    content: content,
                    navigationLeading: navigationLeading
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
