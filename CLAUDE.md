# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

"Protect the VIP" is a vanilla **Minecraft Java 26.3 datapack** (data pack format `121.0`, set via `min_format`/`max_format` in `pack.mcmeta`). It is pure `.mcfunction` + JSON, with no linter or test suite. The 1.19 version (`pack_format` 10) lives on `main`; the 26.3 port is on `mc-26.3`. Running `./build.sh [name]` zips the pack into `vip.zip` (gitignored) for distribution. The version string lives in the `pack.mcmeta` description (`§6YYYY.MMDD`, e.g. `2026.1025`); bump it when releasing.

`RECREATE.md` holds a full feature spec for porting this game to another template. Keep it in sync when gameplay changes.

26.3 syntax reminders (these differ from older packs): folders are singular (`function/`, `loot_table/`, `recipe/`, `tags/function/`). Text components are SNBT (`{text:"..",hover_event:{action:"show_text",value:..},click_event:{action:"run_command",command:".."}}`). Gamerules are namespaced snake_case (`minecraft:fall_damage`). Items use components (`stone_axe[enchantments={"minecraft:vanishing_curse":1}]`). Loot tables use `modifier`/`type`/`condition`. When editing data JSON, copy the vanilla shape from misode/mcmeta (`26.3-data` branch) instead of guessing.

## Running / testing

Copy (or symlink) the repo folder into `<world>/datapacks/`, then in-game (op required):

- `/reload` re-runs `vip:load`. It is idempotent: objectives, teams and bossbars use `add`, and defaults are applied only once via `defaults internal`. Parse errors show up in the server log as `Failed to load function ...`, which is effectively the linter.
- `/team join <red|blue|green|yellow|admin> <player>`, `/scoreboard players set team_count global <2|3|4>`
- `/function vip:start` validates teams, then calls `vip:start_c`.
- `/function vip:reset` returns to the lobby (period -1) and clears timers, tags, death scores and the worldborder for a new game.
- To skip the grace period while testing: `/scoreboard players set time_s internal 899` (or run `/function vip:main_game` directly).
- To fully reset defaults: `/scoreboard players reset defaults internal`, then `/reload`.

## Architecture

Entry points are wired via `data/minecraft/tags/function/`: `load.json` → `vip:load`, `tick.json` → `vip:main` (every tick).

**All state is in scoreboards**, by convention:
- `global` objective holds host-tunable settings (`team_count`, `cut_clean`, `speed_uhc`, `death_time`, `kill_health`, `patch_grindstone_exploit`, `respawn_loot`). These are set in `defaults.mcfunction`.
- `internal` objective holds runtime state (`period`, `time`, `time_s`, `time_left`, the `red/blue/green/yellow` alive flags, `alive` count, `finale`, `setup`, `defaults`, constant `900`).
- Per-player: `death` (deathCount), `kill` (playerKillCount), `death_time`/`death_time_t` (respawn countdown in seconds / ticks), `last_login`, `health`.
- Tags: `vip` (the team's VIP), `winner`.

**`period internal` is the game state machine**: `-1` pre-game → `0` grace (set by `start_c`) → `1` main game (set by `main_game`) → `3` victory (set by `win`). `vip:reset` returns to `-1`. Value `2` is unused, even though several checks use `0..2`.

**`time.mcfunction`** runs only while period is `0..2`. It owns the tick→second counter (`time` → `time_s`), the respawn countdown, and all scheduled events (border shrinks at 800/1600/2800s, VIP selection at 900s). Anything time-driven goes here. **`bossbar.mcfunction`** runs every tick and owns all bossbar text and visibility, including the period -1 text and the per-team VIP bossbars.

**`last_login.mcfunction`** applies per-period player state (gamemode/effects) once per player by comparing `@s last_login` to `period`. This is how late joiners and rejoiners get the correct state. Add per-period player setup here, not in the transition functions. Players on team `admin` are never gamemode-changed.

**Per-team logic uses macros.** `vip:team/each {fn:"<name>"}` calls `vip:team/<name>` once per colour with `{t:"red",T:"Red"}` etc., and keeps the caller's `@s`/position. To add team behaviour, write one macro function in `team/` using `$(t)`/`$(T)` and dispatch it through `each`. Don't copy it per colour. A team's `internal` score is `1` alive, `0` eliminated, and reset means not playing. `start_c` marks only teams within `team_count`. `win_check` counts alive teams, and if exactly one is left, `team/win_if_alive` calls the macro `vip:win {T:..}`.

`extras/` holds optional modifiers, toggled by `global` scores and run from `main` every tick. Cut clean matches drops by item ID via the `extras/smelt {from,to,n}` macro. `data/minecraft/` overrides vanilla loot tables (boosted drops) and replaces the grindstone recipe with an uncraftable one (part of the grindstone-exploit patch).

## Known quirks (don't "fix" silently — confirm with the user)

- The score is still named `start_confirmed` (the rename only applied to the function `start_c`).
- The respawn countdown starts at 1, so the real delay is about `death_time` − 1 seconds.
- If the last two VIPs die on the same tick, no team wins (alive count is 0).
