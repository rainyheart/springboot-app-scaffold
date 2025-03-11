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
package org.rainyheart.springboot.scaffold.conf;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "platform")
public class PlatformConfigProperties {
    private String baseUrl;

	public String getBaseUrl() {
		return baseUrl;
	}

	public void setBaseUrl(String baseUrl) {
		this.baseUrl = baseUrl;
	}
}
