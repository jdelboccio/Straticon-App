import SwiftUI
import UIHelpersNew

struct Employee: Identifiable {
    let id = UUID()
    let name: String
    let jobTitle: String
    let email: String
    let phone: String
}

struct DirectoryView: View {
    @State private var searchText: String = ""
    @State private var employees: [Employee] = [
        Employee(name: "John Doe", jobTitle: "Project Manager", email: "john.doe@straticon.com", phone: "555-1234"),
        Employee(name: "Jane Smith", jobTitle: "Site Engineer", email: "jane.smith@straticon.com", phone: "555-5678"),
        Employee(name: "Alice Johnson", jobTitle: "Safety Officer", email: "alice.johnson@straticon.com", phone: "555-8765")
    ]

    var filteredEmployees: [Employee] {
        if searchText.isEmpty {
            return employees
        } else {
            return employees.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.jobTitle.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredEmployees) { employee in
                NavigationLink(destination: EmployeeProfileView(employee: employee)) {
                    VStack(alignment: .leading) {
                        Text(employee.name)
                            .interFont(size: 18, weight: .bold)
                            .foregroundColor(AppTheme.primaryColor)
                        Text(employee.jobTitle)
                            .interFont(size: 14, weight: .regular)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            }
            .searchable(text: $searchText, prompt: "Search employees")
            .navigationTitle("Directory")
            .background(AppTheme.backgroundGray)
        }
    }
}

struct EmployeeProfileView: View {
    let employee: Employee

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(employee.name)
                .interFont(size: 24, weight: .bold)
                .foregroundColor(AppTheme.primaryColor)

            Text(employee.jobTitle)
                .font(.headline)

            HStack(spacing: 8) {
                Image(systemName: "envelope")
                Text(employee.email)
            }
            .font(.body)

            HStack(spacing: 8) {
                Image(systemName: "phone")
                Text(employee.phone)
            }
            .font(.body)

            Spacer()
        }
        .padding()
        .background(AppTheme.backgroundLight)
        .navigationTitle("Profile")
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryView()
            .preferredColorScheme(.light)
        DirectoryView()
            .preferredColorScheme(.dark)
    }
}
