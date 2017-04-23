import homeassistant.loader as loader
import logging
from homeassistant.components import (input_select, group, light)

_LOGGER = logging.getLogger(__name__)

# The domain of your component. Should be equal to the name of your component.
DOMAIN = "light_state"

# List of component names (string) your component depends upon.
DEPENDENCIES = ['mqtt']

CONF_TOPIC = 'topic'
DEFAULT_TOPIC = 'voice/bedroom/#'

ATTR_LIGHT_STATE_CHANGE = 'light_state'
DEFAULT_LIGHT_STATE_CHANGE = 'off'

def setup(hass, config):
    """Setup the Hello MQTT component."""
    _hass = hass
    mqtt = loader.get_component('mqtt')
    topic = config[DOMAIN].get('topic', DEFAULT_TOPIC)
    entity_id = 'light_state.last_color'
    _LOGGER.info("The 'light_state' component is ready!")

    # Listener to be called when we receive a message.
    def message_received(topic, payload, qos):
        """A new MQTT message has been received."""
        _hass.states.set(entity_id, payload)
        _LOGGER.info("light_state received an mqtt event")
        _LOGGER.info("light_state.message_received called with var: %s" % payload.title())
        input_select.select_option(_hass, "input_select.scene_bedroom", payload.title())
        
    # Subscribe our listener to a topic.
    mqtt.subscribe(_hass, topic, message_received)

    # Set the intial state
    _hass.states.set(entity_id, 'OFF')

    def handle_light_state_change(call):
        new_light_state = call.data.get(ATTR_LIGHT_STATE_CHANGE, DEFAULT_LIGHT_STATE_CHANGE)
        _LOGGER.info("light_state.handle_light_state_change called")
        _LOGGER.info("light_state.handle_light_state_change called with var: %s" % new_light_state)
        input_select.select_option(_hass, "input_select.scene_bedroom", new_light_state)
#select_option(_hass, entity_id, option)        
    _hass.services.register(DOMAIN, 'light_state_change', handle_light_state_change)


    
    # Service to publish a message on MQTT.
#    def set_state_service(call):
#        """Service to send a message."""
#        mqtt.publish(hass, topic, call.data.get('new_state'))

    # Register our service with Home Assistant.
#    hass.services.register(DOMAIN, 'set_state', set_state_service)

    # Return boolean to indicate that initialization was successfully.
    return True
