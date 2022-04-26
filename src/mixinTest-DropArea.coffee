import {LitElement, css, html} from 'lit-element'
import {DropAreaMixin} from './mixins/DropAreaMixin.coffee'

export class MixinTestDropArea extends DropAreaMixin(LitElement)

    constructor: ->
        super()

    @styles:
        css"""
            :host{
                margin: 1vh;
                display: block;
                min-width: 7vh;
                min-height: 7vh;
                background-color: grey
            }

            :host([isHighlighted]){
                min-width: 8vh;
                min-height: 8vh;
                background-color: pink
            }
        """

    render: ->
        html"""<div>Drop Here, i'm using the Mixin!<slot></slot></div>"""
  
customElements.define 'mixin-test-drop-area', MixinTestDropArea