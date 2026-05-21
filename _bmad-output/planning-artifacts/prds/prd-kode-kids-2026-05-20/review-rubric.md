# PRD Quality Review — Kode With Greg Marketing Website

## Overall verdict

The PRD is well-scoped and unusually honest for a marketing site — the vision is coherent, non-goals do real work, and the testable consequences are the best part. The main risks are a structural open question left dangling (domain name), a thin success-metric footprint that stops short of validating the conversion thesis, and a handful of scope assumptions that are asserted rather than resolved where they matter most. Nothing here blocks implementation, but two items warrant explicit sign-off before build.

---

## 1. Decision-readiness — adequate

The PRD gives a developer enough to start and Greg enough to sign off on scope. Trade-offs between static-site simplicity and future extensibility are named. The one live open question (domain name) is marked TBD in §11 and in the NFR block but not flagged with a blocker severity — a decision-maker could miss that this stops deployment, not just SEO.

### Findings

- **high** Domain unresolved — has deploy consequences (§11, §7) — Domain name is confirmed TBD. This is a deployment blocker, not just a metadata gap. The PRD treats it as a minor note. *Fix:* Mark it explicitly as a pre-launch blocker with a named resolution owner and a required-by date.

- **medium** Facebook link conditionality is underspecified (§6.3 FR-9) — FR-9 says the link is "conditional on existence" in §9.2 but the FR itself states it as a requirement without surfacing the conditional. A developer reading FR-9 alone would implement it as mandatory. *Fix:* Add an inline note in FR-9: "Implement as conditional — render only after Greg confirms the renamed page is live."

- **medium** Copy ownership ambiguity (§5, §9.2) — §9.2 says "a creative writer is engaged." §5 says Greg owns final copy or engages a copywriter. These are not the same statement. If copy is late, does the developer hold launch? *Fix:* Name the dependency explicitly: "Final copy is a launch dependency. Absent approved copy, developer uses placeholder that matches length and voice constraints."

- **low** "Let's Talk" vs. other CTA copy (§4, FR-10) — The nav CTA is named "Let's Talk" in §4 but FR-10 says "Let's Talk or equivalent," leaving the name open again. *Fix:* Lock to one string or explicitly delegate to the copywriter with a character-count constraint.

---

## 2. Substance over theater — strong

No persona theater. The three personas are functional: each maps to a distinct UJ, each UJ maps to FRs, and the non-users list explicitly excludes groups the site is not for. The vision section earns its length — the single-sentence mission ("spark a project idea... and convert that spark into a direct reach-out") is the controlling idea the rest of the PRD is actually held to. The voice/tone section (§5) is unusually specific and actionable, naming specific hedging words to avoid.

### Findings

- **low** "Italian and cool" is undefined and untestable (§5) — This is the one theater fragment in an otherwise clean document. It signals something to Greg but communicates nothing to the developer or UX designer without a follow-on brief. *Fix:* Either expand to 2–3 concrete visual references or explicitly delegate: "Visual direction fully owned by UX designer; 'Italian and cool' is a starting prompt, not a specification."

- **low** BMad Method reference has no anchor (§1, FR-4) — The BMad Method is mentioned in the vision and the credibility block but is not in the glossary and not explained for non-specialist readers of this PRD (e.g., a developer or copywriter unfamiliar with it). *Fix:* Add a one-line glossary entry or a parenthetical: "Greg's proprietary AI-assisted project-building workflow."

---

## 3. Strategic coherence — strong

The thesis is explicit and restated consistently: ignite a project idea, remove barriers, generate a direct contact. Features map cleanly to this arc — every FR either builds conviction (spark, credibility, how-it-works) or removes friction (contact, persistent nav CTA). The counter-metric (SM-C1) is the strongest single element in the document: it pre-empts the natural vanity-metric drift that kills conversion-focused sites.

### Findings

- **medium** SM-2 (3 paying attendees/week) validates site effectiveness but not the site's thesis (§10) — The thesis is that spark → contact conversion happens. SM-2 measures downstream bookings, which depend on Greg's ability to close conversations, not only the site's conversion. A site that generates 20 contacts and Greg closes 3 looks identical to a site that generates 3 contacts and Greg closes 3. *Fix:* Add SM between contact volume and bookings: "Contact page generates at least N inbound contacts per month" (distinct from SM-4's weekly framing). This makes the site's own contribution measurable.

- **low** SM-4 measures contact page activity, not site-wide conversion (§10) — "At least one inbound email or call per week" is a very low bar (could be noise) and doesn't distinguish UJ-1/UJ-2/UJ-3 pathways. *Fix:* Consider adding a referral-source question to the email prompt ("Tell Greg what you want to build and how you found him") to make SM-4 richer without instrumentation cost.

---

## 4. Done-ness clarity — strong

This is the PRD's best-executed section. The "Consequences (testable)" format per FR is consistent and the consequences are genuinely testable, not rewrites of the requirement. Specific numbers appear where they matter: 375px viewport, 44×44px tap targets, four cards, three steps, four sentences max, 3-second load, 60-day SEO window. No vague adjectives like "user-friendly" or "reasonable" appear in the testable consequences.

### Findings

- **medium** FR-3 How It Works has no copy constraint (§6.1 FR-3) — Steps are named ("Pick an idea," "Show up Saturday," "Build something real") but no length or format constraint is placed on supporting copy. Given the copy-ownership ambiguity in §9.2, a developer could receive copy that breaks layout. *Fix:* Add a consequence: "Each step's supporting copy does not exceed two sentences / [N] characters."

- **medium** FR-6 logistics block has no placement consequence (§6.2 FR-6) — "Logistics appear once on the page" is stated as a rule but no testable position is given. Does "once" mean before the tracks, after them, or after the CTA? *Fix:* Add: "Logistics block appears after all three track descriptions, before the page CTA."

- **low** FR-11 analytics has no verification method (§6.4 FR-11) — "GA4 tracking code loads on all three pages" is testable in principle but no QA method is named. *Fix:* Add: "Verified via GA4 real-time report showing page-view events on each page before launch sign-off."

- **low** "Before the footer CTA" / scroll order constraints are inconsistently applied (FR-4, FR-5) — FR-4 specifies position relative to other sections; FR-5 specifies position relative to the footer. FR-3 specifies position relative to FR-4. But FR-1 (Hero) and FR-2 (Spark) have no scroll-order consequence. This is fine for obvious above-fold content but worth noting if layout debates arise. *Fix:* Add a single scroll-order consequence to FR-1 or a master flow statement in §6.1 intro: "Homepage renders in this order: Hero → Spark → How It Works → Credibility Block → Footer CTA."

---

## 5. Scope honesty — strong

Non-goals (§8) do real work. The seven explicit non-goals are specific enough to actually answer "but why not?" questions without deliberation. The distinction between v1 and v2 is handled cleanly (Spark Section slot design for student stories is a genuinely useful forward-compatibility call). [ASSUMPTION] tags are present throughout and indexed in §12.

### Findings

- **medium** Assumptions Index has a duplicate entry (§12) — Two entries both cover AWS static hosting: "v1 is a static site (no backend/database); AWS hosting via S3 + CloudFront or equivalent" and "Static site hosting on AWS (S3 + CloudFront or equivalent). Root-relative routing — no subdirectory base path." These should be merged into one entry, and the root-relative routing detail (which is genuinely separate) should be its own item. *Fix:* Merge the two AWS entries; extract root-relative routing as a standalone assumption.

- **medium** FR-9 Facebook link is in §9.1 "In Scope" as "conditional Facebook link" but FR-9 text doesn't reflect the conditionality (§9.1 vs §6.3) — Already flagged under Decision-readiness; the scope honesty angle is that the conditionality is buried in §9.2 out-of-scope commentary rather than surfaced in the FR where an implementer would act on it.

- **low** Photography assumption is out-of-scope commentary but not in the Assumptions Index (§9.2) — "Assumed available but not owned by this PRD" is an assumption that affects FR-4 (Credibility Block). If the photo isn't delivered, FR-4 is broken. *Fix:* Add to Assumptions Index: "§6.1 FR-4 — Greg's headshot is confirmed available and will be delivered to the developer before build."

- **low** Terraform is mentioned in §7 and §9.1 without a definition or assumption tag (§7 NFRs) — "AWS, provisioned via Terraform" is a significant scope statement (it implies IaC authorship is in scope) but carries no [ASSUMPTION] tag and no "who writes the Terraform" ownership. For a single-developer engagement this matters. *Fix:* Add [ASSUMPTION: Terraform is within scope for the developer; alternatively, manual S3/CloudFront setup is acceptable if Terraform adds friction for a three-page static site.]

---

## 6. Downstream usability — adequate

FR, UJ, and SM IDs are present and consistently formatted. Cross-references between FRs and SMs exist in §10 (SM-1 explicitly validates FR-1 and FR-2; SM-3 validates FR-13). Section extraction would work cleanly for FR-8, FR-9, FR-10. The glossary covers the six domain terms introduced in the PRD body.

### Findings

- **medium** SM-1 and SM-2 validate FRs; SM-3 and SM-4 do not — SM-3 references FR-13 inline. SM-4 does not reference FR-8, which it logically validates. *Fix:* Add "Validates FR-8" to SM-4 measurement note.

- **medium** UJ cross-references to FRs are absent — UJs 1–3 are defined in §2.4 but no FR references UJ-1/UJ-2/UJ-3. A developer optimizing layout decisions (e.g., section scroll order, mobile layout) has no way to trace which FRs are load-bearing for which UJ. *Fix:* Add a brief UJ → FR mapping table in §2.4 or at the start of §6, e.g.: "UJ-1 depends on FR-1, FR-2, FR-5, FR-8; UJ-2 depends on FR-1, FR-2, FR-4, FR-6, FR-8."

- **low** Glossary omits "BMad Method" and "Session Track" is defined but never FRed — "Session Track" appears in the glossary and in FR-6 (track display). "BMad Method" appears in §1 and FR-4 copy guidance but is not in the glossary. Minor consistency gap.

- **low** FR-2 Assumptions Index reference uses wrong section numbering (§12 vs body) — The Assumptions Index references "§6.2 FR-2" and "§6.2 FR-7" but in the PRD body these are §6.1 FR-2 and §6.2 FR-7 (Services page). FR-2 is a Homepage FR living in §6.1, not §6.2. *Fix:* Correct the Assumptions Index: "§6.1 FR-2" for the archetype card icon assumption, and "§6.2 FR-7" remains correct for the Services mid-page CTA.

---

## 7. Shape fit — strong

For a local-launch marketing website with one developer, this PRD is appropriately sized. It is not enterprise-formalized (no SLA tables, no risk matrix, no formal stakeholder sign-off block). It is not under-formalized (the testable consequences are developer-ready, the non-goals prevent scope creep, the IA table covers structure without over-engineering it). The decision to omit a form and use raw contact links is explicitly stated and defensible. The v1/v2 boundary is real and respected.

### Findings

- **low** NFR section (§7) is a flat bullet list — adequate but slightly harder to scan for a developer than named subsections. At this PRD's scale this is a style note, not a flaw.

- **low** §9 MVP Scope and §8 Non-Goals overlap — §8 Non-Goals is the cleaner list; §9.2 "Out of Scope for MVP" partially restates it with nuance. For a three-page site this is fine but a reader doing a quick scope check may look in one and miss the other. *Fix:* Consider a sentence at the top of §9.2: "The following items are not in §8 Non-Goals because they may appear in a later version; they are deferred from v1 specifically."

---

## Mechanical notes

**Glossary drift:**
- "BMad Method" — used in §1 and FR-4, absent from §3 Glossary.
- "Session Track" — in §3 Glossary, used correctly in FR-6. No drift.
- "Spark Section" — in §3, used in FR-2, consistent.
- "Credibility Block" — in §3, used in FR-4, consistent.

**ID continuity:**
- FR-1 through FR-13: contiguous, no gaps. Correctly distributed across §6.1 (FR-1–5), §6.2 (FR-6–7), §6.3 (FR-8–9), §6.4 (FR-10–13).
- SM-1 through SM-4, SM-C1: present and labeled consistently.
- UJ-1 through UJ-3: present and labeled consistently.
- No cross-reference errors between SM and FR beyond the SM-4/FR-8 omission noted above.

**Assumptions Index roundtrip:**
- All inline [ASSUMPTION] tags have a corresponding §12 entry — verified for FR-2, FR-7, FR-10, FR-12, §4, and §7.
- One assumption used in §7 (root-relative routing / no subdirectory) appears only in §12, not tagged inline in the NFR section. Low risk.
- Duplicate AWS hosting entry in §12 — flag for cleanup.
- Section reference error in §12: "§6.2 FR-2" should be "§6.1 FR-2."
- Photo assumption (§9.2) not in §12 — minor gap.
- Terraform scope assumption not tagged inline or in §12 — the one unindexed material assumption.
