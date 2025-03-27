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
package org.rainyheart.springboot.scaffold.exception;

/**
 * Application exception
 */
public class ApplicationException extends RuntimeException {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 1L;

    public ApplicationException(String message, Throwable cause) {
        super(message, cause);
    }

    public ApplicationException(String message) {
        super(message);
    }

}
