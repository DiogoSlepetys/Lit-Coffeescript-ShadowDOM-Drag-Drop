import {LitElement, css, html} from 'lit-element'
import {DraggableMixin} from './mixins/DraggableMixin.coffee'

export class MixinTestDraggable extends DraggableMixin(LitElement)

    constructor: ->
        super()

    @styles:
        css"""
            :host{
                margin: 1vh;
            }
        """

    render: ->
        html"""<button>Drag me, I'm using the Mixin</button>"""
  
customElements.define 'mixin-test-draggable', MixinTestDraggable