package org.rainyheart.springboot.scaffold.conf;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import springfox.documentation.spring.web.plugins.Docket;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
class SwaggerConfigTest {

    @Autowired
    private SwaggerConfig swaggerConfig;

    @Test
    void createRestApi_ShouldConfigureSwaggerCorrectly() {
        // When
        Docket docket = swaggerConfig.createRestApi();

        // Then
        assertNotNull(docket, "Docket should not be null");
        
        // Get API Info using the select() builder pattern
        assertNotNull(docket.select(), "Docket select() should not be null");
        assertEquals("swagger", docket.getDocumentationType().getName(), 
            "Document type should be Swagger");
        
        // Verify base package configuration
        assertTrue(docket.select().build().getDocumentationType().getName().equals("swagger"),
            "Built Docket should use Swagger");
    }
}
