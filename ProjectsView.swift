import SwiftUI
import UIHelpersDark

struct Project: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let address: String
    let keyContacts: [String]
    let scheduleSummary: String
}

struct ProjectsView: View {
    @State private var projects: [Project] = [
        Project(name: "Downtown Tower", location: "New York, NY", address: "123 Main St, New York, NY", keyContacts: ["John Doe", "Jane Smith"], scheduleSummary: "Completion: Dec 2024"),
        Project(name: "Lakeside Villas", location: "Chicago, IL", address: "456 Lakeview Dr, Chicago, IL", keyContacts: ["Alice Johnson", "Bob Brown"], scheduleSummary: "Completion: Aug 2023")
    ]

    var body: some View {
        NavigationView {
            List(projects) { project in
                NavigationLink(destination: ProjectDetailView(project: project)) {
                    VStack(alignment: .leading) {
                        Text(project.name)
                            .interFont(size: 18, weight: .thin)
                            .foregroundColor(AppTheme.primaryColor)
                        Text(project.location)
                            .interFont(size: 14, weight: .thin)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Projects")
            .background(AppTheme.backgroundDark)
        }
    }
}

struct ProjectDetailView: View {
    let project: Project

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(project.name)
                    .interFont(size: 24, weight: .thin)
                    .foregroundColor(AppTheme.primaryColor)

                Text("Address:")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                Text(project.address)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.7))

                Text("Key Contacts:")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                ForEach(project.keyContacts, id: \.self) { contact in
                    Text(contact)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.7))
                }

                Text("Schedule Summary:")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                Text(project.scheduleSummary)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.7))

                HStack(spacing: 20) {
                Button(action: {
                    // Open related documents
                }) {
                    Text("Documents")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: AppTheme.primaryColor))

                Button(action: {
                    // Open project chat
                }) {
                    Text("Chat")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: AppTheme.secondaryColor))
                }
            }
            .padding()
        }
        .background(AppTheme.backgroundDark)
        .navigationTitle("Project Details")
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
            .preferredColorScheme(.dark)
    }
}
