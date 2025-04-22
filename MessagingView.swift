import SwiftUI
import UIHelpersDark

struct Conversation: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let isGroup: Bool
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSentByCurrentUser: Bool
    let timestamp: Date
}

struct MessagingView: View {
    @State private var conversations: [Conversation] = [
        Conversation(name: "John Doe", lastMessage: "See you at the site tomorrow.", isGroup: false),
        Conversation(name: "Project Team", lastMessage: "Meeting rescheduled to 3 PM.", isGroup: true)
    ]

    var body: some View {
        NavigationView {
            List(conversations) { conversation in
                NavigationLink(destination: ChatView(conversation: conversation)) {
                    VStack(alignment: .leading) {
                        Text(conversation.name)
                            .interFont(size: 18, weight: .thin)
                            .foregroundColor(AppTheme.primaryColor)
                        Text(conversation.lastMessage)
                            .interFont(size: 14, weight: .thin)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Messages")
            .background(AppTheme.backgroundDark)
        }
    }
}

struct ChatView: View {
    let conversation: Conversation
    @State private var messages: [Message] = [
        Message(text: "Hello!", isSentByCurrentUser: false, timestamp: Date()),
        Message(text: "Hi, how can I help?", isSentByCurrentUser: true, timestamp: Date())
    ]
    @State private var newMessageText: String = ""

    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) { _ in
                    if let last = messages.last {
                        scrollView.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }

            HStack {
                TextField("Type a message", text: $newMessageText)
                    .inputFieldStyle()
                    .frame(minHeight: 30)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(newMessageText.isEmpty ? .gray : AppTheme.secondaryColor)
                        .padding()
                }
                .disabled(newMessageText.isEmpty)
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel("Send message")
            }
            .padding()
        }
        .navigationTitle(conversation.name)
        .background(AppTheme.backgroundLight)
    }

    func sendMessage() {
        let message = Message(text: newMessageText, isSentByCurrentUser: true, timestamp: Date())
        messages.append(message)
        newMessageText = ""
    }
}

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isSentByCurrentUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(AppTheme.secondaryColor)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding()
                    .background(AppTheme.primaryColor.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message.isSentByCurrentUser ? "Sent message: \(message.text)" : "Received message: \(message.text)")
    }
}

struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
            .preferredColorScheme(.dark)
    }
}
