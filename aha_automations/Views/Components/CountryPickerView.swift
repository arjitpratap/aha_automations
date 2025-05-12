//
//  CountryPickerView.swift
//  aha_automations
//
//  Created by Arjit Pratap Singh Chauhan on 12/05/25.
//

import SwiftUI

// Country View
struct CountryPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    @Binding var selectedCountry: String
    
    let countries: [Country] = Locale.isoRegionCodes.compactMap {
        if let name = Locale.current.localizedString(forRegionCode: $0) {
            return Country(name: name)
        }
        return nil
    }.sorted { $0.name < $1.name }

    var filtered: [Country] {
        if searchText.isEmpty { return countries }
        return countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    var groupedCountries: [String: [Country]] {
        groupCountries(filtered)
    }

    var body: some View {
        NavigationView {
            List {
                // Move SearchBar into List
                Section {
                    SearchBar(text: $searchText)
                        .listRowInsets(EdgeInsets()) // Remove unwanted insets
                }

                ForEach(groupedCountries.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedCountries[key] ?? []) { country in
                            Button(action: {
                                selectedCountry = country.name
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text(country.name)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Select Region")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}


// Group Countries
func groupCountries(_ countries: [Country]) -> [String: [Country]] {
    let grouped = Dictionary(grouping: countries) { String($0.name.prefix(1)) }
    return grouped.mapValues { $0.sorted { $0.name < $1.name } }
}


// Search Bar
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
        .padding(.horizontal)
    }
}

