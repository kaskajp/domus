# Product Requirements Document (PRD)

Product Name: Domus
Prepared By: Jonas
Last updated: 2025-07-10
Status: Draft

## 1. Overview
Domus is a self-hosted, privacy-first, all-in-one home management web app, built with Ruby on Rails 8. It helps families and households coordinate daily life, manage property documents and service logs, and streamline communication—all in a modern and responsive interface. It is lightweight, secure, and easy to deploy without build steps, targeting tech-savvy homeowners or local intranet use.

## 2. Goals and Objectives
- Enable families to manage daily activities like chores, tasks, shopping, and meals collaboratively.
- Provide a centralized platform for property-related records and maintenance tracking.
- Ensure the app is easy to self-host with minimal dependencies and no complex build pipeline.
- Maintain high performance and security standards, suitable for running on a local network.
- Offer a clean, modern, and responsive UI inspired by Linear, suitable for phones and tablets.

## 3. Target Audience
- Tech-savvy homeowners and families who prefer privacy and self-hosting.
- Users managing one or more properties who want to organize tasks and documents.
- Users with home servers (e.g. Raspberry Pi, Intel NUC, etc.) looking for lightweight, local-first tools.

## 4. Product Features

### 4.1 User & Account Management
- Sign-up/login with email and password.
- Roles: admin (full control), user (restricted).
- Admins can invite family members and assign permissions.
- Password reset and email verification (via optional SMTP config).

### 4.2 Family Coordination
- Chores: Recurring or one-time tasks assigned to users.
- Shared Calendar: Monthly/weekly view with tasks, events, appointments.
- Tasks: Todo lists with priorities and due dates.
- Meal Planning: Weekly planner with meals, ingredients, and links to recipes.
- Travel Plans: Keep records of upcoming family trips.
- Shopping Lists: Share and manage categorized shopping lists.

### 4.3 Property Management
- Document Storage: Upload and organize PDFs/images (e.g., insurance, warranty, permits).
- Renovation Projects: Create and track status, expenses, and notes.
- Repair & Service Logs: Log past services, set reminders for recurring maintenance.
- Appliance Tracker: Track model, purchase date, warranty expiry, and expected lifespan.

### 4.4 Theming and UI
- Light and dark mode toggle.
- Simple, modern UI inspired by Linear.
- Mobile and tablet friendly using Hotwire and responsiveness.

### 4.5 Tech Features
- Performance: Turbo/Stimulus for real-time interactivity.
- Security: CSRF protection, session management, role-based access control
- Self-Hosting: README with Docker and non-Docker instructions. No cloud dependencies.

## 5. Tech Stack
- Backend: Ruby on Rails 8
- Frontend: Hotwire (Turbo, Stimulus)
- Assets: Propshaft, CSS-only theming
- Database: SQLite (default)
- Hosting: Local machine, Raspberry Pi, or VPS
- CI/CD: GitHub Actions with Semantic Release (https://github.com/semantic-release/semantic-release)
- No Node, no JS build tools, no build for CSS

## 6. Non-Goals (for now)
- No multi-tenant SaaS model.
- No integrations with 3rd-party APIs or services.
- No mobile app (PWA/mobile web experience only).

## 7. Success Metrics
- Can be installed and used locally without external services.
- Loads in under 1s on typical home hardware.
- Users can perform all common home management tasks without documentation.
- Stable across major mobile/tablet browsers.

## 8. Future Ideas (Not in Scope Yet)
- PWA support for offline access.
- Email/SMS/Push notifications for reminders.
- AI assistant for suggesting meal plans or chore scheduling.
- Integration with calendars (e.g., Apple, Google) or smart home APIs.
- Support for multiple households.