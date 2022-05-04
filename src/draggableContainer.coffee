import {LitElement, css, html} from 'lit-element'

export class DraggableContainer extends LitElement

    @properties:
        is_copyable: { type: Boolean }

    constructor: ->
        super()
        # make component draggable
        @setAttribute "draggable", "true"

        # add listeners to handle drag
        @addEventListener "dragstart", @drag_start.bind @
        @addEventListener "dragend", @drag_end.bind @
        @addEventListener "drop", @drag_end.bind @

        # this property specifies if the element will be copied(true) or fully moved(false)
        @is_copyable = false;

    drag_start: (e) ->
        # drag has started, we should dispatch an event so drop areas become highlighted
        @dispatchEvent new Event("gmt-drag-start", { bubbles: true, composed: true })
        
        if @is_copyable == true
            # if we want a copy of the element, we can send the outerHTML and append it to the drop area
            e.dataTransfer.setData("text/html", e.target.outerHTML);

    drag_end: (e) ->
        # drag has started, we should dispatch an event so drop areas get back to normal
        @dispatchEvent new Event("gmt-drag-end", { bubbles: true, composed: true })

    @styles:
        css"""
            :host{
                display: block;
                background-color: #67d;
                margin: 1vh;

                cursor: grab;
            }
        """

    render: ->
        html"""<p>Drag Moi! <slot></slot></p>"""
  
customElements.define 'draggable-container', DraggableContainer