# Hardcore Score

**[Download Classic Score on CurseForge](https://www.curseforge.com/wow/addons/classic-score)** — the recommended way to install and stay updated.

For World of Warcraft Classic Era. This repository is the source; releases are published to CurseForge.

The Classic Score addon is an exciting new way to track and display your character's progress in WoW Classic. It provides a single number that represents all the hard work you've put into your character, from leveling to questing to professions and reputation. The addon tracks everything and assigns points based on various factors such as equipment level, quest difficulty, and mob kill XP.

The scoring system is well-designed, with bonuses for hitting certain plateaus and completing levels in a certain amount of time. The addon is comprehensive, tracking every aspect of your character's journey and rewarding effort in all areas.

Scores can optionally be shared with other players, which is what fills in the in-game Score Board. Sharing happens entirely in game, over WoW's own guild and addon chat channels. The addon does not send your data to any external service, and sharing can be turned off in the options.

The scoring formula is still evolving, with input from the Hardcore community. Bug reports and suggestions are welcome in the GitHub issues.

## Testing helper

 A lightweight in-game test harness is included to validate mob kill scoring at level caps (Classic 60) without needing a capped character. Testing is OFF by default on every login/reload and must be enabled via slash command per session.

- Enable tests: `/hcs_testing_on`
- Disable tests: `/hcs_testing_off`
- Run the suite: `/hcs_tests`
- It stubs WoW APIs and simulates combat log events to verify:
	- Level 60 Classic: PARTY_KILL triggers immediate scoring with XP forced to 300
	- Skull (??) mobs are treated as +3 difficulty
	- Unknown mob level (0) uses the default -5 multiplier

- Results are printed to the chat frame as PASS/FAIL with a summary.

 Notes:
 - The harness snapshots and restores your kill-related saved variables, so it won’t wipe or modify your existing data.
 - It stubs out the addon's score refresh during tests to avoid triggering achievements or milestone popups.
 - Original WoW APIs and addon hooks are restored after the run. The harness only executes when you type `/hcs_tests`.
 - The toggle is session-only: it resets to OFF on reload/login. Use `/hcs_testing_on` again when needed.

### Production packaging

- To keep the test harness out of production, either:
 	- Leave testing disabled (default) so the harness stays inert, and/or
 	- Exclude the `Tests/` folder when building your release zip.
- The TOC includes the file for developer convenience; the harness is inert unless explicitly enabled.
