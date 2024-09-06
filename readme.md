# Changelog :)

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](htt ps://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [beta 0.08] - 2024-09-06

### Added
- Shadow for towers with a setting to control it
- Lock to upgrade paths so only 2 of the 3 can be upgraded 




## [beta 0.08] - 2024-09-05

### Added
- Screen at end of level on win or loss
- Pencil sprite now changed to have a rocket if upgradeLevel3 >= 3
- Menu for status and enemy in the Encyclopedia
- New UI for wave/health/cash

### Optimization
- Doesnt constantly check if health <= 0 in global script and now only checks when health is depleted
- Most groups of sprites that could be put into a sprite sheet and it make sense have been
- Removed 'pertys on screen' text and a useless variable change

### Removed
- firewall2 and firewall3



## [beta 0.07] - 2024-09-04

### Added
- Delta in calculations to finally allow fps to be different (took a while why i didnt do it earlier idk)
- snake_case now not camelCase why did i put camelCase with godot. godot uses snake_case god it was such a pain changing it a lot is still not so now i have camelCase and snake_case whafkuawfouawf
- Changing speed now increases hitbox size so things dont go over enemies
- Indicate where enemies will start spawning with a green box and where they will end with a red box

### Optimization
- Optimized code for enemy ai by reducing amount of checks
- Check at the start of tower shooting script to reduce lag (maybe?)


### Changes
- Changed debug text to display with one text node not multiple

### Fixes
- Stacking towers is now not possible again

### Removed
- Boss fight music and reference in code it had no uses and only wasted RAM
- Banana image.. it was getting loaded in and i realised.. huh... maybe a 23MiB file isnt necessary.. hmm...



## [beta 0.06] - 2024-09-03

### Added
- On GitHub now yay
