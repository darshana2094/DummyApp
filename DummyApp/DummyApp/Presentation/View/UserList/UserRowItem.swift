//
//  UserRowItem.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 03/02/25.
//

import SwiftUI

/// A SwiftUI view representing a single row item in a user list.
///
/// The `UserRowItem` displays basic user information in a compact layout, including
/// the user's ID, name, email, and city. The design uses icons to visually represent
/// the email and location fields for enhanced user experience.
struct UserRowItem: View {
    
    // MARK: - Properties
    
    /// The `User` model containing the information to display in the row.
    let user: UserModel
    
    // MARK: - Body
    
    /// The main body of the `UserRowItem` view, defining its layout and design.
    ///
    /// The view includes a vertical stack for the user's ID, name, and email, alongside
    /// a horizontal layout to display the user's city with an accompanying location icon.
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("# \(user.id) \(user.firstName) \(user.lastName)")
                
                HStack(spacing: 0) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.red)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            
            HStack(spacing: 0) {
                Image(systemName: "mappin")
                    .foregroundColor(.orange)
                Text(user.address.city)
                    .font(.footnote)
            }
        }
        .accessibilityIdentifier("UserCell-\(user.id)")
    }
}


#Preview {
    UserRowItem(user:UserModel(id: 1, firstName: "Darshana", lastName: "Nagekar", email: "dn@gmail.com", address: AddressModel(address: "Ghotmorad", city: "Curchorem", state: "Goa", postalCode: "403706"), company: CompanyModel(name: "Apple")))
}
