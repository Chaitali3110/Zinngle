# zinngle9

A Spring Boot application project.

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher

## Getting Started

### Build the Project

```bash
mvn clean install
```

### Run the Application

```bash
mvn spring-boot:run
```

Or run the main class `com.zinngle9.Zinngle9Application` directly from your IDE.

The application will start on `http://localhost:8080`

## API Endpoints

### Health Check
- `GET /api/health` - Returns the application health status

## Database

By default, the application uses H2 in-memory database for development. You can access the H2 console at:
- URL: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:zinngle9db`
- Username: `sa`
- Password: (empty)

## Project Structure

```
zinngle9/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── zinngle9/
│   │   │           ├── Zinngle9Application.java
│   │   │           └── controller/
│   │   └── resources/
│   │       ├── application.properties
│   │       └── application.yml
│   └── test/
│       └── java/
│           └── com/
│               └── zinngle9/
└── pom.xml
```

## Technology Stack

- Spring Boot 3.2.0
- Spring Web
- Spring Data JPA
- H2 Database (Development)
- PostgreSQL (Production ready)
- Lombok
- Maven

## Configuration

Application properties can be configured in:
- `src/main/resources/application.properties`
- `src/main/resources/application.yml`

## License

This project is for development purposes.
