# Building Blocks of the Scaffolding Project

This document explains the key components of the scaffolding project and how to use them.

## 1. Application Entry Point
- The [ScaffoldingApplication](cci:2://file:///c:/Sandbox/springboot-app-scaffold/src/main/java/org/rainyheart/springboot/scaffold/ScaffoldingApplication.java:0:0-0:0) class is the main entry point. Extend it to add your application logic.

## 2. Exception Handling
- Use the [ApplicationException](cci:2://file:///c:/Sandbox/springboot-app-scaffold/src/main/java/org/rainyheart/springboot/scaffold/exception/ApplicationException.java:0:0-0:0) class for consistent error handling.

## 3. Common Utilities
- The [Symbol](cci:2://file:///c:/Sandbox/springboot-app-scaffold/src/main/java/org/rainyheart/springboot/scaffold/common/Symbol.java:17:0-52:1) class provides reusable constants for common symbols.

## 4. Logging Configuration
- Customize the `log4j-*.xml` files for environment-specific logging.
