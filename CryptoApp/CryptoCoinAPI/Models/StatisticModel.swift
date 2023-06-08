//model architecture 

import Foundation

// wenn ein datenmodell genutzt werden will mit swiftui braucht man das protokoll identifiable

struct StatisticModel: Identifiable {
    // Universally Unique Identifier (UUID) ist eine 128-Bit-Zahl, welche zur Identifikation von Informationen in Computersystemen verwendet wird
    // -> größtmöglichen Gewissheit etwas zu identifizieren
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double? // speichern von dezimalzahlen -> optionaler wert 2,3 oder nur einstellig 
}
