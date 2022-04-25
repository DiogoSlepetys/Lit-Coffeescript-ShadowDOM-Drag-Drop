import {LitElement, css, html} from 'lit-element'

export class DropArea extends LitElement

    @properties:
        isHighlighted: {type: Boolean, reflect: true }

    constructor: ->
        super()

        @isHighlighted = false;

        # add listener to highlight area
        document.addEventListener "gmt-drag-start", this.__dragStart.bind this
        document.addEventListener "gmt-drag-end", this.__dragEnd.bind this

        # add drop listener
        this.addEventListener "drop", this.__dropInto.bind this
        this.addEventListener "dragover", this.__dragOver.bind this
        # dragleave may be implemented as wells

    __dragStart: ->
        this.isHighlighted = true

    __dragEnd: ->
        @isHighlighted = false

    __dropInto: (e) ->
        # the element is added to the html directly, we may want to add it to a container
        # and specify other drop functionalities
        
        # in case we are copying the html (drag and drop to copy)
        data = e.dataTransfer.getData "text/html"

        # in case we are re-alocating the node (full drag and drop)
        node = document.querySelector("#dragged");
        
        if( node == null )
            this.innerHTML += data # copy element
        else 
            node.id = "" # remove id that was added by draggableContainer
            this.appendChild node # move element
           

    __dragOver: (e) ->
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