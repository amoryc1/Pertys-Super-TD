# Changelog :)

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [beta 0.12] - 2024-09-09

### Added
- Way to add events at the start of a wave (like a text box appearing) inside the level editor. But are not functional yet

### Changes
- Some code in the level editor (whatever i was on while making that id like rn)
- Camo layer of Airplane Sniper now shows behind the hand layer
- You can now scroll the enemy list in the level editor

### Fixes
- Airplane Sniper is now fully red if unable to be purchased




## [beta 0.11] - 2024-09-08

- I have school starting tommorow so updates are slowing down after today

### Added
- NEW TOWER: Airplane Sniper, has infinite range and a randomly assigned camo pattern from 5 choices
- Upgrade sprites for: Glue Gunner, Flamethrower, Ruler, Redwood Worker

### Changes
- Changed all ring sprite z_index to be 25 instead of 0 to appear above most objects
- Towers now face down when being placed
- Upgrade sell value is now automatically calculated (might cause a crash for one or two upgrades if i forgot a bracket or smth)

### Fixes
- All status effects now transfer over to child enemies not just glue1

### Balancing
- Glue effect nerfed from 0.5x, 0.25x, 0.1x to 0.75x, 0.5x, 0.3x

### Removed
- 'Upgrades' folder and its contents inside Redwood Worker which wasnt being used




## [beta 0.10] - 2024-09-07

### Added
- F1 Hotkey to show/hide the level ui
- F12 Hotkey to save a screenshot in the same directory as your save file
- System to change tower sprites depending on what upgrade they have (only works on Pencil Tower rn)
- Obsticles block attacks (the ones in The Park dont have that property but it works) though it is probably really badly optimised as it checks a RayCast2D every frame. so that aint good



## [beta 0.09] - 2024-09-06

### Added
- NEW TOWER: Watergunner, can only be placed in water and has a random color assigned to its floatie
- New enemy type: Father of all Pertys. Meant to be the big boss at the end ill edit its values properly later
- Shadow for towers with a setting to control it
- Lock to upgrade paths so only 2 of the 3 can be upgraded 

### Optimization
- Towers now only check if upgrade menu should be open when left mouse is clicked

### Fixes
- StackCollision now detects for contact with other StackCollision nodes to prevent tower stacking (hopefully for real this time)
- Mouse icon now reverts back to normal if a tower was not successfully placed



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
