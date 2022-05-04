import {LitElement, css, html} from 'lit-element'

export class DropArea extends LitElement

    @properties:
        is_highlighted: {type: Boolean, reflect: true }
        current_node: { type: Object }

    constructor: ->
        super()

        # use this property as a css selector to style drop areas whenever a draggable is dragged
        @is_highlighted = false;

        @current_node = null

        # add listener to highlight area
        document.addEventListener "gmt-drag-start", @drag_start.bind @
        document.addEventListener "gmt-drag-end", @drag_end.bind @

        # add drop listener
        @addEventListener "drop", @drop_into.bind @
        @addEventListener "dragover", @drag_over.bind @
        # dragleave may be implemented as wells

    drag_start: (e) ->
        @is_highlighted = true
        @current_node = e.path[0]

    drag_end: ->
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
        # Allow drop
        e.preventDefault(); 

    @styles:
        css"""
            :host {
                display: grid;
                grid-column-template: auto auto;
                background-color: #234;
                margin: 0;
            }
            :host([isHighlighted]) { 
                background-color: #eee; 
                box-shadow: inset 2px 2px 2px #000;
            }
        """

    render: ->
        html"""<div>Drop Here! <slot></slot></div>"""
  
customElements.define 'drop-area', DropArea