package org.rainyheart.springboot.scaffold.util;

import org.apache.commons.lang3.StringUtils;
import org.rainyheart.springboot.scaffold.constants.EnvVarConstant;

public class SpringBootProfileEnvVarUtil {

    private SpringBootProfileEnvVarUtil() {
        super();
    }

    private static final String SPRING_PROFILES_ACTIVE = "spring.profiles.active";

    public static void setupSpringProfile() {
        String springProfile = System.getProperty(SPRING_PROFILES_ACTIVE);
        String jvmArgEnv = System.getProperty(EnvVarConstant.ENV);
        String osEnv = System.getenv(EnvVarConstant.ENV);
        if (StringUtils.isNotEmpty(springProfile)) {
            System.setProperty(SPRING_PROFILES_ACTIVE, springProfile);
            System.out.println("Spring Profile: -D" + SPRING_PROFILES_ACTIVE + "=" + springProfile);
        } else if (StringUtils.isNotEmpty(jvmArgEnv)) {
            System.setProperty(SPRING_PROFILES_ACTIVE, jvmArgEnv);
            System.out.println("Spring Profile: -D" + EnvVarConstant.ENV + "=" + jvmArgEnv);
        } else if (StringUtils.isNotEmpty(osEnv)) {
            System.setProperty(SPRING_PROFILES_ACTIVE, osEnv);
            System.out.println("Spring Profile: $" + EnvVarConstant.ENV + "=" + osEnv);
        } else {
            System.setProperty(SPRING_PROFILES_ACTIVE, "sat");
            System.out.println("Spring Profile: " + SPRING_PROFILES_ACTIVE + "=sat");
        }
    }

    public static final void setHostName4Log4j() {
        String hostname = System.getenv(EnvVarConstant.HOSTNAME);
        if (hostname == null) {
            hostname = EnvVarConstant.LOCALHOST;
        }
        System.setProperty(EnvVarConstant.HOSTNAME, hostname);
    }
}
