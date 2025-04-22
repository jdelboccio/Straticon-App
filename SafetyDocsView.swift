import SwiftUI
import PDFKit
import UIHelpersNew

struct DocumentCategory: Identifiable {
    let id = UUID()
    let name: String
    let documents: [Document]
}

struct Document: Identifiable {
    let id = UUID()
    let title: String
    let fileName: String // Assume PDF file name in app bundle
}

struct SafetyDocsView: View {
    @State private var categories: [DocumentCategory] = [
        DocumentCategory(name: "Safety Procedures", documents: [
            Document(title: "Fire Safety", fileName: "fire_safety.pdf"),
            Document(title: "Equipment Handling", fileName: "equipment_handling.pdf")
        ]),
        DocumentCategory(name: "Company Policies", documents: [
            Document(title: "Code of Conduct", fileName: "code_of_conduct.pdf"),
            Document(title: "Leave Policy", fileName: "leave_policy.pdf")
        ]),
        DocumentCategory(name: "Project Files", documents: [
            Document(title: "Project Plan", fileName: "project_plan.pdf"),
            Document(title: "Blueprints", fileName: "blueprints.pdf")
        ])
    ]

    @State private var selectedDocument: Document? = nil
    @State private var showPDFViewer: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    Section(header: Text(category.name).interFont(size: 18, weight: .bold)) {
                        ForEach(category.documents) { document in
                            Button(action: {
                                selectedDocument = document
                                showPDFViewer = true
                            }) {
                                Text(document.title)
                                    .foregroundColor(AppTheme.primaryColor)
                                    .interFont(size: 16, weight: .medium)
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Safety & Docs")
            .background(AppTheme.backgroundGray)
            .sheet(isPresented: $showPDFViewer) {
                if let doc = selectedDocument {
                    PDFViewer(fileName: doc.fileName)
                }
            }
        }
    }
}

struct PDFViewer: View {
    let fileName: String

    var body: some View {
        if let url = Bundle.main.url(forResource: fileName, withExtension: nil) {
            PDFKitView(url: url)
                .edgesIgnoringSafeArea(.all)
        } else {
            Text("Document not found")
                .foregroundColor(.red)
                .interFont(size: 16, weight: .semibold)
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // No update needed
    }
}

struct SafetyDocsView_Previews: PreviewProvider {
    static var previews: some View {
        SafetyDocsView()
            .preferredColorScheme(.light)
        SafetyDocsView()
            .preferredColorScheme(.dark)
    }
}
