# My polybar dots

If you are using this, chances are not all scripts will work, I didn't think I'd ever share this so I never actually cared to write clean scripts, but here we are.

Colors for the bar will be picked up from your Xresources, so if the bar doesn't seem to be loading correctly or has errors regarding "unscaped backslashes", it's probably because there's something wrong with the colors (or maybe there IS something wrong with the config, but hey, it runs for me lol)

Layout and workspaces modules will only work on bspwm (they depend on bspc).

Font sizes are specifically set for a 1920x1080 screen
polybar's config doesn't include the thumbnail displayed on the left bar, since that's a program completely dettached from polybar (see polaybar/scripts/bappicons.sh).

## List of dependencies (probably incomplete):
-> xdo

-> xdotool

-> wmctrl

-> yad

-> FontAwesome

-> Caskaydia Cove Nerd Font (Any nerd font will work, but you'll need to change polybar's config)

-> CartographCF (You can change this one for any font of your liking)
