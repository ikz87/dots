#!/bin/bash

bspc subscribe desktop_focus desktop_layout | while read line; do
	case `bspc query -T -d | jq -r .layout` in    
	    tall)    
	        echo "Tall"    
	        ;;    
	    tiled)    
	        echo ""    
	        ;;    
	    grid)
	        echo "Grid"    
	        ;;    
	    monocle)    
	        echo ""            ;;    
	    even)    
	        echo "Even"    
	        ;;    
	    *)    
	        echo "?"    
	        ;;    
esac;
done
