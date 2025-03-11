package org.rainyheart.springboot.scaffold.util;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.rainyheart.springboot.scaffold.constants.EnvVarConstant;

import static org.junit.jupiter.api.Assertions.assertEquals;

class SpringBootProfileEnvVarUtilTest {

    private static final String SPRING_PROFILES_ACTIVE = "spring.profiles.active";

    @BeforeEach
    void setUp() {
        // Clear any existing system properties
        System.clearProperty(SPRING_PROFILES_ACTIVE);
        System.clearProperty(EnvVarConstant.ENV);
        System.clearProperty(EnvVarConstant.HOSTNAME);
    }

    @AfterEach
    void tearDown() {
        // Clean up after each test
        System.clearProperty(SPRING_PROFILES_ACTIVE);
        System.clearProperty(EnvVarConstant.ENV);
        System.clearProperty(EnvVarConstant.HOSTNAME);
    }

    @Test
    void setupSpringProfile_WhenSpringProfilesActiveSet() {
        // Given
        System.setProperty(SPRING_PROFILES_ACTIVE, "uat");

        // When
        SpringBootProfileEnvVarUtil.setupSpringProfile();

        // Then
        assertEquals("uat", System.getProperty(SPRING_PROFILES_ACTIVE));
    }

    @Test
    void setupSpringProfile_WhenJvmEnvSet() {
        // Given
        System.setProperty(EnvVarConstant.ENV, "pre");

        // When
        SpringBootProfileEnvVarUtil.setupSpringProfile();

        // Then
        assertEquals("pre", System.getProperty(SPRING_PROFILES_ACTIVE));
    }

    @Test
    void setupSpringProfile_WhenNoEnvironmentSet() {
        // When
        SpringBootProfileEnvVarUtil.setupSpringProfile();

        // Then
        assertEquals("sat", System.getProperty(SPRING_PROFILES_ACTIVE));
    }

    @Test
    void setHostName4Log4j_WhenHostnameNotSet() {
        // When
        SpringBootProfileEnvVarUtil.setHostName4Log4j();

        // Then
        assertEquals(EnvVarConstant.LOCALHOST, System.getProperty(EnvVarConstant.HOSTNAME));
    }
}
