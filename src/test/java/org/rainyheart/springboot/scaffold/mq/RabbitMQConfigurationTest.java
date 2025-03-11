package org.rainyheart.springboot.scaffold.mq;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
class RabbitMQConfigurationTest {

    @Autowired
    private DirectExchangeMQInitializer directExchangeMQInitializer;

    @Autowired
    private TopicExchangeMQInitializer topicExchangeMQInitializer;

    @MockBean
    private RabbitTemplate rabbitTemplate;

    @MockBean
    private AmqpAdmin amqpAdmin;
    
    @Test
    void verifyMQInitializersExist() {
        // Verify MQ initializers are created
        assertNotNull(directExchangeMQInitializer, "Direct exchange initializer should exist");
        assertNotNull(topicExchangeMQInitializer, "Topic exchange initializer should exist");
    }

    @Test
    void testMessageSending() {
        // TODO
    }
}
