# UI/UX Redesign — Planza

A direction for redesigning Planza's navigation and visual layer around the **Telegram 2026 "Liquid Glass" home-page design language** — translucent panels, layered depth, soft rounded "liquid" visuals, clean persistent bottom nav, floating/collapsing search, stories-style highlights strip, and a content-forward home screen. The goal: make Planza's features (goals, tasks, templates, hobbies, gamification, notifications) feel like one fluid, modern app — not five features stitched together.

---

## 1. The Telegram 2026 Design Language (What We're Targeting)

From Telegram's February 2026 Android overhaul and the subsequent "Liquid Glass" updates (version 12.4+), the home page and overall app design shifted to:

| Element | Telegram 2026 | What It Feels Like |
|---|---|---|
| **Surface language** | Translucent panels, layered depth, refined shadows, "depth-aware" UI elements, "Liquid Glass" effects on floating panels/buttons | Glassy, airy, modern — content floats above the surface, not boxed in |
| **Bottom navigation** | 4-tab bar (Chats, Contacts, Settings, Profile), stays visible while scrolling, hamburger menu removed entirely | Navigation is always one tap away, no hidden menus for top-level destinations |
| **Header / top bar** | Compact: Stories strip, Telegram title, emoji status, 3-dot overflow menu (day/night theme, create group, Saved Messages, Wallet) | Screen real estate goes to content, not chrome; secondary actions in an overflow |
| **Stories strip** | Prominent at the top of the home/chat list; "Add Story" appears when scrolling the chat list | Highlights / ephemeral content gets a dedicated, scannable strip without disrupting the list |
| **Chat list (home content)** | Cleaner visual hierarchy, softer elevation, clearer unread badges, more rounded "liquid" visuals, translucent surfaces | Scannable, calm, scrolly — rows don't blur together |
| **Search** | Full-width search bar that floats and hides on scroll; a "Search chats" button appears at the top when hidden | Search is one tap away, doesn't permanently consume space |
| **Settings** | Simplified layout with a search icon at the top for quick_find; tools/options easier to find | Find anything fast, no sprawling nested menus |
| **Folders** | Active folder highlighted in the theme's accent color; folder terms aligned inside pills | Active state is clear and colorful without being loud |
| **Pinned chats** | Better layout, can be organized, unlimited pinning in archive | Priority content is visually anchored |
| **Overall visuals** | More rounded, "liquid" visuals, translucent panels, liquid-glass effects on floating elements and buttons, softer elevation, smoother state changes | Soft, playful, premium, modern — not flat or boxy |

**The vibe:** translucent, layered, softly rounded, content-forward, navigation persistent but minimal, everything feels light and depth-aware. The redesign is "the biggest interface update in the history of Telegram for Android" — a full rebuilt interface optimized for efficiency and responsiveness.

For Planza, we adopt this *design language and layout pattern* — not Telegram's chat/messaging content. Our "home" is a productivity dashboard; our "chats" are goals/tasks/hobbies. But the visual language, nav patterns, search behavior, and surface treatment translate directly.

---

## 2. How This Translates to Planza

| Telegram 2026 Element | Planza Translation |
|---|---|
| Liquid Glass translucent panels, layered depth, refined shadows | Cards, modals, bottom sheets, FAB menu, bottom nav — use translucent surfaces with blur, refined shadows, soft rounded corners |
| Bottom nav (persistent, 4–5 tabs, no hamburger) | Our 5-tab bar (Home, Tasks, Goals, Hobbies, Profile) — make it "liquid glass": translucent background, refined indicator, stays visible while scrolling. Remove any drawer-as-primary-nav reliance. |
| Stories strip at top of home | A "highlights" strip on the Home dashboard: pinned goals, today's focus, current streak/level glance, recent hobby sessions — a scannable glassy strip like Telegram's stories |
| Floating search that hides on scroll | A search bar in the Home and Tasks headers that floats and collapses on scroll; when collapsed, a "Search" button/icon appears at the top (Telegram pattern) |
| Compact header with 3-dot overflow | Each tab's header: title + optional subtitle + contextual actions (search, filter, add) + 3-dot overflow for secondary actions (export, share, edit, delete, theme, settings) |
| Active state highlighted in accent color | Active tab, active filter, active category — highlighted in our primary accent color (Telegram folder highlight pattern) |
| Simplified settings with search | Our settings (in Profile tab): simplified grouped sections + a search icon at the top to jump to a setting (Telegram pattern) |
| More rounded, "liquid" visuals | Unify card corner radius to a larger, softer value; use refined shadows; translucent overlays; everything softer and rounder |
| Pinned/highlighted content anchored | Pinned goals at the top of the home highlights strip (Telegram pinned chats pattern) |

---

## 3. Navigation Architecture

### Current State

`root_page.dart`: `IndexedStack` of 5 pages + `CurvedNavigationBar` (5 icons: Home, Tasks, Goals, Hobbies, Profile). Home has a drawer (`DrawerSection`) opened from `GeneralAppBar` (a `ProfileButton`).

Issues through the Telegram 2026 lens:
- `CurvedNavigationBar` is a third-party widget — doesn't support a "liquid glass" design system (no translucent background, no refined indicator, no control over corner radius/shadow)
- No search in the tab bars (Telegram: search is prominent and floats)
- Drawer is the primary way to reach Templates and some settings — Telegram removed the hamburger entirely; top-level should be bottom nav, drawer is "more" only
- Cards, app bars, and surfaces don't have a unified liquid-glass language yet

### Target Navigation (Telegram 2026-inspired)

**Bottom Navigation — 5 tabs, liquid-glass style, persistent**
1. **Home** — dashboard (highlights strip + content)
2. **Tasks** — task list + calendar + filters
3. **Goals** — goal tree + progress
4. **Hobbies** — hobbies list + sessions
5. **Profile** — XP/stats/unlockables + settings (simplified, with search)

The bar (Liquid Glass):
- Translucent/glassy background — slight `BackdropFilter` blur + low-opacity tint of primary or neutral
- Icon + label for each tab, consistent stroke weight and corner radius
- Active indicator: accent-highlighted (Telegram folder pattern) — the active tab's icon/label in primary color, plus a soft glassy pill or underline in accent tint
- Stays visible while scrolling each tab (Telegram pattern)
- Refined, soft shadows; rounded corners matching the overall liquid radius
- No hamburger — everything top-level is in the 5 tabs; secondary stuff is in-tab or in Profile settings

**Header (each tab) — compact, Telegram-style**
- Left: small icon/avatar or nothing; center: title + optional subtitle (e.g., "Tasks" / "Monday, 22 September"); right: contextual actions
- Contextual actions: search field (floats/collapses on scroll — see below), filter 3-dot overflow, add button (liquid glass FAB or inline)
- Secondary actions (export, share, edit, delete, theme, settings, calendar, locale) → 3-dot overflow menu, not always-visible buttons
- Header is thin and blends — translucent/glassy surface or subtle tint, not a heavy opaque bar

**Search — floating/collapsing (Telegram pattern)**
- In Home and Tasks headers: a search field that floats and collapses on scroll
- When collapsed: a "Search" button/icon appears at the top (Telegram pattern — "Search chats" button)
- Tapping search expands it or opens a search-focused view
- Unified search across goals, tasks, hobbies, templates — one search for all content
- For a productivity app, search is more central than in Telegram — keep it easily accessible even if it collapses on scroll

**Drawer — reduced role (Telegram: no hamburger)**
- The drawer becomes a "more" layer only: Templates gallery (if not promoted), deep settings shortcuts, about
- Prefer moving theme/locale/calendar/notifications into Profile settings (Telegram: settings simplified and in the bottom-nav "Settings" tab)
- If a feature is used daily, it's a bottom-tab; if it's browse/settings, it's in-tab or in Profile

**In-context nav**
- Within each tab: sub-navigation via tabs, filter chips, search — not hidden in menus
- Filter chips: accent-highlighted when active (Telegram folder highlight pattern)

---

## 4. Home Page — The "Liquid Glass" Dashboard (Telegram Stories → Planza Highlights)

This is where the Telegram 2026 inspiration is strongest. Telegram's home is a chat list with a stories strip at the top; Planza's home is a productivity dashboard with a highlights strip at the top.

### Current Home
`SliverAppBar` (greeting + date) → stats bar → tasks due today → active goals carousel → tag analysis chart → spacer. Plus drawer and speed-dial FAB.

### Target Home (Telegram 2026-inspired)

**Header (compact, Telegram-style)**
- Left: small app icon or avatar
- Center: "Home" title + date (e.g., "Monday, 22 September") — like Telegram's title + date context
- Right: search field (floats/collapses on scroll — see above) + 3-dot overflow (theme, settings, calendar, locale)
- Thin, glassy/blended — not a heavy opaque bar. Translucent surface with subtle blur, or a surface color that blends with the scaffold.

**Stories/Highlights Strip (Telegram stories → Planza highlights)**
A horizontal scrollable strip at the top of the content, below the header — the "at a glance" layer:
- **Pinned goals** (Telegram pinned chats pattern): up to 3 pinned goals shown as small glassy cards with goal name + progress ring/bar + due date. Pinned goals are anchored at the top, scannable.
- **Today's focus**: today's tasks count (due/overdue), today's hobby sessions — a compact glassy chip/card.
- **Streak/level glance** (Telegram emoji status pattern): current streak (e.g., "12-day streak") + XP level (e.g., "Level 7") as a compact glassy element.
- **Recent hobby session** (optional): the most recent hobby session as a small glassy card ("Running — 25 min today").
- The strip is horizontally scrollable, glassy (translucent + blur + refined shadow + larger rounded corners), accent-tinted where appropriate, visually distinct from the list below.

This strip replaces/augments the current stats bar — instead of a flat stats bar, we have a scannable, glassy, Telegram-stories-style highlights strip.

**Home Content (the scrollable list)**
Below the highlights strip, the main scrollable content:
1. **Today's Focus** — tasks due today / overdue, shown as liquid-glass task cards (translucent surface, soft shadow, large rounded corners). Quick-check on tap, swipe to complete. Empty state: "Nothing due today — good job" with a start/add action (glassy empty state card).
2. **Active Goals** — horizontal carousel or compact list of active goal cards. Each: liquid-glass surface, goal name, progress ring/bar, due date, color/icon accent, child task count. Tap → goal detail. Pinned goals already shown in the highlights strip, so this is the full active list.
3. **Stats / Gamification Glance** (optional, Telegram emoji-status-like): a compact row or small glassy section — current streak, XP level, tasks completed today. Glanceable, not a full section. Could be part of the highlights strip instead.
4. **Tag / Category Breakdown** (optional): a compact chip row or small chart — keep if useful, otherwise move to Profile.
5. **Recent Hobbies / Sessions** (optional): a compact list of recent hobby sessions or "due today" hobbies. Could be a section or part of the highlights strip.

**FAB (Speed Dial) — liquid glass**
- A liquid-glass FAB (translucent surface, refined shadow, large rounded corner) — bottom-right or bottom-center
- Opens a speed-dial with glassy items: "Add task", "Add goal", "Start hobby session", "Add template" (if templates are a primary action)
- Each dial item: glassy surface, icon + label, rounded, appears with rotation + fade animation
- Telegram's "new story" button appears only when scrolling — for a productivity app, creation is core, so keep the FAB always present, or hide on scroll and show a floating "+" button (Telegram pattern)

**Search**
- In the header: search field that floats/collapses on scroll (Telegram pattern)
- When collapsed: "Search" button at the top
- Tapping search opens a search-focused view or expands the field
- Unified search: goals, tasks, hobbies, templates — one search for all content

---

## 5. Other Tabs — Liquid Glass Treatment

### Tasks Tab
- **Header**: "Tasks" + search (floats/collapses) + filter 3-dot overflow
- **Filter chips**: "All", "Today", "Upcoming", "Completed" — horizontal scroll, glassy chip style, accent-highlighted when active (Telegram folder pattern)
- **Task list**: liquid-glass task cards — translucent surface, soft refined shadow, large rounded corners, clean typography hierarchy. Swipe actions (complete, delete) with glassy preview. Prioritize scannability: title prominent, due date + priority as compact metadata, tag chips as small badges.
- **Calendar view**: a toggle/tab within Tasks; when active, a month grid with liquid-glass day cells, tap a day → tasks for that day. Glassy day cells with accent highlights for days with tasks.
- **Entry**: bottom sheet — liquid-glass surface, large rounded top corners, clean form fields (title, due date picker, priority, tags, goal link). Glassy overlay behind it.

### Goals Tab
- **Header**: "Goals" + add button (liquid glass FAB or inline glassy button) + 3-dot overflow
- **Goal tree/list**: grouped by status (Active / Completed) or flat list with parent-child indentation. Each goal card: liquid-glass surface, name, description snippet, progress ring/bar (glassy ring), due date, color/icon accent, child task count. Tap → goal detail.
- **Goal detail**: header with name, description, color/icon, deadline, edit/delete in 3-dot overflow; progress section (task completion stats, glassy); task list (with add + checkboxes, glassy task items); sub-goal tree if any.
- **Empty state**: liquid-glass empty state card — "No goals yet — create your first goal" with an add action.

### Hobbies Tab
- **Header**: "Hobbies" + add button (liquid glass FAB or inline) + filter 3-dot overflow
- **Tabs**: "All Hobbies" / "Due Today" — thin tab bar, accent-highlighted active tab (Telegram pattern)
- **Filter chips**: "All", "Active", "Daily", "Weekly", "Custom" — glassy chips, accent-highlighted active
- **Hobby list**: liquid-glass hobby cards (grid or list). Each: color/icon header in a glassy panel, name, frequency badge, target duration, goal link, start/edit/delete actions. Tap → hobby detail.
- **Hobby detail**: header with name, icon, color, frequency, streak badge; stats grid (liquid-glass stat cards: sessions, total time, avg duration, current streak, longest streak, avg mood); session history (glassy session cards); start session FAB (glassy).
- **Start session flow (hero flow)**: timer → running timer → end → mood picker (1-5 emoji, glassy, tactile) + notes → saved. Polished: smooth transitions, glassy overlays, satisfying feel. This is the equivalent of "posting a story" in Telegram — a core, well-designed flow.

### Profile Tab
- **Header**: "Profile" + 3-dot overflow (theme, settings, calendar, locale, about) — or a settings/theme button
- **XP level card**: liquid-glass card with `ProgressRing` (glassy ring), "Level N", "X / Y XP", "Next level at Z XP", progress bar. Celebration on level-up (Lottie, glassy overlay).
- **Stats grid**: liquid-glass stat cards — total XP, level, current streak, longest streak, tasks completed, goals completed, templates created, hobbies sessions. Each: label + value, consistent glassy style.
- **Streaks section**: current/longest streaks for goals + hobbies (compact glassy cards).
- **Unlockables**: available palettes (locked/unlocked) as glassy chips/cards (Telegram theme preview pattern — visual, tap to apply). Unlocked ones selectable; locked ones show the level required.
- **Settings (simplified, Telegram-style)**: inside Profile, a settings section with a search icon at the top to jump to a setting. Grouped sections: General (theme mode, calendar, locale), Notifications, Appearance (palette), About. Each row: label + control (switch, dropdown, picker). Clean, scannable, no sprawling menus — Telegram pattern.

---

## 6. Design System Refinements (Liquid Glass Direction)

### What We Already Have (keep — it's solid)
- `PlSpacing` — one spacing scale (the foundation)
- `PlTypography` — text style hierarchy
- `PlColors` + 8 unlockable palettes
- `PlCard`, `PlButton`, `PlTextField`, `PlChip`, `PlAvatar`, `PlDialog`, `PlBottomSheet`, `PlAppBar`, `PlFAB`
- `PlPageTransition`, `PlReorderable`
- Theme controller with dynamic Material 3 + unlockable palettes

### Refinements for Liquid Glass (Telegram 2026 direction)

1. **Card language — liquid glass**
   - Unify to one larger, softer corner radius (16–24px) — a new `borderRadiusLiquid` token or use `PlSpacing.borderRadiusLg`/`xl`
   - **Glassy surfaces**: `GlassyCard` / `GlassyContainer` wrapper — `BackdropFilter` blur + semi-transparent surface color + refined shadow. Use for: highlights strip cards, FAB menu items, modals, bottom sheets, featured/emphasized cards.
   - **Standard (non-glassy) cards**: still `PlCard` with consistent radius and a single shadow level (`shadow1` or `shadow2`). Use for list items where glass would be too heavy.
   - Don't overuse glass — restraint keeps it premium. Reserve glass for emphasized/floating elements.

2. **Shadows — refined, layered (Telegram "softer elevation")**
   - Softer, more refined shadows than the current hard shadows
   - Layered shadows for glassy elements: a subtle blur shadow (large blur, low opacity) + a tighter edge shadow or inner glow
   - One shadow level for standard cards, a different (softer + blur) shadow for glassy panels
   - Bottom nav: soft shadow on the bar (or no shadow, just translucency)

3. **Translucency (Liquid Glass core)**
   - Glassy panels: `BackdropFilter(blur: Radius.circular(20–30), child: Container(color: Color.fromRGBO(..., alpha: 0.15–0.25)...))` — blur + low-opacity surface
   - Bottom nav: translucent background (blur + tint), not opaque
   - FAB and speed-dial items: glassy
   - Bottom sheets, dialogs: glassy surface, large rounded top corners, glassy overlay behind
   - Highlights strip cards: glassy
   - In dark mode: glassy surfaces slightly lighter than background, subtle blur, low-opacity accent tint

4. **Corners — softer, larger (Telegram "more rounded, liquid visuals")**
   - Move from `borderRadiusMd` (12–16px) to a larger liquid radius (16–24px) for cards, sheets, dialogs, chips, bottom nav
   - Small elements (buttons, small chips) can keep smaller radii, but the overall direction is softer and rounder
   - Large rounded top corners on bottom sheets and dialogs (Telegram pattern)

5. **Color restraint + accent highlight**
   - Primary color used for: active tab indicator, active filter/category highlight, FAB, key buttons, data highlights, accent touches (Telegram folder highlight pattern)
   - Surfaces: neutral light/dark (already in our theme)
   - Glassy surfaces: subtle tint of primary or neutral, low opacity
   - Active states: clear but not loud — accent color on icon/label/text, not a full-color block

6. **Typography — clean hierarchy (Telegram: scannable, calm)**
   - Headline (page titles): large, bold, high contrast
   - Title (section headers, card titles): medium, bold
   - Body (content): regular
   - Label (chips, badges, metadata): small, possibly muted
   - Use `PlTypography` consistently; avoid inline `TextStyle` overrides except weight tweaks
   - Chat-list-like scannability: in task/goal/hobby lists, title is prominent, metadata is compact and muted

7. **Search — floating/collapsing (Telegram pattern)**
   - In Home and Tasks headers: a search field that floats and collapses on scroll
   - When collapsed: a "Search" button/icon at the top (Telegram "Search chats" button)
   - Tapping search expands it or opens a search-focused view
   - Unified search across goals, tasks, hobbies, templates

8. **Empty states — consistent, glassy**
   - Every empty list: a liquid-glass empty state card with icon + message + optional action
   - Use `EmptyState` composite, refine its style to match glass direction
   - Telegrams-style: empty states are calm, not alarming — "Nothing due today — good job", "No goals yet — create your first goal"

9. **Loading — shimmer or subtle (Telegram: smooth state changes)**
   - `LoadingShimmer` for content loading (already exists)
   - Avoid raw `CircularProgressIndicator` mid-screen unless full-screen load
   - Glassy loading overlays for sheets/dialogs
   - Smooth state transitions (Telegram: "smoother state changes")

10. **Motion — purposeful, smooth (Telegram: "smoother state changes, smoother UI")**
    - Page transitions: `PlPageTransition` (or a liquid-glass slide/fade)
    - Tab switches: smooth cross-fade/slide
    - Bottom sheet: spring open, glassy surface
    - FAB dial: rotation + fade, glassy items
    - Celebrations: Lottie on level-up, streak milestones — glassy overlay
    - Scroll: search bar collapses smoothly; highlights strip can pin or scroll away; lists scroll with soft elevation changes
    - No jarring jumps — everything animates

11. **Dark mode — intentional (Telegram: clean in both, custom themes behave better)**
    - Surfaces: dark neutrals (already in theme)
    - Glassy panels in dark mode: slightly lighter than background, subtle blur, low-opacity accent tint
    - Cards: subtle distinction from background (lighten slightly or faint border), not pure black
    - Text contrast checked in dark mode
    - Unlocked palettes still apply; glass surfaces adapt to the selected palette tint

12. **Bottom nav — liquid glass (Telegram: translucent bottom bar, persistent)**
    - Translucent/glassy background (blur + tint)
    - Icon + label, consistent weight, larger rounded corners
    - Active indicator: accent-highlighted icon/label + soft glassy pill or underline in accent tint (Telegram active folder pattern)
    - Stays visible while scrolling
    - 5 tabs: Home, Tasks, Goals, Hobbies, Profile
    - No hamburger — everything top-level is in the 5 tabs

---

## 7. What to Keep from Current

- **5-tab bottom nav structure** — right, refine the bar to liquid glass
- **Drawer** — reduce to a "more" layer (templates, deep settings) or fold into Profile; Telegram removed the hamburger, so minimize drawer reliance
- **Home dashboard layout** (greeting, stats, tasks, goals carousel, charts) — good foundation; add the highlights strip, refine cards to glass
- **`PlSpacing`, `PlTypography`, `PlColors`, `PlCard`, `PlButton`, etc.** — solid foundation; build glass primitives on top
- **Theme controller + unlockable palettes** — keep; this is a differentiator and fits the "appearance" section Telegram has
- **Speed-dial FAB** — keep concept, make it glassy
- **`CustomScrollView` + slivers** on Home — correct pattern; expand to other scrollable pages
- **Bottom sheet for entry flows** — correct pattern; make glassy with large rounded top corners
- **Celebration Lottie** — keep; add glassy overlay

---

## 8. Open Decisions

1. **How much glass?** Full glass everywhere feels heavy and can hurt readability. Target: glassy panels for highlights strip, FAB menu, modals, bottom sheets, featured/emphasized cards. Standard list items: flat or lightly elevated `PlCard`. Fine-tune by feel — Telegram uses glass selectively (floating panels, buttons), not on every row.
2. **Search behavior?** Telegram hides search on scroll and shows a "Search" button. For a productivity app, search is more central — keep it easily accessible (always in header, or collapsible with a clear "Search" button appearing). Could also have a dedicated search tab or a search icon that expands.
3. **Templates placement?** Drawer (current) or a Home highlight / quick-access section. For now: drawer, glassy. If templates become a primary action (e.g., "Add template" in FAB), promote it. Telegram: secondary features are in the bottom-nav "Settings" tab or overflow — templates could be a section in Profile or a drawer entry.
4. **Bottom nav indicator style?** Accent-highlighted active tab (Telegram folder pattern: active folder in accent color) vs a glassy pill under the active tab. Prefer accent highlight on icon/label + a soft glassy background for the whole bar. Could also do a small glassy pill indicator under the active tab.
5. **Highlights strip content?** Pinned goals, today's focus, streak/level glance, recent hobby session. Keep it concise (3–5 items), horizontally scrollable, glassy. Pinned goals are the Telegram "pinned chats" equivalent — anchor them at the top.
6. **Header style?** Static thin glassy bar across all tabs (simpler, consistent) vs floating/collapsing on scroll (Telegram chat list). Prefer static thin bar for consistency and simplicity; could experiment with collapsing on Home.

---

## 9. Success Looks Like (Telegram 2026-inspired)

- Open Planza → a calm, modern home screen: thin glassy header (greeting + date + search + 3-dot overflow), a horizontally scrolling glassy highlights strip (pinned goals, today's focus, streak/level glance), and a scrollable list of liquid-glass task/goal cards below — all softly rounded, with refined shadows and translucent depth.
- Tap a bottom nav tab → smooth transition, consistent compact glassy header, the tab's content with unified glassy cards, persistent nav visible while scrolling.
- Search → easily accessible from Home/Tasks headers, collapses elegantly with a "Search" button appearing, covers all content.
- Start a hobby session → a polished timer flow with glassy overlays and a tactile, rounded mood picker — the Planza equivalent of Telegram's story-posting flow.
- Level up → a celebration with Lottie and a glassy overlay.
- Dark mode → everything reads clearly, glassy panels have subtle contrast and blur, no pure-black noise, palettes still apply.
- Settings → inside Profile, simplified and grouped, with a search icon to jump to a setting (Telegram pattern).
- Every empty list → a friendly glassy empty state with an action.
- One app, one language: translucent, layered, softly rounded, content-forward — Liquid Glass for productivity.

---

## 10. Next Step

**Phase A — Shell: liquid-glass bottom nav + standardized headers + floating search.** This is the foundation. Specifically:
1. Build a `GlassyBottomNavigationBar` widget: translucent/glassy background (blur + tint), 5 tabs (Home, Tasks, Goals, Hobbies, Profile) with icon + label, accent-highlighted active tab, soft shadow, large rounded corners, persistent while scrolling. Replace `CurvedNavigationBar`.
2. Standardize a `GlassyAppBar` / compact header widget: thin, glassy/blended, title + subtitle + contextual actions (search field that floats/collapses, filter 3-dot overflow, add button). Use across all 5 tabs.
3. Implement the floating/collapsing search in Home and Tasks headers (Telegram pattern: collapses on scroll, "Search" button appears).
4. Reduce the drawer to a "more" layer (templates, deep settings) or fold theme/locale/calendar/notifications into Profile settings.

Once the shell is in place, refine each tab's content with the glass language (Phase B–G). Want me to start implementing Phase A?
