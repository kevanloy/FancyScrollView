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
    var shareURL: String = ""

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
        content: () -> B,
        shareURL: String = ""
    ) {
        self.title = title
        self.titleColor = titleColor
        self.headerHeight = headerHeight
        self.scrollUpHeaderBehavior = scrollUpHeaderBehavior
        self.scrollDownHeaderBehavior = scrollDownHeaderBehavior
        self.navigationLeading = navigationLeading
        self.header = header().map { AnyView($0) }
        self.content = AnyView(content())
        self.shareURL = shareURL
    }

    public init<A: View>(
        title: String = "",
        titleColor: Color = Color.white,
        headerHeight: CGFloat = 300,
        scrollUpHeaderBehavior: ScrollUpHeaderBehavior = .parallax,
        scrollDownHeaderBehavior: ScrollDownHeaderBehavior = .offset,
        navigationLeading: (() -> AnyView)? = nil,
        content: () -> A
    ) {
        self.title = title
        self.titleColor = titleColor
        self.headerHeight = headerHeight
        self.scrollUpHeaderBehavior = scrollUpHeaderBehavior
        self.scrollDownHeaderBehavior = scrollDownHeaderBehavior
        self.navigationLeading = navigationLeading
        self.header = nil
        self.content = AnyView(content())
    }
}
