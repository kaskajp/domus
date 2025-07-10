# Domus - Self-Hosted Home Management

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby on Rails](https://img.shields.io/badge/Rails-8.0+-red.svg)](https://rubyonrails.org/)
[![Ruby Version](https://img.shields.io/badge/Ruby-3.4+-red.svg)](https://www.ruby-lang.org/)
[![Public Source](https://img.shields.io/badge/Source-Public-blue.svg)](#public-source-project)

Domus is a self-hosted, privacy-first, all-in-one home management web app built with Ruby on Rails 8. It helps families and households coordinate daily life, manage property documents and service logs, and streamline communication—all in a modern and responsive interface.

## Features

### 🏡 **Family Coordination**
- **Chores & Tasks**: Recurring or one-time tasks assigned to family members
- **Shared Calendar**: Monthly/weekly view with tasks, events, and appointments
- **Meal Planning**: Weekly planner with meals, ingredients, and recipe links
- **Shopping Lists**: Shared and categorized shopping lists
- **Travel Plans**: Keep records of upcoming family trips

### 🏠 **Property Management**
- **Document Storage**: Upload and organize PDFs/images (insurance, warranty, permits)
- **Renovation Projects**: Create and track status, expenses, and notes
- **Repair & Service Logs**: Log past services and set maintenance reminders
- **Appliance Tracker**: Track model, purchase date, warranty, and expected lifespan

### 🔐 **User Management**
- **Role-based Access**: Admin (full control) and User (restricted) roles
- **Email Authentication**: Sign up/login with email and password
- **First User Auto-Admin**: First registered user automatically becomes admin
- **Profile Management**: Edit user details and manage family members

## Tech Stack

- **Backend**: Ruby on Rails 8
- **Frontend**: Hotwire (Turbo, Stimulus) for SPA-like experience
- **Assets**: Propshaft (no Node.js build tools required)
- **Database**: SQLite (perfect for self-hosting)
- **Styling**: Custom CSS with Tailwind-inspired utility classes
- **Authentication**: bcrypt with secure password hashing

## Quick Start

### Prerequisites
- Ruby 3.0+ 
- Rails 8.0+
- Git

### Installation

1. **Clone the repository** (if using git):
   ```bash
   git clone <your-repo-url>
   cd domus
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Set up the database**:
   ```bash
   rails db:migrate
   ```

4. **Start the server**:
   ```bash
   rails server
   ```

5. **Access the app**:
   Open your browser and navigate to `http://localhost:3000`

6. **Create your admin account**:
   - Click "Sign up" to create your first account
   - The first user will automatically be granted admin privileges
   - Start managing your home!

## Automated Releases & Versioning

Domus uses [semantic-release](https://github.com/semantic-release/semantic-release) for automated versioning and releases, while keeping the Rails application completely Node.js-free.

### How It Works

- **Conventional Commits**: Use standardized commit messages to trigger releases
- **Automated Versioning**: Semantic versioning based on commit types
- **Changelog Generation**: Automatic changelog from commit history
- **GitHub Releases**: Automated releases with notes

### Commit Types

```bash
feat: new feature (minor version bump)
fix: bug fix (patch version bump)
feat!: breaking change (major version bump)
docs: documentation (no version bump)
test: tests (no version bump)
```

### Example Workflow

```bash
# Make changes
git add .

# Use conventional commit format
git commit -m "feat: add task management system"

# Push to main branch (triggers release)
git push origin main
```

See [Development Guidelines](.github/CONTRIBUTING.md) for detailed commit standards and development approach.

## Development Features

- **No Build Tools**: Pure CSS and JavaScript with importmaps
- **Hot Reloading**: Hotwire provides instant updates without page refreshes
- **Mobile Responsive**: Works great on phones and tablets
- **Modern UI**: Clean, Linear-inspired design
- **Secure**: CSRF protection, session management, role-based access
- **Automated Releases**: Semantic versioning with conventional commits
- **CI/CD Pipeline**: GitHub Actions for testing and releases

## Deployment

### Docker (Recommended)
```bash
# Build the image
docker build -t domus .

# Run the container
docker run -p 3000:3000 -v domus_data:/app/storage domus
```

### Traditional Deployment
- Works on any VPS, Raspberry Pi, or home server
- SQLite database is portable and requires no additional setup
- Use the included `bin/setup` script for production deployment

## Current Status ✅

**Completed Features:**
- ✅ User authentication system (signup, login, logout)
- ✅ Role-based access control (admin/user)
- ✅ Modern, responsive UI with Linear-inspired design
- ✅ Dashboard with feature overview
- ✅ Secure password handling with bcrypt
- ✅ Flash messaging system
- ✅ Mobile-responsive navigation

**Next Steps:**
- 🔄 Task and chore management system
- 🔄 Calendar integration
- 🔄 Document upload and storage
- 🔄 Property management features
- 🔄 Shopping lists and meal planning

## Public Source Project

This is a **public source** project - the code is publicly viewable for learning and inspiration. While the code is available under the MIT License, this is not actively seeking community contributions at this time.

Feel free to:
- ✅ **Fork and adapt** for your own needs
- ✅ **Learn from the codebase** and implementation patterns  
- ✅ **Use as inspiration** for your own projects
- ✅ **Report critical security issues** if found

For questions or discussions about the architecture and self-hosting approach, feel free to open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Built with ❤️ for families who value privacy and self-hosting**
