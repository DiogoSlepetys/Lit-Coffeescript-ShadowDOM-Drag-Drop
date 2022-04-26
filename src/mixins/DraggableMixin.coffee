export DraggableMixin = (superclass) ->

    class extends superclass

        @properties:
            isCopyable: {type: Boolean}

        constructor: (...args) ->
            super ...args

            # make component draggable
            this.setAttribute "draggable", "true"

            # add listeners to handle drag
            this.addEventListener "dragstart", this.__dragStart.bind this
            this.addEventListener "dragend", this.__dragEnd.bind this
            this.addEventListener "drop", this.__dragEnd.bind this

            # this property specifies if the element will be copied(true) or fully moved(false) on drop
            @isCopyable = false;

        __dragStart: (e) ->
            # drag has started, we should dispatch an event so drop areas become highlighted
            this.dispatchEvent new Event('gmt-drag-start', { bubbles: true, composed: true })
            
            if @isCopyable == true
                # if we want a copy of the element, we can send the outerHTML and append it to the drop area
                e.dataTransfer.setData("text/html", e.target.outerHTML);
            else
                # in case we need to move the element, we must give it a temporary id or attribute
                # so it can be found in the dom by the drop area
                e.target.id = "dragged"

        __dragEnd: (e) ->
            # drag has started, we should dispatch an event so drop areas get back to normal
            this.dispatchEvent new Event('gmt-drag-end', { bubbles: true, composed: true })