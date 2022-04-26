
Simple drag and drop with Lit webcomponents and Coffeescript.

    -> npm install
    -> npm start

The component tags are named 'drop-area' and 'draggable-container'. They are slotted and can be used as containers for other components.

Another option is to use Mixins. They are named 'DraggableMixin' and 'DropAreaMixin' and can make any component a draggable or a drop-area.

  Draggables can be either moved or copied when dropped into a drop area. To create a copy, the property used is: isCopyable="true"
