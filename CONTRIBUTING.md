# Contribution Guidelines for KeyFortress | Clean Architecture

## Purpose

These contribution guidelines are designed to ensure a consistent and maintainable structure for contributions to the KeyFortress and KF_Desktop repositories. Adhering to these guidelines helps maintain the MVVM design pattern, minimizes third-party dependencies, and promotes collaboration across the project.

## General Rules

1. **MVVM Design Pattern:**
   - Follow the MVVM (Model-View-ViewModel) design pattern in both the KeyFortress and KF_Desktop repositories. Keep views and viewmodels separate, focusing on clear responsibilities for each layer.

2. **Minimize Third-Party Dependencies:**
   - Minimize the use of third-party packages. If a package is deemed necessary for your changes, initiate a discussion with the community before adding it. Prioritize packages with open-source licenses.

3. **Discuss Major Changes:**
   - For substantial changes or additions not in the Figma scope, initiate discussions with administrators or core maintainers before starting the implementation.

## Presentation Layer (KeyFortress and KF_Desktop)

### Views and ViewModels

1. **Page Creation:**
   - When creating new pages, ensure that you follow the structure of both solutions. Create views and viewmodels for the page in the respective folders within the Presentation layer.

2. **Component Creation:**
   - If KF_Components lacks necessary components for your page, create them. Ensure these components are added as a separate pull request in the KF_Components submodule.

3. **Router Integration:**
   - Integrate your new page into the router by creating a route and attaching it to the appropriate button.

4. **Business Logic Limitation:**
   - Do not add business logic beyond the standard Button clicked or field updated functionalities.

### Scope and Iteration

1. **Figma Scope:**
   - Limit page creation to those defined in the Figma scope for the current iteration. Discuss any deviations with administrators or core maintainers.

2. **Discussion for New Pages:**
   - Before starting on pages not part of the Figma scope, initiate discussions to ensure alignment with project goals.

## Infrastructure and Application Layers

### Business Logic Implementation

1. **Service Creation:**
   - For business logic such as API calls or external interactions, create a service in the KF_Infrastructure submodule.

2. **Application Implementation:**
   - Implement the application inside `KF_Application/Implementations` for the business logic. Ensure the interface is registered in the KF_Shared project within the locator.

## Domain Layer

1. **Model/Record/Enum/Exception:**
   - For any model, record, enum, or exception needed, create it inside the KF_Domain submodule.

## Contribution Process

1. **Fork the Repository:**
   - Fork the respective repository to your GitHub account.

2. **Create a Branch:**
   - Create a new branch for your contribution with a descriptive and concise name.

3. **Make Changes:**
   - Implement the desired changes following the guidelines mentioned above.

4. **Commit Changes:**
   - Commit your changes with clear and descriptive commit messages.

5. **Push to Your Fork:**
   - Push your changes to your forked repository on GitHub.

6. **Submit a Pull Request:**
   - Open a pull request from your branch to the `main` branch of the original repository.

7. **Participate in Review:**
   - Actively participate in the review process, addressing feedback and collaborating with maintainers and contributors.

8. **Ensure Proper Documentation:**
   - Document any new components, services, or interfaces as needed.

## Code of Conduct

By contributing to KeyFortress, you agree to abide by our [Code of Conduct](https://github.com/KeysFortress/KeyFortress/blob/main/CODE_OF_CONDUCT.md) to maintain a positive and inclusive community.

## Thank you for contributing to KeyFortress! Your efforts play a crucial role in enhancing the project and community.
