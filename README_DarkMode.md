# Straticon iOS Employee Application

## Overview

The Straticon iOS Employee Application is a futuristic, sleek, and minimalist app designed exclusively for Straticon employees to facilitate internal communication, project management, and access to essential resources. The app is built with SwiftUI, adhering to Apple’s Human Interface Guidelines, and supports a deep dark navy blue theme with high contrast white accents, using very thin fonts and lines for an elegant and modern look.

## Core Features

- **Secure Login with Face ID and Microsoft Authentication (planned)**
  - Standard username/password login with biometric Face ID support.
  - Future integration with Microsoft Authentication Library (MSAL) for seamless Microsoft 365 login.

- **Home Screen with Bottom Tab Bar Navigation**
  - Five main sections: News, Projects, Directory, Safety & Documents, and Messaging.
  - Deep dark navy blue as the primary color with white accents for high contrast.
  - Consistent use of very thin fonts and sleek lines throughout the UI.

- **News Feed**
  - Displays company news and project updates in a modern, dynamic scrolling card layout.
  - Interactive like button with smooth animations.

- **Projects**
  - List of active construction projects with detailed views.
  - Access to project documents and project-specific chat.

- **Employee Directory**
  - Searchable list of employees with profile views including contact details.

- **Safety & Documents**
  - Categorized document library with PDF viewing capabilities.

- **Messaging**
  - Conversations list and chat interface with message bubbles.
  - Basic text messaging with accessibility support.

- **Role-Based Access Control**
  - Different user roles (employee, candidate, intern, client) with tailored access and UI.

## Design and User Experience

- Uses the “Inter” font family with very thin weights for a futuristic and elegant look.
- Deep dark navy blue background with white text and accents for high contrast and eye comfort.
- Ample white space, sleek thin lines, and subtle shadows for a clean and modern aesthetic.
- Modern, dynamic scrolling with smooth transitions and animations.
- Supports Light and Dark modes with appropriate color adjustments.
- Accessibility features including VoiceOver labels, sufficient contrast, and touch target sizes.

## Planned Integrations and Enhancements

- **Microsoft Authentication Integration**
  - Use MSAL for iOS to enable Microsoft 365 login.
  - Retrieve user profile, contacts, and calendar data via Microsoft Graph API.
  - Sync events with Outlook calendars.

- **Push Notifications**
  - Real-time alerts for messages, project updates, and safety notifications.

- **Advanced Security**
  - Multi-factor authentication and secure document access.

- **Analytics and Reporting**
  - Usage analytics and project reporting dashboards.

- **Client and Candidate Access**
  - Restricted app versions for clients, candidates, and interns with limited features.

## Technical Details

- Built with SwiftUI for modern declarative UI development.
- Centralized theming and styling via `UIHelpersDark.swift`.
- Uses PDFKit for in-app document viewing.
- Implements biometric authentication with LocalAuthentication framework.
- Modular architecture supporting role-based UI flows.

## Getting Started

1. Clone the repository.
2. Open the project in Xcode 13 or later.
3. Build and run on a simulator or physical iOS device.
4. Use the login screen to authenticate (demo usernames determine roles).
5. Navigate through the app using the bottom tab bar.

## Compliance and App Store Readiness

- Adheres to Apple’s Human Interface Guidelines.
- Implements privacy and security best practices.
- Accessibility compliant with VoiceOver and dynamic type support.
- Tested for stability and crash-free experience.
- Ready for App Store submission with proper documentation.

## Contact

For questions or support, please contact the Straticon development team.

---

This README provides a comprehensive overview of the Straticon iOS Employee Application, its features, design philosophy, and technical implementation to assist developers, testers, and stakeholders in understanding and contributing to the project.
