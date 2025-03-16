# CI/CD Demo Script

This script will help you demonstrate the CI/CD capabilities of either GitHub Actions or GitLab CI/CD to your boss, with a focus on modern microservices-oriented pipelines.

## Preparation

### Before Demo Day

1. Set up your local repository with the CI/CD configurations:

   - For GitHub: Run `./setup-github-cicd.sh` and follow the prompts
   - For GitLab: Run `./setup-gitlab-cicd.sh` and follow the prompts

2. Configure the necessary secrets/variables in the respective platform:

   - GitHub: Add `DOCKER_HUB_USERNAME` and `DOCKER_HUB_TOKEN` secrets
   - GitLab: Add SSH-related variables for deployment

3. Verify that the initial push was successful and the repository is set up correctly

### On Demo Day

1. Open browser tabs for the platform you're demonstrating today
2. Have the demo script ready
3. Make sure you can access the repository and CI/CD sections

## Demo Flow

### 1. Introduction (2 minutes)

"Today I'll demonstrate how our system supports CI/CD with [GitHub Actions/GitLab CI/CD], showing how it can automate our testing, building, and deployment processes. Importantly, we've implemented a modern microservices-oriented approach with separate pipelines for our frontend and backend components."

### 2. CI/CD Overview (3 minutes)

"Our CI/CD pipeline provides these key capabilities:

- Automated testing of our backend and frontend
- Building and publishing Docker images
- Deploying to staging and production environments
- Pipeline visualization and monitoring
- **Separate pipelines for frontend and backend components**
- **Independent deployment capabilities for each component**"

### 3. Platform-Specific Demo (10 minutes)

#### For GitHub Actions:

##### Show Configuration

"Let me show you how GitHub Actions is configured:"

1. Open the GitHub repository
2. Navigate to `.github/workflows/ci-cd.yml`
3. Explain the key components:

   - Triggers (push to main/master, pull requests)
   - **Path-based filtering for frontend and backend**
   - **Separate test jobs for each component**
   - **Separate build jobs for each component**
   - **Independent deployment jobs for each component**

4. Highlight the microservices approach:
   - "We've implemented separate pipelines for frontend and backend, which is an industry best practice for microservices architectures"
   - "This allows our frontend and backend teams to work independently"
   - "Changes to one component don't trigger unnecessary builds of the other"
   - "We can deploy frontend updates without touching the backend, and vice versa"

##### Demonstrate a Change

"Now, let's see it in action by making a small change:"

1. Run `./prepare-demo-change.sh` and select GitHub Actions
2. Show the commit that was created
3. Push the change to GitHub
4. Navigate to the "Actions" tab
5. Show the workflow running in real-time
6. Explain each step as it executes
7. **Point out that only the frontend pipeline is running since we only changed frontend code**

##### Highlight Features

"GitHub Actions offers these advantages:

- Tight integration with GitHub's code hosting
- Simple YAML syntax
- Marketplace with pre-built actions
- Detailed logs and artifacts
- Environment deployments with approvals
- **Support for microservices with path-based filtering**
- **Parallel execution of independent pipelines**"

#### For GitLab CI/CD:

##### Show Configuration

"Let me show you how GitLab CI/CD is configured:"

1. Open the GitLab repository
2. Navigate to `.gitlab-ci.yml`
3. Explain the key components:

   - **Rules-based execution for frontend and backend components**
   - **Separate test jobs for each component**
   - **Separate build jobs for each component**
   - **Independent deployment jobs with separate environments**

4. Highlight the microservices approach:
   - "We've implemented separate pipelines for frontend and backend using GitLab's rules feature"
   - "Each component has its own deployment environments and URLs"
   - "Changes to one component don't trigger unnecessary builds of the other"
   - "We can deploy frontend updates without touching the backend, and vice versa"

##### Demonstrate a Change

"Let's see GitLab CI/CD in action:"

1. Run `./prepare-demo-change.sh` and select GitLab CI/CD
2. Show the commit that was created
3. Push the change to GitLab
4. Navigate to the "CI/CD" → "Pipelines" tab
5. Show the pipeline running in real-time
6. Explain each stage as it executes
7. **Point out that only the frontend pipeline is running since we only changed frontend code**

##### Highlight Features

"GitLab CI/CD offers these advantages:

- All-in-one platform for code, CI/CD, and issue tracking
- Built-in container registry
- Advanced pipeline features
- Environment tracking
- Auto DevOps capabilities
- Self-hosted option
- **Powerful rules-based pipeline execution**
- **Excellent support for microservices architectures**"

### 4. Benefits and ROI (5 minutes)

"Implementing this microservices-oriented CI/CD solution will provide significant benefits:

1. **Time Savings**: Automated testing and deployment saves 10+ hours per week
2. **Quality Improvement**: Catches issues earlier in the development cycle
3. **Faster Releases**: Reduces deployment time from hours to minutes
4. **Developer Satisfaction**: Eliminates repetitive manual tasks
5. **Consistency**: Ensures the same process is followed every time
6. **Team Autonomy**: Frontend and backend teams can work and deploy independently
7. **Faster Frontend Iterations**: UI can be updated 3x more frequently without backend changes
8. **Reduced Risk**: Issues in one component don't block deployments of the other"

### 5. Q&A (5 minutes)

"Do you have any questions about the CI/CD solution I've demonstrated?"

## Follow-up

After the demo, be prepared to:

1. Provide more detailed information on pricing
2. Discuss integration with existing tools
3. Talk about implementation timeline
4. Address any security concerns
5. Provide references or case studies
6. **Explain how this approach scales to more microservices**
7. **Discuss monitoring and observability for microservices**
