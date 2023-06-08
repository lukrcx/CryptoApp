import SwiftUI

// durch @StateObejct wird die Klasse observed

class HomeViewModel: ObservableObject {
    
    // @Published-Wrapper wird verwendet um automatisch Benachrichtigungen zu generieren, wenn sich der Wert einer Eigenschaft ändert
    // für das Aktualisieren von SwiftUI-Ansichten, wenn sich der Zustand ändert
    
    @Published var coins = [Coin]()
    @Published var topMovingCoins = [Coin]()
    @Published var isLoadingData = true
    
    // init() bedeuted, dass wenn wir die Klasse HomeViewModel initalisiert/vorbereitet wird und die Funktion fetchCoinData ausgeführt wird
    
    init() {
        fetchCoinData()
    }
    
    // diese Funktion gibt uns die Informationen von der URL wieder
    
    func fetchCoinData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en"
        
        
        // "guard" ist eine Kontrollflusskonstrukt
        // hilft dabei vorzeitige Ausstiege aus Funktionen oder Schleifen zu ermöglichen, wenn die Bedingung nicht erfüllt ist
        // konvertiert es in ein URL Objekt
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // DEBUG in Filter eingeben, besser zum debuggen
                print("DEBUG: Error \(error.localizedDescription)")
                self.isLoadingData = false
                return
            }
            
            // as/as?/as! -> ist ein Schlüsselwort und mehrere Bedeutungen
            
            // 1. Type Casting (Typumwandlung):
            
            // (1) Upcasting: Mit "as" kann eine Instanz als ihre Superklasse oder eine der Superklassen behandelt werden
            // ( let vehicle: Vehicle = Car() )
            
            // (2) Downcasting: Mit "as" kann eine Instanz als ihre Unterklasse oder einen spezifischen Typ, der von ihr abgeleitet ist, behandelt werden. -> if let car = vehicle as? Car { Zugriff auf eigenschaften und Methoden, die spezifisch für Car sind }
            
            // 2. ype Checking (Typüberprüfung):
            
            //  "as?" wird für die OPTIONALE Downcasting verwendet. Es liefert einen optionalen Wert des Typs, zu dem du versuchst, die Umwandlung durchzuführen, oder nil, wenn die Umwandlung fehlschlägt.
            
            // if let car = vehicle as? Car {
            // Die Umwandlung war erfolgreich
            // } else {
            // Die Umwandlung ist fehlgeschlagen
            // }
            
            // "as!" wird für das ERZWUNGENE Downcasting verwendet. Es versucht, die Instanz in den angegebenen Typ umzuwandeln und entpackt das Ergebnis erzwungen. Wenn die Umwandlung fehlschlägt, tritt ein Laufzeitfehler auf.
            // let car = vehicle as! Car
            
            
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response code \(response.statusCode)")
            }
                
            guard let data = data else { return }
                
            do {
                // "self" ist eine Referenz auf die aktuelle Instanz einer Klasse oder Struktur. Es wird verwendet, um auf Eigenschaften, Methoden und Initialisierer der aktuellen Instanz zuzugreifen oder sich selbst als Parameter an eine Funktion zu übergeben
                
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    self.coins = coins 
                    self.configureTopMovingCoins()
                    self.isLoadingData = false
                }
            } catch let error {
                print("DEBUG: Failed to decode with error: \(error)")
                self.isLoadingData = false 
            }
            
        }.resume()
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H})
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}
