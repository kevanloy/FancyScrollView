import SwiftUI

struct HeaderScrollViewTitle: View {
    let title: String
    let titleColor: Color
    let height: CGFloat
    let largeTitle: Double
    let navigationLeading: (() -> AnyView)?
    let shareURL: String


    var body: some View {
        let largeTitleOpacity = (max(largeTitle, 0.5) - 0.5) * 2
        let tinyTitleOpacity = 1 - min(largeTitle, 0.5) * 2
        return ZStack {
            HStack {
                Text(title)
                    .font(.custom("Non Natural Grotesk Inktrap", size: 40))
                    .foregroundColor(titleColor)
                    .fontWeight(.black)
                    .padding(.horizontal, 16)

                Spacer()
                if shareURL != "" {
                    if #available(iOS 16.0, *) {
                        ShareLink(item: URL(string: shareURL)!) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color("PrimaryBeige"))
                        }
                    } else {
                        // Fallback on earlier versions dc
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color("PrimaryBeige"))
                    }
            }
            }
            .padding(.bottom, 8)
            .opacity(sqrt(largeTitleOpacity))
            .minimumScaleFactor(0.5)

            ZStack {
                HStack {
                    if let navigationLeading = navigationLeading {
                        navigationLeading()
                    } else {
                        BackButton(color: .white)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(title)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    if shareURL != "" {
                        if #available(iOS 16.0, *) {
                            ShareLink(item: URL(string: shareURL)!) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(Color("PrimaryBeige"))
                            }
                        } else {
                            // Fallback on earlier versions dc
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color("PrimaryBeige"))
                        }
                }
                }
            }
            .padding(.bottom, (height - 18) / 2)
            .opacity(sqrt(tinyTitleOpacity))
        }.frame(height: height)
    }
}
