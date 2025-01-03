29/08/2024 - v0.01 -Starting recording stuff today :D
`` UI ``
- Added a loading screen
`` Spawning ``
- Changed spawn mechanics
- Added functionality to fire and fast status
- Pertys can now spawn with status (currently: hot, glue fast, metal and glue (glue is not enabled in the editor and has to be added externally at the moment))
- Multiple groups of pertys can spawn in one wave (example: 2 normal + 2 blue can spawn in one wave) (normally only one group could spawn)
- Changed the speed of animations to make it slightly faster
- Added an "event" to the level dict but currently has no use
`` Upgrades ``
- Changed the upgrade menu
- Made one upgrade (1st tier of dart's vision) possible to purchase
- Redwood Worker and Glue Tower now cant be upgraded for the time being to prevent a crash
`` Misc. ``
- Added a win scenario (temporary at the moment, just used to show it works and prevent crashes)





30.08.2024 / v0.02
`` Spawning ``
- Added a way to get the time it takes for all Pertys to spawn in one round
- Added functionality to the 'metal' status
`` Upgrades``
- All upgrades work for the Dart Tower
- Slightly changed upgrade menu
- Upgrade level is now displayed with green circles (lvl 1 - 1 circle appears, lvl 2 - 2 circles appear etc.)
- Textures now update depending on the chosen upgrade
- Added more upgrade sprites
`` Settings ``
- Indicated which tab was open by making the open tab text go from the right (closed tabs go from the left)
- Added an 'advanced' tab
- Added an fps slider in the 'advanced' tab (min: 5, max: 999)
- Added a VSync button which cycles through 4 modes (enabled, disabled, adaptive, mailbox)
- Added a notification style popup when saving the game to indicate if it works and the file path with it.
`` In Game ``
- Added a button in the debug menu to force a win and loss
`` Towers``
- Glue Towers can now target pertys with the 'metal' status
- Changed how towers detect Pertys (might be slightly faster but is more reliable and works with multiple status' very easily)
- Redwood worker now only makes 3 bits of gold a round and changes its generation time depending on the round spawn time
`` UI ``
- Changed how to speed multiplier is shown, using one button for a 1x and 2.5x, not two buttons.
- Added a perty egg in the main menu when you first win the test map I want to eventually make this into an achievment system.

`` Known Issues ``
- The text for the button "Close" in the settings menu displays as "Clos" when the window is maximised (why???)





31.08.2024 / v0.03
`` Upgrades ``
- Added upgrades to the Glue and Redwood Worker towers, which both now can be upgraded
`` Achievements ``
- Added a menu for achievements
- Added "Win Test Map on easy" achievement
`` UI ``
- Made the 'play' 'settings' and 'achievement' button undisable when hovered over preventing an issue when the 'achievement' and 'play' buttons are pressed in a certain way
`` Enemy ``
- Changed sprite for 'camo' status to make it easier to see
`` Status ``
- Added a shield status which gives the Perty 25 health
`` Towers ``
- Added two new glue types (glue2/superglue and glue3/superduperglue) which change speed to 25% and 10%
- Ability to sell towers (50% of price you purchased them + 75% of the upgrades you bought)
- NEW TOWER: FLAMETHROWER good with large groups of weak enemies (no upgrades yet)
`` Settings ``
- Added a 'Graphics' submenu
- Added options for fullscreen and windowed
- When F11 is pressed the game will switch between fullscreen and windowed mode
`` Level Editor ``
- Slighly change status menu graphics
- Added 'shield' to status menu


`` Fixes ``
- Fixed an issue to when upgrading waittime for a tower to fire didn't work as intended
- Fixed an issue that when finished a game (either win or loss) and 2.5x speed was enabled the 2.5x speed would carry over to the main. Only 1x is active in the main menu as intended.





01.09.2024 / v0.04
`` Saving ``
- Changed how maps completions are saved
`` Towers ``
- Flamethrower now shoots out a ball of fire which explodes upon impact causing a short range AoE attack which attacks all enemies in the range. Still good with weaker enemies but not as good with more stronger ones.
`` Sprites ``
- Added an outline to the Pencil sprite
`` Achievements ``
- Changed how achievements are shown which is now through a bronze/silver/gold/diamond system. If you beat something on easy bronze is shown, silver is normal, gold is hard and diamond is hardcore. This means custom difficulties are no longer possible without altering the code of the game at the moment.
`` Settings ``
- Option to show and hide the debug information in the 'Advanced' tab
`` Upgrades ``
- Added all upgrades to Flamethrower
- Added a way to 'strip' off a status from a Perty
`` Debug ``
- Added used and maximum RAM to the menu

`` Fixes ``
- Achievements now properly showing
- Pencil launched from Pencil tower are now properly rotated toward the enemy





02.09.2024 / v0.05
`` Menu ``
- Reverted change to enable buttons on hover

`` Towers ``
- Nerfed effect of the Flamethrowers size upgrade. It was a tad too op and still is very good

`` Maps ``
- Changed 'Test Map' name to 'The Park'
- Added a small raft to the water in 'The Park'

`` Upgrades ``
- Added sprites to Flamethrower upgrades
- The [x,x,x] text above a tower is now shown only when Show Debug Stats is turned on

`` Level Editor ``
- Added a 'Level Name' string
- Added Rainbow Perty to Perty list

`` Other ``
- New exe icon
- Added 'Perty thinks you're cool' to loading screen cause you're cool B)

`` New Stuff ``
- Added Encyclopedia. This tells a little description of each enemy, tower and status along with their stats and how many have been placed
- Added a new Perty type: Rainbow. Appears after Pink and spawns one of each perty before it (Normal, Blue, Green, Yellow, Pink)

`` Fixes ``
- Fixed an issue where the background music would play before volume setting are loading sometimes causing a random loud noise on startup





3.09.2024 / v0.06

`` Loading ``
- Added a new menu on startup to prevent loading everything if the game was accidentally opened.
- Version text moved to this menu

`` Debug ``
- Added a 'Last load time (s)' line to the debug list
- Added shortcut F3 to toggle visibilty of the list

`` UI ``
- Changed menu slightly when in game to give the playing field more room
- Doubled size of ring.png to make the ring better to look at
- Ring now doesnt rotate with the tower, like the debug info above it

`` Balancing ``
- Lowered Pencil Tower base particle speed
- Increased range of Gabbys Book trap and the stack range
- Changed Glue Gunner last speed upgrade to change from 3x -> 4x

`` New Stuff ``
- Ruler Tower. Throws rulers like a boomerang, high range, not super accurate

`` Fixes ``
- Towers invisible in the shop due to scrolling now cant be interacted with until visible again
