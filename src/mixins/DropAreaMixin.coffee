export DropAreaMixin = (superclass) ->

    class extends superclass

        @properties:
            is_highlighted: { type: Boolean, reflect: true }
            current_node: { type: Object }

        constructor: (...args) ->
            super ...args

            # use this property as a css selector to style drop areas whenever a draggable is dragged
            @is_highlighted = false

            @current_node = null

            # add listener to highlight area
            document.addEventListener "gmt-drag-start", @drag_start.bind @
            document.addEventListener "gmt-drag-end", @drag_end.bind @

            # add drop listener
            @addEventListener "drop", @drop_into.bind @
            @addEventListener "dragover", @drag_over.bind @
            # dragleave may be implemented as well

        drag_start: (e)->
            @is_highlighted = true
            @current_node = e.path[0]

        drag_end: (e)->
            @is_highlighted = false

        drop_into: (e) ->
            # in case we are copying the html (drag and drop to copy)
            data = e.dataTransfer.getData "text/html"

            # in case we are re-alocating the node (full drag and drop)
            node = @current_node
            
            if( data )
                @innerHTML += data # copy element
            else 
                @appendChild node # move element
            
        drag_over: (e) ->
            # allow drop
            e.preventDefault() 
