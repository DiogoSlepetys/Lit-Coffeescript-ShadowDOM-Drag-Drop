import {LitElement, css, html} from 'lit-element'

export class DraggableContainer extends LitElement

    @properties:
        isCopyable: {type: Boolean}

    constructor: ->
        super()
        # make component draggable
        this.setAttribute "draggable", "true"

        # add listeners to handle drag
        this.addEventListener "dragstart", this.__dragStart.bind this
        this.addEventListener "dragend", this.__dragEnd.bind this
        this.addEventListener "drop", this.__dragEnd.bind this

        # this property specifies if the element will be copied(true) or fully moved(false)
        @isCopyable = false;

    __dragStart: (e) ->
        # drag has started, we should dispatch an event so drop areas become highlighted
        this.dispatchEvent new Event('gmt-drag-start', { bubbles: true, composed: true })
        
        if @isCopyable == true
            # if we want a copy of the element, we can send the outerHTML and append it to the drop area
            e.dataTransfer.setData("text/html", e.target.outerHTML);
        else
            # in case we need to move the element, we must give it a temporary id or attribute
            e.target.id = "dragged"

    __dragEnd: (e) ->
        # drag has started, we should dispatch an event so drop areas get back to normal
        this.dispatchEvent new Event('gmt-drag-end', { bubbles: true, composed: true })

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