### Sharing with others

This document explains how Classic Score shares scores with other players and how each option affects behavior.

### Overview

- **Default sharing**: Scores are sent to your current group/raid or guild when enabled.
- **Public network (optional)**: Opt‑in to a custom chat channel so any player on the same realm/faction who joined the same channel can exchange scores.
  - Uses addon messages (not visible in chat) and ChatThrottleLib via AceComm.
  - Channel appears in the player’s channel list and is leaveable at any time.

### Options and what they do

- **Share your Score**
  - Master toggle. If OFF, no addon messages are sent and incoming ones are ignored.
  - Gates the progression toggles below (Milestones, Achievements, Rank, Level).

- **Public Network (channel)**
  - Opt‑in to join the public channel (see “Public Channel Name”) and broadcast/receive scores there.
  - On login/toggle, automatically joins and prints a confirmation in chat when active.
  - Scope: same realm and faction; other players must use the identical channel name.

- **Public Channel Name**
  - The channel used by the public network. Changing it leaves the old channel and joins the new one.
  - Only used when Public Network is enabled.

- **Only live (public channel)**
  - Display filter: the leaderboard shows only players recently seen on the public channel (last ~180 seconds).
  - Requires Public Network enabled. Does not change what you send; it only changes what you see.

- **Keep saved history**
  - If ON: leaderboard entries persist across sessions.
  - If OFF: leaderboard is cleared on login (fresh view each session).

- **History retention (days)**
  - Hides and prunes entries older than N days. Set to 0 to never prune.
  - Only applies when Keep saved history is ON.
  - Uses each entry’s “last online” timestamp.

- **Milestones / Achievements / Rank Progression / Level Progression**
  - Control which progression events are shared while Share your Score is ON.
  - These toggles do not affect the core leaderboard share itself.

### How options interact

- **Share your Score** must be ON for any sharing/receiving. It also enables the progression toggles.
- **Public Network** must be ON for:
  - Public channel join/leave and public broadcasting.
  - The **Only live** filter to work.
  - Online‑first sorting: when Public Network is ON, the leaderboard sorts players seen online via the channel before others.
- **History**:
  - If **Keep saved history** is OFF, the leaderboard is cleared every login.
  - If ON, **History retention (days)** prunes entries older than the selected window.
  - **Only live** can be layered on top to show just currently active entries.

### Defaults

- Public Network (channel): OFF
- Public Channel Name: ClassicScore
- Only live (public channel): OFF
- Keep saved history: ON
- History retention (days): 30

### Recommended setups

- **Live board** (who’s on right now):
  - Share your Score ON, Public Network ON, Only live ON, Keep saved history OFF (or ON with small retention).

- **Hybrid, most useful day‑to‑day**:
  - Share your Score ON, Public Network ON, Only live OFF, Keep saved history ON, History retention 14–30 days.

- **Private/guild‑only**:
  - Share your Score ON, Public Network OFF. History as you prefer.

### Channel status message

- On successful join: prints “Classic Score: Public channel '<name>' active (id).”
  - If you don’t see this and your leaderboard looks empty, ensure the channel name matches exactly for everyone.

### Notes

- Addon messages sent over the public channel are not visible in regular chat, but the channel is listed in your channels UI.
- Players can leave or change the public channel at any time in options.


