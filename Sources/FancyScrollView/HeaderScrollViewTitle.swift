import SwiftUI

struct HeaderScrollViewTitle: View {
    let title: String
    let titleColor: Color
    let height: CGFloat
    let largeTitle: Double
    let navigationLeading: (() -> AnyView)?

    var body: some View {
        let largeTitleOpacity = (max(largeTitle, 0.5) - 0.5) * 2
        let tinyTitleOpacity = 1 - min(largeTitle, 0.5) * 2
        return ZStack {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(titleColor)
                    .fontWeight(.black)
                    .padding(.horizontal, 16)

                Spacer()
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
                    Text(title)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
            }
            .padding(.bottom, (height - 18) / 2)
            .opacity(sqrt(tinyTitleOpacity))
        }.frame(height: height)
    }
}
