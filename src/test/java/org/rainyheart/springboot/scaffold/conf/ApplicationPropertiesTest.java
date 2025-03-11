package org.rainyheart.springboot.scaffold.conf;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles("test")
class ApplicationPropertiesTest {

    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${server.servlet.context-path}")
    private String contextPath;

    @Value("${spring.rabbitmq.host}")
    private String rabbitMqHost;

    @Value("${spring.rabbitmq.username}")
    private String rabbitMqUsername;

    @Value("${spring.rabbitmq.virtual-host}")
    private String rabbitMqVirtualHost;

    @Test
    void verifyApplicationProperties() {
        // Verify application name and context path
        assertEquals("springboot-app-scaffold", applicationName, "Application name should match");
        assertEquals("/springboot-app-scaffold", contextPath, "Context path should match");

        // Verify RabbitMQ configuration
        assertEquals("rabbitmq-sat", rabbitMqHost, "RabbitMQ host should match environment");
        assertEquals("admin", rabbitMqUsername, "RabbitMQ username should be generic");
        assertEquals("satVHost", rabbitMqVirtualHost, "RabbitMQ virtual host should match environment");
    }
}
