import SwiftUI

struct AllCoinsView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Coins")
                .font(.headline)
                .padding()
        
        HStack {
            Text("Coin")
            
            Spacer()
            
            Text("Prices")
            
            }
            .foregroundColor(.gray)
            .font(.caption)
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    // ForEach -> Schleifenanweisung wiederholte Abfrage
                    ForEach(viewModel.coins ) { coin in
                        //NavigationLink -> bringt uns auf eine neue Seite, wenn auf zeile gedrückt wird
                        NavigationLink {
                            LazyNavigationView(CoinDetailsView(coin: coin))
                            
                        } label: {
                            CoinsRowView(coin: coin)
                        }

                    }
                }
            }
        }
    }
}

struct AllCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        AllCoinsView(viewModel: HomeViewModel())
    }
}
