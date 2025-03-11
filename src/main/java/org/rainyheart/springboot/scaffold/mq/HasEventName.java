package org.rainyheart.springboot.scaffold.mq;

/**
 * Interface for MQ messages that have an event name
 * The event name is used as the routing key for message delivery
 */
public interface HasEventName {
    String getEventName();
}
