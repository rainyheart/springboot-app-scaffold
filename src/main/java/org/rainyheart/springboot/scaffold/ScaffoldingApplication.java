/**
 * Create on Mar 11, 2025
 * 
 * Copyright (c) 2025 by Ken Ye.
 *
 * All Rights Reserved, Designed By Ken Ye
 *
 * Copyright:  Copyright(C) 2025-2035
 *
 * Company:    Ken Ye
 */
package org.rainyheart.springboot.scaffold;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

import org.rainyheart.springboot.scaffold.conf.PlatformConfigProperties;
import org.rainyheart.springboot.scaffold.util.SpringBootProfileEnvVarUtil;

/**
 * SpringBoot scaffolding project startup class
 */
@SpringBootApplication
@EnableConfigurationProperties({PlatformConfigProperties.class})
@ComponentScan(basePackages = "org.rainyheart.springboot.scaffold")
@EnableScheduling
public class ScaffoldingApplication {

    public static void main(String[] args) {
        SpringBootProfileEnvVarUtil.setupSpringProfile();
        SpringBootProfileEnvVarUtil.setHostName4Log4j();
        
        SpringApplication.run(ScaffoldingApplication.class, args);
    }
}
