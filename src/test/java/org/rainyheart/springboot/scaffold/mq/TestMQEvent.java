package org.rainyheart.springboot.scaffold.mq;

/**
 * Test MQ Event class for unit testing
 */
public class TestMQEvent extends GenericMQEvent {
    private static final long serialVersionUID = 1L;
    
    private String message;
    
    public TestMQEvent(String message) {
        this.message = message;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
}
