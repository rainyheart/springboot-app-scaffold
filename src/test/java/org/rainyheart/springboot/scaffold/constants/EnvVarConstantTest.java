package org.rainyheart.springboot.scaffold.constants;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class EnvVarConstantTest {

    @Test
    void verifyEnvironmentVariableNames() {
        // Verify environment variable names match our new naming convention
        assertEquals("env", EnvVarConstant.ENV, "Environment variable should use new naming");
        assertEquals("hostname", EnvVarConstant.HOSTNAME, "Hostname variable should be lowercase");
        assertEquals("localhost", EnvVarConstant.LOCALHOST, "Default hostname should be localhost");
    }

    @Test
    void verifyEnvironmentNames() {
        // Verify environment names are consistent
        assertEquals("uat", EnvVarConstant.ENV_UAT, "UAT environment name should be lowercase");
        assertEquals("sat", EnvVarConstant.ENV_SAT, "SAT environment name should be lowercase");
        assertEquals("pre", EnvVarConstant.ENV_PRE, "PRE environment name should be lowercase");
    }
}
