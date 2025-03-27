# Spring Boot Scaffolding Project

A Spring Boot-based scaffolding project designed to provide a robust foundation for building enterprise-grade applications. This project includes essential configurations, utilities, and best practices to kickstart your development process.

## Features
- **Standard Spring Boot Setup**: Includes a main application class with `@SpringBootApplication` and `@EnableConfigurationProperties` annotations.
- **Environment-Specific Logging**: Pre-configured `log4j` files for UAT, SAT, and PRE environments.
- **Custom Exception Handling**: Includes a base [ApplicationException](cci:2://file:///c:/Sandbox/springboot-app-scaffold/src/main/java/org/rainyheart/springboot/scaffold/exception/ApplicationException.java:16:0-31:1) class for consistent error handling.
- **Common Utilities**: Provides reusable constants for common symbols via the [Symbol](cci:2://file:///c:/Sandbox/springboot-app-scaffold/src/main/java/org/rainyheart/springboot/scaffold/common/Symbol.java:17:0-52:1) class.

## Getting Started
1. Clone the repository.
2. Configure your environment-specific properties.
3. Run the application using `mvn spring-boot:run`.

## Project Structure
```
src/
├── main/
│   ├── java/
│   │   └── org/rainyheart/springboot/scaffold/
│   │       ├── ScaffoldingApplication.java
│   │       ├── exception/
│   │       │   └── ApplicationException.java
│   │       └── common/
│   │           └── Symbol.java
│   └── resources/
│       ├── log4j-pre.xml
│       ├── log4j-sat.xml
│       └── log4j-uat.xml
└── test/
    └── resources/
        └── log4j-test.xml
```

## License
Copyright (c) 2025 by Ken Ye. All Rights Reserved.

# springboot-app-scaffold

A Spring Boot application scaffold providing essential configurations and utilities for rapid development of enterprise applications.

## Features

- Environment-based configuration management
- Jenkins pipeline integration for multiple environments (UAT, SAT, PRE)
- Kubernetes deployment configurations
- Docker containerization support
- Health check and monitoring integration
- Automated deployment scripts
- Automatic Docker image cleanup

## Project Structure

```
.
├── src/                          # Source code
├── devops/                       # DevOps related configurations
│   ├── k8s/                     # Kubernetes deployment files
│   └── scripts/                 # Deployment and maintenance scripts
├── Jenkinsfile_*                # Jenkins pipeline configurations
└── pom.xml                      # Maven configuration
```

## Environment Configuration

The application supports multiple deployment environments:
- UAT (User Acceptance Testing)
- SAT (System Acceptance Testing)
- PRE (Pre-production)

Environment is configured via the `ENV` environment variable.

### Application Paths

- Context Path: `/springboot-app-scaffold`
- Health Check: `/springboot-app-scaffold/health`
- Prometheus Metrics: `/springboot-app-scaffold/prometheus`
- Logs: `/nfs-k8s/shared/logs/springboot-app-scaffold/k8s/{env}`
- JVM Monitoring: `/nfs-k8s/shared/jvm/springboot-app-scaffold/k8s/{env}`

## Build and Deployment

### Prerequisites

- JDK 8
- Maven 3.6.3+
- Docker
- Kubernetes cluster

### Build

```bash
mvn clean package
```

### Local Development

```bash
mvn spring-boot:run -Denv=local
```

### Deployment

The project includes automated deployment pipelines for different environments:

1. UAT Environment:
   ```bash
   # Triggered via Jenkins
   ENV=uat ./devops/scripts/deploy.sh
   ```

2. SAT Environment:
   ```bash
   # Triggered via Jenkins
   ENV=sat ./devops/scripts/deploy.sh
   ```

3. PRE Environment:
   ```bash
   # Triggered via Jenkins
   ENV=pre ./devops/scripts/deploy.sh
   ```

## Docker Support

Docker images are built and tagged according to the environment:
```
springboot-app-scaffold-{env}:v{BUILD_NUMBER}
```

### Docker Image Housekeeping

The project includes automatic cleanup of old Docker images to prevent disk space issues. This is configured through:

- Script: `devops/scripts/docker-housekeep-image.sh`
- Environment Variables:
  - `DOCKER_IMAGE_NAME`: Name of the Docker image to clean up (e.g., `springboot-app-scaffold-uat`)
  - `KEEP_VERSIONS`: Number of recent versions to keep (default: 3)

## Monitoring

The application includes built-in monitoring endpoints:
- Health check: `/springboot-app-scaffold/health`
- Monitoring: `/springboot-app-scaffold/monitoring`

These endpoints are automatically registered with the monitoring system during deployment.

## Contributing

1. Follow the standard Java code style
2. Write unit tests for new features
3. Update documentation as needed
4. Submit pull requests for review

## License

This project is licensed under the MIT License - see the LICENSE file for details