package org.rainyheart.springboot.scaffold.mq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.stereotype.Component;

/**
 * Base class for initializing and binding RabbitMQ topic exchanges
 * Handles the creation of exchanges and bindings with queues
 */
@Component
public class TopicExchangeMQInitializer {
    
    private static Logger log = LoggerFactory.getLogger(TopicExchangeMQInitializer.class);

    private void initExchange(String exchangeName, String queueName, String recycleQueue, String routeKey, AmqpAdmin amqpAdmin) {
        if(log.isDebugEnabled()) {
            log.debug("exchangeName={}, queueName={}, recycleQueue={}, routeKey={}, amqpAdmin={}", exchangeName, queueName, recycleQueue, routeKey, amqpAdmin);
        }
        
        TopicExchange exchange = new TopicExchange(exchangeName, true, false);
        amqpAdmin.declareExchange(exchange);
    }

    protected void initBinding(String exchangeName, String queueName, String recycleQueue, String routeKey, AmqpAdmin amqpAdmin) {
        if(log.isDebugEnabled()) {
            log.debug("exchangeName={}, queueName={}, recycleQueue={}, routeKey={}, amqpAdmin={}", exchangeName, queueName, recycleQueue, routeKey, amqpAdmin);
        }
        
        String destination = queueName;
        Binding binding = new Binding(destination, Binding.DestinationType.QUEUE, exchangeName, routeKey, null);
        amqpAdmin.declareBinding(binding);
    }

    public static TopicExchangeMQInitializer newOne() {
        return new TopicExchangeMQInitializer();
    }

    public void build(String exchangeName, String queueName, String recycleQueue, String routeKey, AmqpAdmin amqpAdmin) {
        this.initExchange(exchangeName, queueName, recycleQueue, routeKey, amqpAdmin);
        this.initBinding(exchangeName, queueName, recycleQueue, routeKey, amqpAdmin);
    }
}
