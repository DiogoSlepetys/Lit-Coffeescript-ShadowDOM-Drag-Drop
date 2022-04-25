import {LitElement, css, html} from 'lit-element'

export class DraggableContainer extends LitElement

    constructor: ->
        super()
        # make component draggable
        this.setAttribute "draggable", "true"

        # add listeners to handle drag
        this.addEventListener "dragstart", this.__dragStart.bind this
        this.addEventListener "dragend", this.__dragEnd.bind this
        this.addEventListener "drop", this.__dragEnd.bind this

    __dragStart: (e) ->
        # drag has started, we should dispatch an event so drop areas become highlighted
        this.dispatchEvent new Event('gmt-drag-start', { bubbles: true, composed: true })
        e.dataTransfer.setData("text/html", e.target.outerHTML);

    __dragEnd: ->
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
        html"""<p>Drag Moi!</p>"""
  
customElements.define 'draggable-container', DraggableContainer