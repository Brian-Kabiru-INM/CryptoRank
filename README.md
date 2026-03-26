# **CryptoRank**

**CryptoRank** is an iOS application built entirely with **UIKit**, designed to provide a smooth and engaging onboarding experience before granting access to the core app features. It demonstrates a clean architecture, fully programmatic UI, and persistent onboarding state using `UserDefaults`.

***

## **Features**

### **Custom App Icon**

***

### **Programmatic Launch Screen**

The app opens with a launch screen.

*   Displays the CryptoRank logo and brand elements
*   Uses Auto Layout programmatically
*   Holds for 3 seconds before transitioning
*   Includes a smooth fade/scale animation into the next screen

***

### **Three‑Page Slide Show**

After the launch sequence, users are presented with a **3‑screen onboarding slideshow**:

*   Built using **UIPageViewController**
*   Each page is a separate UIViewController with:
    *   Title
    *   Description text
    *   Illustrative image
    *   Button
*   Includes page indicators (UIPageControl)
*   Smooth horizontal swiping experience

***

### **Get Started Flow**

At the final slide, users tap **“Get Started”** to proceed.

***

### **Onboarding Form**

The app features a lightweight onboarding form where users enter basic information (e.g., name, email, preferences).  
All inputs are validated and passed forward to the login process.

***

### **Login Screen**

After completing onboarding, users are taken to a login form implemented with UIKit components:

*   Email/username field
*   Password field
*   Secure text entry
*   Custom login button
*   Error validation

***

### **UserDefaults Persistence**

The app uses `UserDefaults` to persist lightweight onboarding and login state:

*   Tracks whether a user has already completed onboarding
*   Prevents replaying the slideshow on every launch
*   Stores form input where appropriate

***

## **Tech Stack**

*   **UIKit**
*   **UIPageViewController**
*   **Programmatic Auto Layout (NSLayoutConstraint)**
*   **UserDefaults**
*   **UINavigationController**
*   **MVC Architecture**

***

## **App Flow Overview**

    App Launch
       ↓
    Launch Screen (3 seconds)
       ↓
    Three-Page Slideshow (UIPageViewController)
       ↓ “Get Started”
    Onboarding Form
       ↓
    Login Screen
       ↓
    To-Continue

***

## **Getting Started**

1.  Clone the repository:

```bash
git clone https://github.com/your-username/cryptorank.git
```

2.  Open the project:

```bash
cd cryptorank
open CryptoRank.xcodeproj
```

3.  Build and run on iOS 15+.

***

## **Project Structure (Recommended)**

    CryptoRank/
    │
    ├── App/
    │   └── AppDelegate.swift
        └── SceneDelegate.swift
    │
    ├── ViewControllers/
    │   ├── ViewController.swift
    │   ├── LauncherScreenViewController.swift
    │   ├── OnboardingViewController.swift
    │   ├── OnboardingPageViewController.swift
        ├── RegisterViewController.swift
        ├── LoginViewController.swift
    │
    ├── Authentication/
    │   └──
    │
    └── Utilities/
        └── AlertHelper.swift

