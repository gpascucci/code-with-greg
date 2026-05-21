---
title: "Kode With Greg — Marketing Website"
status: final
created: 2026-05-20
updated: 2026-05-20
---

# PRD: Kode With Greg Marketing Website

## 0. Document Purpose

This PRD defines requirements for the Kode With Greg marketing website — the public front door for Greg's local, in-person AI and web-building teaching service. It is written for the developer building the site, any UX/design collaborator, and Greg as the product owner. Features are grouped by page with FRs nested under each. Assumptions are tagged `[ASSUMPTION]` inline and indexed in §12. The product brief (`_bmad-output/planning-artifacts/briefs/brief-kode-kids-2026-05-20/brief.md`) is the upstream input and is not duplicated here.

---

## 1. Vision

Kode With Greg is a local, in-person teaching service run by Greg Pascucci out of his garage. He teaches everyday people — hobbyists, parents, and entrepreneurs — to build real things using modern AI tools: LLMs, generative AI, and the BMad Method. Sessions run Saturdays, in small groups, for people who want to leave with something real rather than watch another tutorial.

The website exists to do one thing: spark a project idea in the visitor's mind and convert that spark into a direct reach-out to Greg. The site succeeds when someone thinks *"I could build that"* and picks up the phone or sends an email. It does not explain AI. It does not sell a course. It makes the visitor picture themselves building something and removes every barrier between that picture and contacting Greg.

The website speaks to adults — the hobbyist, the parent booking a spot for their kid, the entrepreneur with a business idea. The voice is direct and confident. Every sentence commits. No hedging, no passive constructions, no "you might be able to."

---

## 2. Target Users

### 2.1 Personas

**Persona A — Curious Hobbyist**
An adult who wants to build something real — a personal site, a game, a Raspberry Pi project — but has never found a path that met them where they are. Beginner-friendly is non-negotiable. They've heard of AI and ChatGPT but haven't made it work for them. They respond to concrete outcomes and approachable instruction over technical depth.

**Persona B — Local Parent**
A parent looking for a practical, hands-on tech activity for their kid. Not gaming, not passive screen time — something that produces a real result. They are the website's reader; their kid is the session attendee.

**Persona C — Local Entrepreneur**
Someone with a business idea — a side hustle, a small shop, a service they want to take online — who needs a web presence but doesn't want to pay an agency or get lost in no-code tools. They want to understand and own what they build.

### 2.2 Jobs To Be Done

- See myself in the outcome before I commit to anything
- Understand what I'll walk away with after one Saturday
- Trust that Greg can meet me at my skill level
- Know exactly how to contact Greg and what to say
- Feel like this is for people like me, not developers

### 2.3 Non-Users (v1)

- Kids browsing directly (site speaks to adults; parents book for kids)
- Developers seeking advanced training
- Remote or online learners (service is in-person only)

### 2.4 Key User Journeys

**UJ-1. The hobbyist decides to reach out.**
A curious adult hears about Kode With Greg from a neighbor. They search for it and land on the homepage. They scroll, see a project archetype that matches something they've always wanted to build (FR-2), understand it's one Saturday and $200 (FR-3), and email Greg with their idea (FR-8). Relies on: FR-1, FR-2, FR-3, FR-8.

**UJ-2. The parent checks if it's right for their kid.**
A parent lands on the homepage. They want to know: is this appropriate for a kid, what will their kid actually do, and can they trust Greg. They find the answers in the Spark Section (FR-2) and the Credibility Block (FR-4), navigate to Services to see what a session looks like (FR-6), and call Greg to ask about a spot (FR-8). Relies on: FR-2, FR-4, FR-6, FR-8.

**UJ-3. The entrepreneur sees the path to their idea.**
A local business owner has been putting off building a website for their shop. They land on the site, see "Build a Business" as an explicit Session Track (FR-6), understand Greg will help them get there in a single Saturday, and email Greg with a description of what they want to build (FR-8). Relies on: FR-1, FR-6, FR-7, FR-8.

---

## 3. Glossary

- **Session** — A single Saturday group class run by Greg, focused on a shared goal. One session = one Saturday = $200/person.
- **Session Track** — One of three goal-grouped categories a session falls into: Build a Business, Build Something, Play Around.
- **Spark Section** — The homepage section displaying Project Archetype Cards, designed to ignite a project idea in the visitor.
- **Project Archetype Card** — A single card in the Spark Section representing one category of buildable project (e.g., business website, game, Raspberry Pi project, online store).
- **CTA** — Call to action. On this site, always resolves to contacting Greg via email or phone call.
- **Credibility Block** — The homepage section establishing Greg's professional background in brief, confident terms.

---

## 4. Information Architecture

The site has three pages. Navigation is persistent across all pages and always exposes the CTA.

| Page | Primary Job |
|---|---|
| Homepage | Ignite an idea → contact Greg |
| Services & Sessions | Describe the three Session Tracks → contact Greg |
| Contact | Make reaching out frictionless |

Navigation: Home · Sessions · Contact · [CTA button: "Let's Talk"]

[ASSUMPTION: a simple top nav with three links and a CTA button covers the navigation need; no footer nav, no mega-menu, no mobile hamburger sub-menu beyond these three items.]

---

## 5. Aesthetic and Tone

### Voice

Direct, confident, action-first. Every sentence commits to an outcome. Verb-forward copy: "You'll build," "You'll leave with," "Show up." No hedging language: never "might," "could help you explore," "perhaps," "you may be able to." The reader should feel like Greg is talking to them, not at them.

### Visual Direction

"Italian and cool" — confident, clean, stylish without being fussy. Local and human in feel, not corporate SaaS. The garage is a feature, not a liability; the design must convey warmth, informality, and local specificity. Designs that read as a corporate e-learning platform, SaaS product, or polished online course fail this requirement.

Color palette, typography, and visual system are delegated to the UX designer. No brand assets exist at the time of this writing.

A confirmed photo of Greg is available for use in the Credibility Block. It is a clean, approachable headshot — casual polo, plain background, direct eye contact. Consistent with the "garage energy" brand direction.

---

## 6. Features

### 6.1 Homepage

The homepage is the primary conversion surface. It moves the visitor from "what is this?" to "I want to reach out" in a single scroll.

**Description:** The homepage opens with a hero section that answers "is this for me?" before anything else. It then shows concrete project outcomes (the Spark Section), explains how a session works in three steps, establishes Greg's credibility briefly, and closes with a direct contact CTA. Every section is a beat in the same argument.

#### FR-1: Hero Section

The homepage displays a hero section above the fold containing: an outcome-focused headline, a one-sentence subhead, and a single CTA button linking to the Contact page.

**Consequences (testable):**
- Headline communicates what the visitor will be able to build, not what Greg teaches
- CTA button is visible without scrolling on a standard mobile viewport (375px wide)
- No secondary CTAs or navigation links compete with the primary CTA above the fold
- Subhead does not exceed two lines at 375px viewport width
- Copy explicitly names in-person instruction (not online, not video, not a course)
- Copy is accessible to total beginners — no prior coding or AI experience implied as prerequisite

**Notes:** Headline copy is owned by the creative writer, reviewed and approved by Greg. `[NOTE FOR PM]` — headline must be validated against the voice rule (zero hedging, verb-forward) and the differentiator rule (in-person, beginner-accessible, practitioner-taught — not a YouTuber, not a tutorial). The creative writer must receive the product brief as their creative brief.

#### FR-2: Spark Section — Project Archetype Cards

The homepage displays a Spark Section containing exactly four Project Archetype Cards. Each card represents one buildable project category. The four archetypes at launch: **business website**, **game**, **Raspberry Pi project**, **online store**.

**Consequences (testable):**
- Four cards render in a grid or card layout (layout decision owned by UX)
- Each card contains: a category title, a one-sentence outcome description, and [ASSUMPTION: an icon or simple illustration]
- Card copy is outcome-phrased, not tech-stack-phrased (e.g., "A booking page for your business" not "HTML/CSS website")
- Section is built with a slot-based structure: swapping a card's copy and image requires only content changes, no layout changes
- No card references a specific real student at launch (v1 uses archetypes; real stories are a v2 content update)

**Out of Scope:**
- Real student testimonials or named case studies (v2, when student wins exist)

#### FR-3: How It Works Section

The homepage displays a three-step "How It Works" section. Steps: (1) Pick an idea, (2) Show up Saturday, (3) Build something real.

**Consequences (testable):**
- Exactly three steps, in numbered order
- Each step has a title and one sentence of supporting copy
- Section renders before the Credibility Block in scroll order

#### FR-4: Greg Credibility Block

The homepage displays a Credibility Block establishing Greg's professional background. Content: 20+ years as a professional developer, LLM-native since 2024, teaches the BMad Method and modern AI workflows, small groups, Saturday sessions.

**Consequences (testable):**
- Block does not exceed four sentences
- Includes a photo of Greg (confirmed available — clean headshot, casual polo, plain background)
- Does not list technologies as a curriculum inventory; frames Greg's background in terms of what it means for the student
- Includes a link to Greg's LinkedIn profile (https://www.linkedin.com/in/gregpascucci/) opening in a new tab
- Includes a link to Greg's GitHub profile (https://github.com/gpascucci) opening in a new tab
- Renders after the How It Works section and before the footer CTA

#### FR-5: Homepage Footer CTA

The homepage closes with a repeated CTA section above the site footer. Copy variant of the hero CTA; same destination (Contact page).

**Consequences (testable):**
- CTA section is the last content section before the footer
- Contains: a short closing line and a CTA button linking to Contact
- Does not duplicate the hero headline verbatim; uses a variant

---

### 6.2 Services & Sessions Page

**Description:** The Services page describes the three Session Tracks so visitors can self-identify before reaching out. It does not ask visitors to choose their track or book — Greg makes that assessment through conversation. The page's job is to make each of the three personas say "that's the one for me" and then contact Greg.

#### FR-6: Session Track Display

The Services page displays the three Session Tracks: **Build a Business**, **Build Something**, **Play Around**.

**Consequences (testable):**
- Each track is a distinct, named section (or card)
- Each track contains: a name, a one-paragraph description of what you'd work on and what you'd walk away with, and the audience it's for
- Track copy uses outcome language, not curriculum language
- Track descriptions contrast with passive learning — copy positions sessions as hands-on and in-person, not instructional video or self-paced tutorial
- "Build a Business" speaks to Persona C (entrepreneur); "Build Something" speaks to Persona A (hobbyist) and Persona B (parent/kid); "Play Around" speaks to anyone curious but without a specific project
- Logistics (price, day, format) appear once on the page, not repeated per track

**Track logistics block (appears once):**
- $200 per person per session
- Saturday sessions
- Small groups
- Payment: cash or e-transfer

#### FR-7: Services Page CTA

The Services page contains a CTA that directs the visitor to contact Greg. Copy must make clear that Greg determines which Session Track fits — the visitor does not self-select.

**Consequences (testable):**
- CTA appears at least once: at the bottom of the page
- [ASSUMPTION: also appears after the track display, mid-page, for visitors who self-identify early]
- Copy variant of: "Not sure which fits you? Talk to Greg — he'll figure it out."

---

### 6.3 Contact Page

**Description:** The Contact page makes reaching Greg as frictionless as possible. No form. No booking widget. Just Greg's contact information and a warm, direct invitation to reach out.

#### FR-8: Contact Information Display

The Contact page displays Greg's email address and phone number, both as active links (mailto and tel respectively).

**Consequences (testable):**
- Email is a `mailto:` link; tapping/clicking opens the user's email client
- Phone is a `tel:` link; tapping on mobile initiates a call
- Both are visible above the fold on mobile
- Page includes a one-sentence prompt: e.g., "Tell Greg what you want to build."

#### FR-9: Facebook Page Link

The Contact page includes a link to the Kode With Greg Facebook page. Greg is renaming his existing "Kode Kids" Facebook page to "Kode With Greg" before launch.

**Consequences (testable):**
- Facebook link is present on the Contact page
- Link opens in a new tab
- Link is verified live before deploy

---

### 6.4 Site-Wide Elements

#### FR-10: Persistent Navigation with CTA

All pages share a persistent top navigation bar containing: site name/logo (links to Homepage), navigation links (Home, Sessions, Contact), and a CTA button ("Let's Talk" or equivalent) that links to the Contact page.

**Consequences (testable):**
- Nav is visible on all three pages
- CTA button is present in the nav on all pages
- On mobile, nav collapses to a usable format [ASSUMPTION: hamburger menu or equivalent; layout owned by UX]
- Active page is visually indicated in the nav

#### FR-11: Analytics

The site integrates Google Analytics (GA4). Page views and referral sources are tracked across all pages.

**Consequences (testable):**
- GA4 tracking code loads on all three pages
- Page views are recorded per page
- Referral source is captured (so Greg can ask "how'd you find me?" and cross-check)

#### FR-12: Mobile Responsiveness

All pages render correctly and are fully usable on mobile viewports (minimum 375px width). [ASSUMPTION: mobile-friendly is sufficient for v1; a separate mobile-first design pass is not required, but all content and CTAs must be accessible without horizontal scrolling.]

**Consequences (testable):**
- No horizontal scroll at 375px viewport width
- CTA buttons are tap-target sized (minimum 44×44px)
- Text is legible without zoom at 375px
- Images scale without overflow

#### FR-13: Local SEO Basics

The site includes basic on-page SEO to support local discoverability.

**Consequences (testable):**
- Each page has a unique `<title>` tag and `<meta description>` referencing the local service
- Homepage includes "Langford, British Columbia" in page content
- Site has a valid `sitemap.xml` and `robots.txt`
- Images have descriptive `alt` attributes

---

## 7. Cross-Cutting NFRs

- **Domain:** Dedicated domain — Greg is registering one before launch. `[NOTE FOR PM: domain name TBD — update this section once registered.]` All internal links use root-relative paths. No subdirectory routing required.
- **Hosting:** AWS, provisioned via Terraform. [ASSUMPTION: static site hosting (e.g., S3 + CloudFront); no backend or database required for v1.]
- **Performance:** Pages load in under 3 seconds on a 4G mobile connection. Images are optimized at build time.
- **Accessibility:** WCAG 2.1 Level A compliance minimum. Color contrast and tap targets meet AA where feasible.
- **Security:** HTTPS enforced. No user data collected beyond analytics.
- **Browser support:** Modern evergreen browsers (Chrome, Safari, Firefox, Edge). No IE support.
- **Location:** Langford, British Columbia. This location name is confirmed for use in on-page content and local SEO metadata.

---

## 8. Non-Goals (Explicit)

- Automated booking or calendar integration — contact is direct (email/phone) only
- Student project gallery or showcase — no student work to display at launch
- Blog, resource library, or tutorial content — Greg's teaching happens in person
- Online course or video content — out of scope for v1 and v2
- User accounts, login, or any authenticated surface
- Payment processing — cash and e-transfer handled offline
- Backend server or database — v1 is a static site

---

## 9. MVP Scope

### 9.1 In Scope

- Homepage with all five sections (Hero, Spark Section, How It Works, Credibility Block, Footer CTA)
- Services & Sessions page with three Session Tracks and logistics
- Contact page with email, phone, and Facebook link
- Persistent navigation with CTA on all pages
- Google Analytics (GA4)
- Mobile-responsive design
- Basic local SEO
- AWS hosting via Terraform

### 9.2 Out of Scope for MVP

- Real student testimonials or case studies — deferred to v2 when student wins exist `[NOTE FOR PM: Spark Section is slot-designed for easy swap-in; this should be first content update after first cohort]`
- Photography session — photo confirmed available; additional photography not in scope
- Copywriting — the creative writer delivers final copy; the developer implements it. Copy is a dependency of the build, not a build deliverable.

---

## 10. Success Metrics

**Primary**
- **SM-1:** A first-time visitor understands what Kode With Greg is and who it's for within 10 seconds of landing. Validates FR-1, FR-2. *Measurement: qualitative — Greg shows the site to 3–5 local people cold and asks "what is this?" after 10 seconds.*
- **SM-2:** 3 paying attendees per Saturday session ($600/week) within 3 months of launch. Validates overall site effectiveness. *Measurement: Greg tracks bookings and their referral source.*

**Secondary**
- **SM-3:** The site appears in local search results for relevant queries (e.g., "coding class Langford") within 60 days of launch. Validates FR-13. *Measurement: Google Search Console.*
- **SM-4:** Contact page generates at least one inbound email or call per week within the first month of launch. Validates FR-8, FR-9. *Measurement: Greg tracks inbound contacts and their referral source.*
- **SM-5:** Greg is proud to share the URL. Validates overall design and copy quality. *Measurement: subjective — Greg's launch-acceptance gate before the site goes live.*

**Counter-metrics (do not optimize)**
- **SM-C1:** Page view count — do not optimize for traffic volume at the expense of conversion. A site with 10 monthly visitors and 3 bookings outperforms one with 1,000 visitors and 0 bookings. Analytics (FR-11) are for referral insight, not vanity metrics.

---

## 11. Open Questions

All open questions resolved as of 2026-05-20:

1. **Facebook page:** ✅ Greg is renaming his existing "Kode Kids" Facebook page to "Kode With Greg." FR-9 is active.
2. **Greg's photo:** ✅ Confirmed available. Clean headshot, casual polo, plain background.
3. **City/town name on site:** ✅ Langford, British Columbia — confirmed for use in public content and SEO.
4. **Copywriting:** ✅ A creative writer is engaged to write final copy. Greg reviews and approves.
5. **Domain:** Greg is registering a dedicated domain. Name TBD — update NFRs once confirmed.

---

## 12. Assumptions Index

- **§4 IA** — Simple top nav (three links + CTA button) covers full navigation need; no sub-menus required.
- **§6.1 FR-2** — Each Project Archetype Card includes an icon or simple illustration.
- **§6.2 FR-7** — A mid-page CTA appears on the Services page in addition to the bottom CTA.
- **§6.4 FR-10** — Mobile nav collapses to hamburger menu or equivalent; layout owned by UX.
- **§7 NFRs** — v1 is a static site (no backend/database); AWS hosting via S3 + CloudFront or equivalent, root-relative routing.
- **§6.4 FR-12** — Mobile-friendly (responsive) is sufficient for v1; a separate mobile-first design pass is not required, but all content and CTAs must be accessible without horizontal scrolling.
