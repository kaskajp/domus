import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "overlay", "userMenu"]

  connect() {
    // Bind event listeners
    this.openSidebar = this.openSidebar.bind(this)
    this.closeSidebar = this.closeSidebar.bind(this)
    this.toggleUserMenu = this.toggleUserMenu.bind(this)
    
    // Add event listeners
    document.getElementById('open-sidebar')?.addEventListener('click', this.openSidebar)
    document.getElementById('close-sidebar')?.addEventListener('click', this.closeSidebar)
    document.getElementById('mobile-menu-overlay')?.addEventListener('click', this.closeSidebar)
    document.getElementById('user-menu-button')?.addEventListener('click', this.toggleUserMenu)
    
    // Close user menu when clicking outside
    document.addEventListener('click', (event) => {
      const userMenu = document.getElementById('user-menu')
      const userMenuButton = document.getElementById('user-menu-button')
      
      if (userMenu && userMenuButton && 
          !userMenu.contains(event.target) && 
          !userMenuButton.contains(event.target)) {
        userMenu.classList.add('hidden')
      }
    })

    // Close sidebar on escape key
    document.addEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        this.closeSidebar()
      }
    })
  }

  openSidebar() {
    const sidebar = document.getElementById('sidebar')
    const overlay = document.getElementById('mobile-menu-overlay')
    
    if (sidebar && overlay) {
      sidebar.classList.add('show')
      overlay.classList.add('show')
      // Prevent body scroll when sidebar is open
      document.body.style.overflow = 'hidden'
    }
  }

  closeSidebar() {
    const sidebar = document.getElementById('sidebar')
    const overlay = document.getElementById('mobile-menu-overlay')
    
    if (sidebar && overlay) {
      sidebar.classList.remove('show')
      overlay.classList.remove('show')
      // Restore body scroll
      document.body.style.overflow = 'auto'
    }
  }

  toggleUserMenu() {
    const userMenu = document.getElementById('user-menu')
    if (userMenu) {
      userMenu.classList.toggle('hidden')
    }
  }

  disconnect() {
    // Clean up event listeners
    document.getElementById('open-sidebar')?.removeEventListener('click', this.openSidebar)
    document.getElementById('close-sidebar')?.removeEventListener('click', this.closeSidebar)
    document.getElementById('mobile-menu-overlay')?.removeEventListener('click', this.closeSidebar)
    document.getElementById('user-menu-button')?.removeEventListener('click', this.toggleUserMenu)
  }
} 