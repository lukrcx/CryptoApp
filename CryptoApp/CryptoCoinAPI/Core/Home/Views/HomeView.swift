import SwiftUI

struct HomeView: View {
    
    // Deklaration von Eigenschaften, die den Zustand eines Objekts innerhalb einer Ansicht darstellt
    // kann auf Änderungen reagieren und können unser unser user interface updaten 
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // Top movers view
                    TopMoversView(viewModel: viewModel)
                    
                    Divider()
                    
                    // all coins view
                    AllCoinsView(viewModel: viewModel)
                    
                }
                
                if viewModel.isLoadingData {
                    CustomLoadingIndicator()
                }
            }
            .navigationTitle("Live Prices")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
