package org.rainyheart.springboot.scaffold.conf;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * SwaggerUI URL: http://host:port/app-context-root/swagger-ui.html
 * 
 * @author Ken Ye
 *
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig {
    @Bean
    public Docket createRestApi() {
        Docket docket = new Docket(DocumentationType.SWAGGER_2);

        return docket.apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("org.rainyheart.springboot.scaffold"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("Spring Boot Application Scaffold API")
                .description("Spring Boot Application Scaffold API Documentation")
                .version("1.0")
                .build();
    }
}
