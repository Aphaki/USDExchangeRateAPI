//
//  ContentView.swift
//  USDExchangeRateAPI
//
//  Created by Sy Lee on 2022/06/08.
//

import SwiftUI

struct ContentView: View {

    @StateObject var vm = ContentVM()
    
    var body: some View {
        VStack(alignment: .center) {
            Text(vm.usdExchangeRate?.curUnit?.uppercased() ?? "")
            Text("매매기준율: " + (vm.usdExchangeRate?.dealBasR ?? "0"))
            Text("전신환(송금) 보낼때: " + (vm.usdExchangeRate?.tts ?? "0"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
