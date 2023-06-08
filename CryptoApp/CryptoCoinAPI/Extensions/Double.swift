import Foundation

// extension -> das Erweitern einer vorhandenen Klasse, Struktur, Enumeration oder eines Protokolls, ohne den Originalcode zu ändern
// Funktionalitätserweiterung
// Protokollimplementierung
// Berechnete Eigenschaften


extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private var  numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    // nil-coalescing operator oder Nil-Zusammenführungsoperator
    // optionalen Wert zu behandeln, wenn dieser den Wert "nil" enthält
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? "€0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func toPercentString() -> String {
        guard let numberAsString = numberFormatter.string(for: self) else { return ""}
        return numberAsString + "%"
    }
    /*
     convert 1234 to 1,23k
     convert 123456 to to 123.45k
     */
    
    // abkürzung
    func formattedWithAbbreviations() -> String {
        // self ist die number die wir konvertieren wollen
        let num = abs(Double(self)) // -> absoluter wert der nummer
        let sign = (self < 0 ) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Mrd"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }
}
