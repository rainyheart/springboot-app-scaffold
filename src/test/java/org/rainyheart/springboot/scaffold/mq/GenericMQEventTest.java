package org.rainyheart.springboot.scaffold.mq;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class GenericMQEventTest {

    @Test
    void getEventName_ShouldReturnClassName() {
        // Given
        TestMQEvent testEvent = new TestMQEvent("test message");

        // When
        String eventName = testEvent.getEventName();

        // Then
        assertEquals("TestMQEvent", eventName, "Event name should match the class name");
    }

    @Test
    void testMQEvent_MessageHandling() {
        // Given
        String testMessage = "Hello MQ";
        TestMQEvent testEvent = new TestMQEvent(testMessage);

        // When
        String retrievedMessage = testEvent.getMessage();

        // Then
        assertEquals(testMessage, retrievedMessage, "Message content should match");

        // When updating message
        String newMessage = "Updated message";
        testEvent.setMessage(newMessage);

        // Then
        assertEquals(newMessage, testEvent.getMessage(), "Updated message should match");
    }
}
