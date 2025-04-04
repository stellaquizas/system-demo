# Modern Web Application Demo

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](VERSION-README.md)

This repository demonstrates a modern web application architecture with CI/CD integration. It showcases a three-tier application with **Vue.js 3** frontend, Spring Boot backend, and PostgreSQL database, all containerized with Docker and orchestrated with Docker Compose.

## 1. Overview

This demo showcases:

- **Modern Architecture**: Vue.js 3 (Composition API), Spring Boot, PostgreSQL
- **Containerization**: Docker and Docker Compose
- **CI/CD Integration**: GitHub Actions and GitLab CI/CD
- **Microservices-Oriented Pipelines**: Independent frontend and backend pipelines

## 2. Components

This demo consists of three main components:

1. **Frontend**: Vue.js 3 application with Tailwind CSS ([system-vue](https://github.com/YOUR_USERNAME/system-vue))
2. **Backend**: Spring Boot REST API ([system-rest](https://github.com/YOUR_USERNAME/system-rest))
3. **Database**: PostgreSQL database

## 3. Repository Organization

This project is organized as three separate repositories to support team independence while maintaining centralized version control:

1. **system-demo** (this repository): Contains the Docker Compose configuration, CI/CD setup, documentation, and controls the overall system version
2. **system-rest**: Contains the Spring Boot backend code (managed by the backend team)
3. **system-vue**: Contains the Vue.js frontend code (managed by the frontend team)

When set up for development, the component repositories (`system-rest` and `system-vue`) should be cloned inside the main `system-demo` repository directory. The `.gitignore` file in the main repository is configured to ignore these component folders, allowing each repository to maintain its own independent Git history.

This structure enables:

- Independent development and versioning of each component
- Separate CI/CD pipelines for frontend and backend
- Centralized orchestration and deployment through the main repository
- Team autonomy while maintaining system cohesion

### 3.1 Versioning Strategy

- The main **system-demo** repository controls the **single version** for the entire system
- The Docker Compose file in this repository specifies which exact commits/tags of the components to use
- All components (frontend, backend, database) are versioned together as a single unit
- Version numbers follow semantic versioning (MAJOR.MINOR.PATCH) and are defined in this repository

This approach ensures that:

- There is only one version number to track
- All components are guaranteed to work together
- Releases are coordinated across all components
- The system can be easily rolled back to a previous version if needed

**Current Version: 0.1.0** (Initial prototype)

For detailed version management instructions, see [VERSION-README.md](VERSION-README.md).

## 4. Getting Started

### 4.1 Prerequisites

- Docker and Docker Compose
- Git
- Java 17 (for backend development)
- Node.js (for frontend development)
- VS Code (recommended, with extensions for Java, Spring Boot, and Vue.js)

### 4.2 Setup for Developers

This project is organized as three separate repositories. Developers need to clone all three repositories and place them in the correct structure:

1. **Clone All Three Repositories**:

   ```bash
   # Clone the main coordinator repository
   git clone https://github.com/YOUR_USERNAME/system-demo.git
   cd system-demo

   # Clone the component repositories inside the system-demo directory
   git clone https://github.com/YOUR_USERNAME/system-rest.git
   git clone https://github.com/YOUR_USERNAME/system-vue.git
   ```

   The final directory structure should look like this:

   ```
   system-demo/             # Main coordinator repository
   ├── system-rest/         # Backend component repository
   └── system-vue/          # Frontend component repository
   ```

   Note: The `.gitignore` file in the main repository is already configured to ignore the component folders, allowing each repository to maintain its own Git history.

2. **Start the Application**:

   ```bash
   # From the system-demo directory
   docker compose up --build
   ```

3. **Component-Specific Development**:

   - **Backend Development**:

     ```bash
     # Navigate to the backend component
     cd system-rest

     # Set up your development environment
     # (Follow the instructions in the backend component README)
     ```

   - **Frontend Development**:

     ```bash
     # Navigate to the frontend component
     cd system-vue

     # Set up your development environment
     # (Follow the instructions in the frontend component README)
     ```

### 4.3 Access the Application

- Frontend: http://localhost:8080 (when running in Docker) or http://localhost:5173 (when running with npm)
- Backend API: http://localhost:9966/system/api
- API Documentation: http://localhost:9966/system/swagger-ui/index.html

## 5. Development Workflow

### 5.1 Production Mode

```bash
# Run everything in Docker
docker compose up --build
```

### 5.2 Development Mode (Recommended for Development)

```bash
# Terminal 1 - Start Database and Backend
docker compose up database backend

# Terminal 2 - Start Frontend with Hot-Reload
cd system-vue
npm install
npm run dev
```

### 5.3 Branching Strategy and Development Workflow

This project follows a GitFlow-inspired branching strategy optimized for enterprise development with scheduled releases:

#### 5.3.1 Branch Types

- **main/master**: Long-term record of production releases
- **develop**: Integration branch for features
- **feature/\***: Individual feature development (e.g., `feature/login-page`)
- **release/\***: Preparation for scheduled releases (e.g., `release/1.0.0`)
- **hotfix/\***: Emergency fixes for production issues (e.g., `hotfix/critical-bug`)

#### 5.3.2 Development Workflow

1. **Feature Development**:

   ```bash
   # Create a feature branch from develop
   git checkout develop
   git pull
   git checkout -b feature/new-feature

   # Work on your feature...

   # Push changes to remote
   git push -u origin feature/new-feature

   # Create a Pull Request to merge into develop
   ```

2. **Release Preparation** (Biannual Schedule):

   ```bash
   # Create a release branch from develop
   git checkout develop
   git pull
   git checkout -b release/1.0.0

   # Only bug fixes go into release branch
   # Testing and stabilization happens here

   # Push release branch
   git push -u origin release/1.0.0
   ```

3. **Release to Production**:

   ```bash
   # When release is stable
   git checkout main
   git pull
   git merge release/1.0.0

   # Tag with version
   git tag -a v1.0.0 -m "Version 1.0.0"
   git push origin main --tags

   # Also merge back to develop
   git checkout develop
   git pull
   git merge release/1.0.0
   git push origin develop
   ```

4. **Hotfixes** (if needed):

   ```bash
   # Create hotfix branch from main
   git checkout main
   git pull
   git checkout -b hotfix/critical-bug

   # Fix the issue...

   # Merge to main
   git checkout main
   git pull
   git merge hotfix/critical-bug

   # Tag with incremented version
   git tag -a v1.0.1 -m "Version 1.0.1"
   git push origin main --tags

   # Also merge to develop
   git checkout develop
   git pull
   git merge hotfix/critical-bug
   git push origin develop
   ```

#### 5.3.3 CI/CD Integration with Branching Strategy

Our CI/CD pipelines are configured to work with this branching strategy:

- **Feature Branches**: Automated testing on every push and pull request
- **Develop Branch**: Testing + building Docker images
- **Release Branches**: Testing + building + deployment to staging environment
- **Main Branch**: Deployment to production when tagged
- **Version Tags**: Trigger full release pipeline (build, test, deploy to production)

This approach ensures:

- Developers can continue working on features for the next release
- The current release is stabilized separately
- Only approved, tagged versions go to production
- There's a clear history of what's in each environment

#### 5.3.4 Implementing GitFlow in a Multi-Repository Setup

The branching strategy applies differently to each repository based on its role:

1. **Component Repositories** (`system-rest` and `system-vue`):

   - Implement the full GitFlow branching strategy
   - Create feature branches for all code changes: `feature/backend-tdd`, `feature/auth-implementation`, etc.
   - Maintain a `develop` branch for integration
   - Create release branches when preparing for a release
   - Use the main/master branch only for production-ready code

2. **Coordinator Repository** (`system-demo`):
   - Primarily focuses on release management and coordination
   - May not need feature branches if no code changes are being made
   - Still maintains a `develop` branch to track the overall system development state
   - Creates release branches to coordinate releases across all repositories
   - Uses tags to mark system-wide versions

**When to Create Feature Branches in Each Repository:**

| Repository  | Create Feature Branch When...                                                |
| ----------- | ---------------------------------------------------------------------------- |
| system-rest | Working on backend features (Java code, API endpoints, database changes)     |
| system-vue  | Working on frontend features (Vue components, UI changes, client-side logic) |
| system-demo | Making changes to Docker configuration, documentation, or CI/CD pipelines    |

**Example Feature Branches by Repository:**

- **system-rest**:

  - `feature/backend-tdd`
  - `feature/auth-implementation`
  - `feature/api-optimization`

- **system-vue**:

  - `feature/frontend-tdd`
  - `feature/ui-redesign`
  - `feature/client-side-validation`

- **system-demo**:
  - `feature/docker-compose-update`
  - `feature/documentation-improvement`
  - `feature/deployment-scripts`

If you're not making code changes to a particular repository (e.g., no changes to `system-demo`), you don't need to create feature branches for that repository. However, you should still maintain the `develop` and `main` branches to track the overall system state and coordinate releases.

## 6. Database Operations

### 6.1 View Database Content

```bash
# Access PostgreSQL console
docker exec -it system-demo-database-1 psql -U petclinic -d petclinic

# Useful PostgreSQL commands:
\dt                    # List all tables
SELECT * FROM owners;  # View all owners
\q                    # Exit console
```

### 6.2 Backup Database

```bash
# Create backup
docker exec -it system-demo-database-1 pg_dump -U petclinic petclinic > backup.sql
```

## 7. Technology Stack

### 7.1 Modern Web Architecture

Our application modernization leverages:

#### 7.1.1 Cloud-Native Design

- **Docker Containerization**: Each component runs in isolated containers
- **Service Independence**: Frontend can be scaled separately from backend
- **Configuration Externalization**: Environment variables control connections

#### 7.1.2 API-First Development

- **OpenAPI/Swagger Documentation**: Available at `http://localhost:9966/system/swagger-ui/index.html`
- **RESTful Endpoints**: Structured API for operations
- **Type-Safe API Consumption**: Frontend uses TypeScript interfaces matching backend DTOs

#### 7.1.3 Modern SPA Framework

- **Vue.js 3 Components**: Modular UI building blocks with Composition API
- **Vue 3 Composition API**: Better code organization and TypeScript integration
- **Tailwind CSS Integration**: Utility-first styling

#### 7.1.4 Infrastructure as Code

- **Docker Configuration**: Complete environment defined in code
- **Multi-Container Setup**: Three-tier architecture specified in `docker-compose.yml`
- **Development/Production Parity**: Same container configurations in all environments

### 7.2 Key Technical Benefits

1. **Scalability**: Each container can be scaled independently
2. **Maintainability**: Clear separation of concerns between frontend/backend
3. **Developer Experience**: Hot-reload in development, consistent environments
4. **Modern UI**: Responsive design with Tailwind CSS and Font Awesome
5. **Type Safety**: TypeScript prevents common frontend errors
6. **API Documentation**: Always up-to-date with Swagger UI
7. **Database Reliability**: PostgreSQL with ACID compliance
8. **Easy Deployment**: Single `docker-compose up` command for entire stack

## 8. CI/CD Integration

This project includes CI/CD configurations for both GitHub Actions and GitLab CI/CD, allowing you to demonstrate and compare both solutions. We've implemented a modern microservices-oriented approach with separate pipelines for frontend and backend components.

### 8.1 CI/CD Architecture Overview

The CI/CD setup follows a multi-repository approach with branch-based workflows:

1. **Three Separate Repositories**: Each with its own CI/CD pipeline

   - `system-demo`: Coordinator repository with release workflows only
   - `system-rest`: Backend repository with full CI/CD pipeline
   - `system-vue`: Frontend repository with full CI/CD pipeline

2. **Branch-Based Workflows**: CI/CD pipelines behave differently based on branch type

   - `feature/*` branches: Run tests only
   - `develop` branch: Run tests and build Docker images
   - `release/*` branches: Run tests, build images, deploy to staging
   - `main/master` branch: Deploy to production when tagged
   - Version tags (`v*.*.*`): Trigger full release pipeline

3. **Independent Pipelines**: Frontend and backend have separate CI/CD pipelines
4. **Coordinated Releases**: Version tags are synchronized across all repositories

**Important Note**: The `system-demo` repository does not handle CI/CD for the component repositories. It only manages release workflows and coordinates versioning across repositories. Each component repository (`system-rest` and `system-vue`) has its own independent CI/CD pipeline that handles testing, building, and deploying that specific component.

### 8.2 CI/CD Features

Both CI/CD pipelines include:

1. **Automated Testing**: Runs tests for both backend and frontend
2. **Docker Image Building**: Creates Docker images for all components
3. **Container Registry Integration**: Pushes images to container registries
4. **Multi-Environment Deployment**: Supports staging and production environments
5. **Pipeline Visualization**: Shows the flow of changes from commit to deployment
6. **Microservices-Oriented Pipelines**: Separate pipelines for frontend and backend
7. **Independent Deployments**: Each component can be deployed separately

### 8.3 GitHub Actions Setup

The GitHub Actions workflows are defined in:

- **system-demo**: `.github/workflows/release.yml` - Handles release management only
- **system-rest**: `.github/workflows/ci-cd.yml` - Full CI/CD pipeline for backend
- **system-vue**: `.github/workflows/ci-cd.yml` - Full CI/CD pipeline for frontend

Each workflow includes:

- **Test Stage**: Runs tests for the component
- **Build Stage**: Builds Docker images for the component
- **Deploy Stages**: Deploys to development, staging, and production environments based on branch

**Note**: The `ci-cd.yml` file in the system-demo repository is no longer needed and should be removed, as each component repository has its own CI/CD pipeline.

#### 8.3.1 GitHub Actions Demo Steps

1. **Create a GitHub Repository**:

   ```bash
   # Initialize git repository if not already done
   git init
   git add .
   git commit -m "Initial commit"

   # Create a new repository on GitHub and push
   git remote add origin https://github.com/YOUR_USERNAME/system-demo.git
   git push -u origin master
   ```

2. **Set Up GitHub Secrets**:

   - Go to your GitHub repository → Settings → Secrets and variables → Actions
   - Add the following secrets:
     - `DOCKER_HUB_USERNAME`: Your Docker Hub username
     - `DOCKER_HUB_TOKEN`: Your Docker Hub access token

3. **Trigger the Workflow**:

   ```bash
   # Prepare and push a demo change
   ./prepare-demo-change.sh
   # Select option 1 for GitHub
   ```

4. **Demo Features to Highlight**:
   - Workflow visualization
   - Job logs and artifacts
   - Environment deployments
   - Branch protection rules
   - Pull request integration

### 8.4 GitLab CI/CD Setup

The GitLab CI/CD pipelines are defined in:

- **system-demo**: `.gitlab-ci.yml` - Handles release management only
- **system-rest**: `.gitlab-ci.yml` - Full CI/CD pipeline for backend
- **system-vue**: `.gitlab-ci.yml` - Full CI/CD pipeline for frontend

Each pipeline includes:

- **Test Stage**: Runs tests for the component
- **Build Stage**: Builds Docker images for the component
- **Deploy Stages**: Deploys to development, staging, and production environments based on branch

**Note**: The CI/CD configuration in the system-demo repository has been simplified to focus only on release management, as each component repository has its own CI/CD pipeline.

#### 8.4.1 GitLab CI/CD Demo Steps

1. **Create a GitLab Project**:

   ```bash
   # Initialize git repository if not already done
   git init
   git add .
   git commit -m "Initial commit"

   # Create a new project on GitLab and push
   git remote add gitlab https://gitlab.com/YOUR_USERNAME/system-demo.git
   git push -u gitlab master
   ```

2. **Set Up GitLab CI/CD Variables**:

   - Go to your GitLab project → Settings → CI/CD → Variables
   - Add the following variables:
     - `SSH_PRIVATE_KEY`: SSH private key for deployment
     - `SSH_KNOWN_HOSTS`: SSH known hosts for the deployment server
     - `SSH_USER`: Username for SSH connection
     - `SSH_HOST_STAGING`: Hostname for staging server
     - `SSH_HOST_PROD`: Hostname for production server

3. **Trigger the Pipeline**:

   ```bash
   # Prepare and push a demo change
   ./prepare-demo-change.sh
   # Select option 2 for GitLab
   ```

4. **Key Talking Points**:
   - Microservices-oriented CI/CD with separate pipelines
   - Change-based execution with rules
   - Independent deployment environments
   - All-in-one DevOps platform
   - Built-in container registry
   - Advanced pipeline features

### 8.5 Comparing GitHub Actions vs GitLab CI/CD

| Feature                   | GitHub Actions  | GitLab CI/CD          |
| ------------------------- | --------------- | --------------------- |
| Ease of Use               | ★★★★☆           | ★★★☆☆                 |
| Feature Set               | ★★★☆☆           | ★★★★★                 |
| Free Tier                 | 2,000 min/month | 400 min/month         |
| Enterprise Cost           | $21/user/month  | $19/user/month        |
| Self-Hosted               | Custom pricing  | Free option available |
| **Microservices Support** | ★★★★☆           | ★★★★★                 |

### 8.6 ROI Talking Points

1. **Time Savings**: 10+ hours/week saved on manual testing and deployment
2. **Quality Improvement**: 30% reduction in production bugs
3. **Release Frequency**: From weekly to daily releases possible
4. **Developer Productivity**: 20% increase in feature development time
5. **Onboarding**: New developers productive 50% faster
6. **Independent Deployments**: Frontend can be updated 3x more frequently without touching backend

## 9. Project Structure

The project follows a multi-repository structure with separate components for frontend, backend, and coordination:

```
system-demo/                      # Coordinator repository
├── .github/                      # GitHub Actions configuration
│   └── workflows/
│       └── release.yml           # GitHub release workflow
├── .gitlab-ci.yml                # GitLab release pipeline
├── docker-compose.yml            # Container orchestration for all components
├── README.md                     # Project documentation (this file)
│
├── system-rest/                  # Backend component repository (separate Git repo)
│   ├── .github/workflows/        # GitHub Actions configuration for backend
│   │   └── ci-cd.yml             # Backend CI/CD pipeline
│   ├── .gitlab-ci.yml            # GitLab CI/CD pipeline for backend
│   ├── Dockerfile                # Backend container definition
│   ├── pom.xml                   # Maven project configuration
│   ├── src/                      # Source code
│   │   └── main/
│   │       ├── java/             # Java code
│   │       │   └── org/springframework/samples/system/  # Backend package structure
│   │       └── resources/        # Configuration files
│   └── target/                   # Compiled output
│
├── system-vue/                   # Frontend component repository (separate Git repo)
│   ├── .github/workflows/        # GitHub Actions configuration for frontend
│   │   └── ci-cd.yml             # Frontend CI/CD pipeline
│   ├── .gitlab-ci.yml            # GitLab CI/CD pipeline for frontend
│   ├── Dockerfile                # Frontend container definition
│   ├── package.json              # NPM dependencies
│   ├── src/                      # Source code
│   │   ├── components/           # Vue components
│   │   │   └── OwnersList.vue    # Main component for displaying owners
│   │   ├── App.vue               # Root Vue component
│   │   └── main.ts               # Application entry point
│   ├── tailwind.config.js        # Tailwind CSS configuration
│   └── dist/                     # Compiled output
│
├── demo-changes/                 # Demo resources for CI/CD
│   └── button-color-change.diff  # Sample change for CI/CD demo
│
├── cicd-demo-script.md           # Detailed script for CI/CD demos
├── prepare-demo-change.sh        # Script to prepare a demo change
├── setup-github-cicd.sh          # Script to set up GitHub CI/CD
└── setup-gitlab-cicd.sh          # Script to set up GitLab CI/CD
```

**Note**: The `.gitignore` file in the system-demo repository is configured to ignore the `system-rest/` and `system-vue/` directories, as they are separate Git repositories.

## 10. Next Steps (TODO)

This project has a one-month development timeline with the following key milestones:

### 10.1 Test-Driven Development (TDD) Implementation

1. **Backend TDD**:

   - Set up JUnit 5 and Mockito for backend testing
   - Implement unit tests for all service classes
   - Create integration tests for REST endpoints
   - Establish test coverage metrics (aim for 80%+ coverage)

2. **Frontend TDD**:

   - Implement Vue Testing Library and Jest for component testing
   - Create unit tests for all Vue components
   - Set up end-to-end testing with Cypress
   - Integrate test coverage reporting

3. **CI/CD Test Integration**:
   - Configure test automation in CI/CD pipelines
   - Set up test failure notifications
   - Implement quality gates based on test coverage

### 10.2 Versioning System

1. **Centralized Versioning Implementation**: ✅

   - ✅ Implement semantic versioning (MAJOR.MINOR.PATCH) in the system-demo repository
   - ✅ Display version number in UI (tooltip on hover over logo)
   - ✅ Include version in API responses
   - ✅ Create version history documentation

2. **Release Management**:

   - Set up automated release notes generation
   - ✅ Implement changelog tracking
   - Create release branches strategy
   - Establish version tagging in Git for the entire system

3. **Deployment Versioning**:
   - Tag Docker images with the system version number
   - Implement blue/green deployment for version updates
   - Create rollback procedures for version issues

### 10.3 Advanced Features

1. **Authentication and Authorization**:

   - Implement OAuth 2.0 / OpenID Connect
   - Set up role-based access control
   - Create user management interface
   - Implement secure API endpoints

2. **Performance Optimization**:

   - Set up performance testing with JMeter
   - Implement frontend bundle optimization
   - Configure database query optimization
   - Establish performance benchmarks

3. **Monitoring and Observability**:
   - Implement logging with ELK stack
   - Set up metrics collection with Prometheus
   - Create dashboards with Grafana
   - Implement alerting for critical issues

### 10.4 Documentation

1. **Developer Documentation**:

   - Create comprehensive API documentation
   - Document development setup procedures
   - Establish coding standards documentation
   - Create architecture decision records (ADRs)

2. **User Documentation**:
   - Create user guides for all features
   - Implement in-app help system
   - Create video tutorials for key workflows
   - Establish feedback collection mechanism

## 11. Troubleshooting

### 11.1 Common Issues and Solutions

1. **Frontend Not Starting**

   ```bash
   # Check if port 8080 is in use
   # Windows:
   netstat -ano | findstr "8080"
   # Mac/Linux:
   lsof -i :8080

   # Clear node_modules and reinstall
   cd system-vue
   rm -rf node_modules
   npm install
   ```

2. **Backend Not Starting**

   ```bash
   # Check logs
   docker-compose logs backend

   # Rebuild backend
   docker-compose build backend
   ```

3. **Database Issues**

   ```bash
   # Reset database
   docker compose down -v
   docker compose up database
   ```

4. **Network Issues**
   ```bash
   # Check if services can reach each other
   docker compose ps
   docker network ls
   ```

### 11.2 Quick Recovery

```bash
# Quick reset
docker compose down -v
docker compose up --build
```

## 12. Pre-Demo Checklist

### 12.1 Environment

- [ ] Docker Desktop running
- [ ] All ports available (8080, 9966, 5432)
- [ ] Stable internet connection
- [ ] Terminal/Command Prompt ready

### 12.2 Applications

- [ ] Backend API responding
- [ ] Frontend loading
- [ ] Database connected
- [ ] Swagger UI accessible

### 12.3 Demo Content

- [ ] Sample data prepared
- [ ] All CRUD operations tested
- [ ] UI responsive and styled
- [ ] Error scenarios tested

## 13. Support and Resources

### 13.1 Documentation Links

- Vue.js 3: https://vuejs.org/
- Tailwind CSS: https://tailwindcss.com/
- Font Awesome: https://fontawesome.com/
- Spring Boot: https://spring.io/projects/spring-boot
- PostgreSQL: https://www.postgresql.org/

### 13.2 Useful Commands Reference

```bash
# Start everything
docker compose up --build

# Start specific services
docker compose up database backend

# View logs
docker compose logs -f

# Stop everything
docker compose down

# Reset everything
docker compose down -v
docker compose up --build
```

## 14. Contributing to the Project

If you'd like to contribute to this project:

1. Fork the respective repositories on GitHub
2. Create a new branch for your feature
3. Make your changes
4. Submit a pull request

## 15. Known Issues and Limitations

- The edit functionality for owners is not fully implemented
- Mobile responsiveness could be improved for very small screens
- No authentication/authorization implemented yet

## 16. License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.
