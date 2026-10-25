# Prompt: Recreate "Protect the VIP" on another template

Copy everything below the line into a new session that is working inside the target template/datapack. Adapt the names to that template's conventions (namespace, scoreboard objectives, state machine, timer and UI helpers). If the template already provides teams, timers, bossbars, death handling or late-join handling, reuse those and don't duplicate them.

---

Implement the game mode **"Protect the VIP"** in this template. The original is a vanilla Minecraft Java datapack (plain `.mcfunction` + JSON), first written for 1.19 and now targeting 26.3 (data pack format 121.0). Reproduce every feature and number below unless the template has an equivalent system to use instead.

## Concept

Players are split into 2–4 colour teams (red, blue, green, yellow). After a grace period, one random player per team becomes that team's **VIP**. If a VIP dies, their whole team is eliminated. Non-VIP players respawn after a delay. The last team with a living VIP wins.

## Settings (host-tunable, with defaults)

Apply these once, on first load only. Don't re-apply them on every reload, so a host's changes survive a `/reload`.

| Setting | Default | Meaning |
|---|---|---|
| `team_count` | 2 | 2 = red+blue, 3 = +green, 4 = +yellow |
| `cut_clean` | on | Auto-smelt dropped ores and raw food |
| `speed_uhc` | on | Auto-enchant held tools with Efficiency II |
| `patch_grindstone_exploit` | on | Remove grindstones (only when speed_uhc is on) |
| `death_time` | 25 | Respawn delay in seconds for non-VIPs |
| `kill_health` | on | Heal your VIP when your team gets a kill |
| `respawn_loot` | off | Give vanishing-cursed stone axe, stone pickaxe and leather boots on death |
| `finale` | 0 | "Finale" mode: bigger border and a special win subtitle |

Teams have friendly fire off and team colours set. Also create an **`admin`** team: its members are never gamemode-changed by the game (host/spectator bypass).

On first load, set the world to: worldborder 10 (a small lobby), `doImmediateRespawn true`, `keepInventory false`, `fallDamage false`.

## Game state machine (`period`)

- **-1, pre-game/lobby**: everyone except admins is in adventure mode with Weakness 255, Resistance 255, Regeneration 255 and Saturation 255 (infinite, hidden particles). Deaths aren't tracked.
- **0, grace period** (900 s = 15 min): survival mode, Resistance 255 for 300 s, weakness and regeneration cleared. Players gather loot. Fall damage is still off.
- **1, main game**: survival mode with all lobby effects cleared. VIPs are chosen, deaths and eliminations are tracked, and the win condition is checked every tick.
- **3, victory**: non-winners become spectators and everyone gets Resistance 255.
- (2 is reserved/unused.)

**Late join / rejoin handling**: each player stores the last period whose state was applied to them (`last_login`). Every tick, if a player's stored value differs from the current period, re-apply that period's gamemode and effects and update the stored value. This makes players who join or reconnect mid-game end up in the right state. In period 1, don't force survival on a player who is mid-respawn countdown.

## Setup flow

1. On first tick after install, broadcast a one-time setup message. It explains the setup steps, has clickable **2 / 3 / 4** options with hover text that set `team_count`, warns "GREEN only for 3+ teams, YELLOW only for 4+", shows `/team join [red/blue/green/yellow] [name]`, and says to run the start function when ready.
2. **Start command** validates that every team required by `team_count` has at least one player. If not, tell the sender (red `[X]` prefix): "Cannot start, check everyone is on a team (R+B for 2, R+B+G for 3, R+B+G+Y for 4). If you are on an admin team, your gamemode will not be updated upon starting!"
3. **On a successful start**:
   - Show the title "STARTED" (green, bold) with the subtitle "You have 15 minutes to prepare with loot before your team's VIP is chosen."
   - Play `entity.generic.explode` and `block.note_block.pling` to everyone.
   - Mark each team within `team_count` that has players as alive (1). Other teams stay unset.
   - Expand the worldborder to 1600 over 3 s (2400 if `finale`).
   - Set period to 0.

## Timer and scheduled events

Count ticks, and every 20 ticks increment a seconds counter. The counter runs only while the period is 0–2.

| Second | Condition | Event |
|---|---|---|
| 800 | period 0 | Worldborder shrinks to 20 over 2800 s |
| 900 | period 0 | **VIP selection** (go to period 1) |
| 1600 | period 1 | Worldborder set to 125 over 1400 s (overrides the previous shrink) |
| 2800 | period 1 | Worldborder set to 80 over 220 s |

## VIP selection (start of period 1)

- Tag one random player from each active team as `vip`.
- Non-VIPs get the title "DEFEND YOUR VIP" (green, bold) and the subtitle "Defend <VIP name> for your team."
- VIPs get the title "YOU ARE THE VIP" and the subtitle "If you die, your team dies."
- Play `entity.player.levelup` and `block.note_block.pling` to everyone.
- Turn fall damage on.
- VIPs get Health Boost amplifier 4 (an extra row of hearts, 40 HP total), effectively permanent. Everyone gets a 1-second Regeneration 255 burst to fill up.

## Ongoing main-game effects (every tick, period 1)

- VIPs: permanent Glowing and Slowness I (re-applied every tick for 1 s, hidden particles).
- VIP actionbar: "You are your team's **VIP** - if you die, your team dies."
- Non-VIP actionbar (when not dead): "Defend <VIP name> (<VIP health>♥) to keep your team alive." Show the VIP's health score in green bold, with a dark green ♥.
- Any non-spectator player on an eliminated team (score not ≥1) is forced into spectator.
- A `health` scoreboard objective tracks player health, used for the VIP health display.
- Per-team bossbars (max 40) are named after the team's VIP and show their health. They are shown to that team's players while the team is alive in period 1, and hidden otherwise.

## Main bossbar

- Grace period: "Grace period  **<seconds left>** seconds left" (gold, with white suffix), yellow colour, max 900, value = elapsed seconds. Seconds left = 900 − elapsed.
- Main game: "PROTECT THE VIP" (green, bold), max 1.
- Pre-game (period -1): "The game will begin shortly!" (white), full bar.
- The bossbar is shown to all players.

## Deaths (only tracked in period 1; death counters are cleared in other periods)

**Non-VIP death**:
- Message: dark-gray `[` green `☠` dark-gray `]` "You died, but will respawn in <death_time> seconds."
- Switch to spectator and teleport to the team's VIP.
- If `respawn_loot` is on, give the vanishing-cursed stone axe, stone pickaxe and leather boots.
- Start a respawn countdown. While dead, the actionbar shows "You are dead, <n>/<death_time> seconds!"
- When the countdown reaches `death_time`: Resistance 255 for 3 s, teleport to the team's VIP, message `[+]` "You respawned, defend your VIP!", and switch to survival.

**VIP death**:
- Message `[☠]` (red): "You died, your team is eliminated!"
- Set the team's alive flag to 0.
- Broadcast the title "ELIMINATION" (green, bold) with the subtitle "<Team> has been eliminated."
- The team's remaining players get forced to spectator by the per-tick check.

## Kills (`kill_health`)

When a player gets a player kill, heal their team's VIP with Instant Health I (+2 hearts). Send the VIP `[+2♥]` "An enemy team member has been killed!" and play `entity.arrow.hit_player` + `block.beacon.activate` to them. Reset the kill counter either way.

## Win condition (checked every tick in period 1, per team_count)

When exactly one playing team still has alive = 1 (teams that aren't playing are unset and ignored):
- Tag that team's players `winner`.
- Set period 3 and make non-winners spectators.
- Show the title "GAME OVER!" (green, bold) with the subtitle "<Team> has won!", or "<Team> has won the FINALE!" in finale mode.
- Play `ui.toast.challenge_complete` to all and give everyone Resistance 255.
- Launch a firework (large ball, green colour 3471405, fade 617238, flight 1) at each winner.
- Reset all team alive flags.

## Extras / modifiers

- **Cut Clean**: every tick, replace dropped item entities with a smelted version: Raw Iron / Iron Ore → 2 iron ingots, Raw Gold / Gold Ore → 1 gold ingot, and raw porkchop/mutton/beef/chicken/rabbit/cod/salmon → the cooked version. Each replacement emits a smoke particle, gets a small upward motion and a 12-tick pickup delay, and the original item is killed. Prefer matching on item ID over display name if the template allows it.
- **Speed UHC**: every tick, `enchant @a efficiency 2` (enchants any held tool that can take it).
- **Grindstone exploit patch** (prevents infinite disenchant/re-enchant with Speed UHC): every tick, delete grindstone blocks within 5 blocks of any player and clear grindstones from inventories. Also override the grindstone recipe so it needs a 3×3 of `structure_void`, which makes it uncraftable.

## Vanilla loot overrides

- Sand block: drops 2 sand (rolls 2, survives_explosion).
- Creeper: 0–3 gunpowder (+0–3 looting), plus the vanilla music disc when killed by a skeleton.
- Skeleton: 0–6 arrows (+0–3 looting) and 0–4 bones (+0–2 looting).

## UI conventions

Chat messages use a bracketed icon prefix: dark-gray `[` + coloured symbol + dark-gray `] ` + green message text. Titles are green and bold. Keep this consistent with the target template's own style if it has one.

## New game / reset

A reset function returns to period -1. It zeroes the timers, clears the team alive flags, the `vip`/`winner` tags (rejoining players are cleared in the lobby too) and all death/kill/last_login scores, clears effects, sets the worldborder back to 10 and turns fall damage off.

## Known quirks (fix or keep deliberately)

These were fixed in the 26.3 port: the "8 minutes" subtitle, the hidden team bossbars, the missing pre-game bossbar text, the missing `respawn_loot` default, and the lack of a reset. Still present:

- The respawn countdown starts at 1, so the real delay is about death_time − 1 seconds.
- If the last two VIPs die on the same tick, no team wins.
