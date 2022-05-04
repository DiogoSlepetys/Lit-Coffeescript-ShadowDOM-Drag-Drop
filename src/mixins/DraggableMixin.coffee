export DraggableMixin = (superclass) ->

    class extends superclass

        @properties:
            is_copyable: { type: Boolean }

        constructor: (...args) ->
            super ...args

            # make component draggable
            @setAttribute "draggable", "true"

            # add listeners to handle drag
            @addEventListener "dragstart", @drag_start.bind @
            @addEventListener "dragend", @drag_end.bind @
            @addEventListener "drop", @drag_end.bind @

            # this property specifies if the element will be copied(true) or fully moved(false) on drop
            @is_copyable = false

        drag_start: (e) ->
            # drag has started, we should dispatch an event so drop areas become highlighted
            this.dispatchEvent new Event('gmt-drag-start', { bubbles: true, composed: true })
            
            if @is_copyable == true
                # if we want a copy of the element, we can send the outerHTML and append it to the drop area
                e.dataTransfer.setData("text/html", e.target.outerHTML);

        drag_end: (e) ->
            # drag has finished, we should dispatch an event so drop areas get back to normal
            this.dispatchEvent new Event('gmt-drag-end', { bubbles: true, composed: true })