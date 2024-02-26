//
//  BannerItemView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct BannerItemView: View {
    let banner: Banner
    
    var body: some View {
        if let urlString = banner.cover {
            CachedImage(url: urlString) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    ImagePlaceholder()
                } else {
                    LoaderView()
                }
            }
        } else {
            ImagePlaceholder()
        }
    }
}

#Preview {
    VStack {
        BannerItemView(banner: .init(id: 10, bookId: 367, cover: "https://s3-alpha-sig.figma.com/img/7e72/f768/851faf12b50da45aea177081f10a0171?Expires=1709510400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=UaAjCtBlbjuXqRcLvVG45wBa9B5jq7JPj34QDgyKBl6mbUl3UbNbxdLeZgrbXa4JyPeFy4RcaEc7hOYUPzY~HySjeUbiULc54L~27Er64J6mnqf3xoPcU5KvtyGlqWIjyOUphsKBws~7RJUY2iCTQ2EM4uPNdo3jV37BbCyHnNLyPzGSr73uCwfn0GE-g4r7hFMs5S0ERn649L9onesyLIOH4n5M2BMtyL3CtjI2eEcfPpQSjLCOC1-nZttVwWkIgOC40hjYJQeVJs2vTo30178tEGVpS8oG552n6iTUpcvku-IsNgRVPokY4xAn88Omg2rIEDLlMrZ5x6WBTu2vlg__"))
    }
    .aspectRatio(16 / 8, contentMode: .fit)
}
