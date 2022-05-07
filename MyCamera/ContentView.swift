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
    @State var isPhotolibrary = false
    @State var isShowAction = false

    var body: some View {
        VStack {
            Spacer()
            Text("写真アプリ")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)

            Spacer()

            Button(action: {
                captureImage = nil
                isShowAction = true
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
                if let unwrapCaptureImage = captureImage {
                    EffectView(isShowSheet: $isShowSheet, captureImage: unwrapCaptureImage)
                } else {
                    if isPhotolibrary {
                        PHPickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                    } else {
                        ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                    }
                }
            }
            .actionSheet(isPresented: $isShowAction) {
                ActionSheet(title: Text("確認"),
                            message: Text("選択してください"),
                            buttons: [
                                .default(Text("カメラ"), action: {
                                    isPhotolibrary = false
                                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                        print("カメラは利用できます")
                                        isShowSheet = true
                                    } else {
                                        print("カメラは利用できません")
                                    }
                                }),
                                .default(Text("フォトライブラリー"), action: {
                                    isPhotolibrary = true
                                    isShowSheet = true
                                }),

                                    .cancel(),

                            ])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
