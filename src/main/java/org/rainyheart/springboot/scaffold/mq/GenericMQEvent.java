package org.rainyheart.springboot.scaffold.mq;

import java.io.Serializable;

/**
 * Base class for MQ messages
 * Uses the class name as the event name for routing
 */
public abstract class GenericMQEvent implements HasEventName, Serializable {

    private static final long serialVersionUID = -1987003738747133726L;

    protected GenericMQEvent() {
        super();
    }

    @Override
    public String getEventName() {
        return this.getClass().getSimpleName();
    }
}
