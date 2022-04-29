//
//  ContentView.swift
//  MyCamera
//
//  Created by 児島　陸斗 on 2022/04/28.
//

import SwiftUI

struct ContentView: View {

    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var isShowActivity = false

    var body: some View {
        VStack {
            Spacer()
            Text("写真アプリ")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            Spacer()

            if let unwrapCaptureImage = captureImage {
                Image(uiImage: unwrapCaptureImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Spacer()

            Button(action: {
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    print("カメラは利用できます")
                    isShowSheet = true
                } else {
                    print("カメラは利用できません")
                }
            }) {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)

            }
            .padding()
            .sheet(isPresented: $isShowSheet) {
                ImagePickerView(
                    isShowSheet: $isShowSheet,
                    captureImage: $captureImage
                )
            }

            Button(action: {
                if let _ = captureImage {
                    isShowActivity = true
                }
            }) {
                Text("SNSに投稿する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)

            }
            .padding()
            .sheet(isPresented: $isShowActivity) {
                ActivityView(shareItems: [captureImage!])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
