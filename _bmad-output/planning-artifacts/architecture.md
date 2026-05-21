---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8]
lastStep: 8
status: 'complete'
completedAt: '2026-05-20'
inputDocuments:
  - _bmad-output/planning-artifacts/briefs/brief-kode-kids-2026-05-20/brief.md
  - _bmad-output/planning-artifacts/prds/prd-kode-kids-2026-05-20/prd.md
workflowType: 'architecture'
project_name: 'kode-kids'
user_name: 'Greg'
date: '2026-05-20'
---

# Architecture Decision Document

_This document builds collaboratively through step-by-step discovery. Sections are appended as we work through each architectural decision together._

## Project Context Analysis

### Requirements Overview

**Functional Requirements:**
13 FRs across four groups: Homepage (FR-1–5), Services/Sessions (FR-6–7), Contact (FR-8–9),
and Site-Wide (FR-10–13). All requirements are presentational — static copy, images, links,
and an analytics tag. No dynamic data, no forms, no user-generated content.

**Non-Functional Requirements:**
- Hosting: AWS (S3 + CloudFront) via Terraform — locked in, not a choice
- Performance: <3s page load on 4G mobile; image optimization at build time
- Accessibility: WCAG 2.1 Level A minimum; AA color contrast and 44×44px tap targets where feasible
- Security: HTTPS enforced (CloudFront layer); no user data collected beyond GA4
- Mobile: Minimum 375px viewport; no horizontal scroll; all CTAs tap-target sized
- SEO: Unique title+meta per page; sitemap.xml; robots.txt; descriptive alt attributes; "Langford, British Columbia" in on-page content
- Browser: Modern evergreen (Chrome, Safari, Firefox, Edge); no IE

**Scale & Complexity:**
This is a low-complexity static marketing site. Three pages, ~13 content sections,
one confirmed image asset (Greg's headshot), and one third-party script (GA4).
No real-time features, no multi-tenancy, no regulatory compliance beyond basic HTTPS/WCAG.

- Primary domain: Static web (JAMstack)
- Complexity level: Low
- Estimated architectural components: Build tool, CSS layer, image pipeline, Terraform IaC, CloudFront distribution, S3 bucket

### Technical Constraints & Dependencies

- AWS + Terraform: Hard requirement from PRD §7. Deployment target is S3 static hosting behind a CloudFront CDN distribution.
- Domain: TBD — Greg is registering before launch. All internal links must use root-relative paths until domain is confirmed.
- Static-only: No backend, no database, no authentication, no payment processing — all explicitly excluded in PRD §8.
- Image assets: Greg's headshot confirmed; Project Archetype Card icons/illustrations are TBD — source or creation is a content dependency, not a build dependency.
- Copy: A creative writer is delivering final copy. Developer implements; copy is a dependency of build, not a build deliverable.
- Greenfield build: Existing HTML files in project root are discarded. Complete rebuild from scratch.

### Cross-Cutting Concerns Identified

- **Performance:** Image compression + CloudFront CDN are the primary levers. All pages affected.
- **SEO:** Per-page title, meta description, sitemap.xml, robots.txt. Affects all 3 pages.
- **Accessibility:** WCAG 2.1 Level A across all components. Color contrast and tap targets AA where feasible.
- **Mobile responsiveness:** 375px breakpoint enforced throughout. All CTAs must be tap-target sized.
- **Analytics:** GA4 tag on every page. Script injection must not block render.
- **HTTPS:** Enforced at CloudFront level — not a build concern, but a deployment concern.
- **Infrastructure as Code:** All AWS resources (S3, CloudFront, DNS once domain exists) managed via Terraform.

## Starter Template Evaluation

### Primary Technology Domain

Static web (JAMstack) — 3-page marketing site, no backend, S3 + CloudFront deployment.

### Starter Options Considered

- **Astro (minimal template)** — Purpose-built for content/marketing sites; zero JS by default; built-in image optimization, sitemap generation, and per-page SEO meta. Selected.
- **Next.js 16 (static export)** — Viable but over-engineered for 3 static pages; React hydration overhead not justified.
- **Vite + Vanilla** — Maximum control but requires manual SEO, sitemap, and image pipeline setup.

### Selected Starter: Astro (minimal template)

**Rationale:** Purpose-built for static marketing sites. Ships zero JS by default, handles image optimization and sitemap natively, and produces clean HTML+CSS output that deploys directly to S3. Cleanest fit for the project constraints.

**Initialization Command:**

```bash
npm create astro@latest kode-with-greg -- --template minimal
```

**Architectural Decisions Provided by Starter:**

**Language & Runtime:** TypeScript (strict mode), Node.js build

**Styling Solution:** None prescribed — decided in next step (Tailwind CSS recommended for responsive design system)

**Build Tooling:** Vite under the hood; `npm run build` outputs static `dist/` folder ready for S3 sync

**Image Optimization:** Built-in `<Image>` component — automatic compression and format conversion at build time

**SEO:** `@astrojs/sitemap` plugin for sitemap.xml; per-page `<head>` slots for title/meta/OG tags

**Analytics:** GA4 script tag injected via shared layout component (non-blocking)

**Code Organization:** File-based routing (`src/pages/index.astro`, `sessions.astro`, `contact.astro`)

**Development Experience:** Vite HMR, TypeScript, Astro VS Code extension

**Note:** Project initialization using this command should be the first implementation story.

## Core Architectural Decisions

### Decision Priority Analysis

**Critical Decisions (Block Implementation):**
- Styling: Tailwind CSS v4 via @tailwindcss/vite
- CI/CD: GitHub Actions → S3 sync + CloudFront invalidation
- Terraform: Single flat terraform/ directory

**Deferred Decisions (Post-MVP):**
- DNS/Route53 configuration — pending domain registration
- CloudFront custom domain + ACM certificate — pending domain

### Frontend Architecture

**Styling Solution:**
Tailwind CSS v4 via `@tailwindcss/vite` Vite plugin (not the deprecated `@astrojs/tailwind`).
Configured via `src/styles/global.css` with `@import "tailwindcss"`. No `tailwind.config.mjs` required.
Setup: `npx astro add tailwind`

**Component Architecture:**
- Shared `src/layouts/BaseLayout.astro` — wraps all pages; injects `<head>` meta, GA4 script, nav, footer
- Page files: `src/pages/index.astro`, `src/pages/sessions.astro`, `src/pages/contact.astro`
- Reusable components in `src/components/` (e.g., `CTAButton.astro`, `ProjectCard.astro`, `Nav.astro`)

**Routing:** Astro file-based routing — no configuration required

**Performance:** Astro ships zero JS by default; Tailwind purges unused classes at build time;
Astro `<Image>` handles compression and format conversion

### Infrastructure & Deployment

**CI/CD Pipeline:**
GitHub Actions workflow on push to `main`:
1. `npm ci`
2. `npm run build`
3. `aws s3 sync dist/ s3://$BUCKET_NAME --delete`
4. CloudFront cache invalidation (`aws cloudfront create-invalidation`)

AWS credentials stored as GitHub Actions secrets.

**Terraform Structure:**
Single `terraform/` directory. Resources:
- S3 bucket (static website hosting, public read policy)
- CloudFront distribution (S3 origin, HTTPS redirect, caching)
- ACM certificate — deferred until domain registered
- Route53 hosted zone + records — deferred until domain registered

**Environment Config:**
- `BUCKET_NAME` and `DISTRIBUTION_ID` as GitHub Actions secrets
- No `.env` file needed — site is fully static, no runtime secrets

### Decision Impact Analysis

**Implementation Sequence:**
1. Init Astro project (`npm create astro@latest`)
2. Add Tailwind v4 (`npx astro add tailwind`)
3. Add `@astrojs/sitemap` integration
4. Build BaseLayout with GA4, nav, meta slots
5. Build pages and components
6. Write Terraform for S3 + CloudFront
7. Wire GitHub Actions deploy workflow

**Cross-Component Dependencies:**
- BaseLayout must exist before any page is built
- Terraform S3 bucket must exist before GitHub Actions can deploy
- Domain + ACM cert blocks HTTPS custom domain — deploy on CloudFront default domain first

## Implementation Patterns & Consistency Rules

### Naming Patterns

**Component Files:** PascalCase `.astro` files
- Correct: `CTAButton.astro`, `ProjectCard.astro`, `SessionTrack.astro`
- Wrong: `cta-button.astro`, `ctaButton.astro`

**Page Files:** kebab-case (Astro convention for URL slugs)
- Correct: `index.astro`, `sessions.astro`, `contact.astro`

**TypeScript:** Interfaces PascalCase, variables/props camelCase
- Component props: `interface Props { headline: string; ctaText: string }`

**CSS Classes:** Tailwind utilities inline; no custom class names except for
`btn-primary` / `btn-secondary` defined via `@layer components` in `global.css`

### Structure Patterns

```
src/
  assets/
    images/        # All image assets (Greg's headshot, card icons)
  components/      # Reusable .astro components
  layouts/
    BaseLayout.astro  # THE ONLY layout — wraps every page
  pages/
    index.astro
    sessions.astro
    contact.astro
  styles/
    global.css     # @import "tailwindcss" + @layer components overrides
terraform/         # Flat: main.tf, variables.tf, outputs.tf
.github/workflows/ # deploy.yml
```

### Critical Rules — All Agents MUST Follow

**1. Always use BaseLayout**
Every page MUST use `<BaseLayout>`. Never manage `<head>`, nav, or footer directly in a page file.

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---
<BaseLayout title="Page Title" description="Meta description">
  <!-- page content -->
</BaseLayout>
```

**2. Always use Astro `<Image>` — never raw `<img>`**

```astro
// Correct
import { Image } from 'astro:assets';
import gregPhoto from '../assets/images/greg.jpg';
<Image src={gregPhoto} alt="Greg Pascucci, founder of Kode With Greg" />

// Wrong
<img src="/images/greg.jpg" alt="Greg" />
```

**3. Always use root-relative links — never hardcode the domain**

```astro
// Correct
<a href="/sessions">Sessions</a>
<a href="/contact">Contact</a>

// Wrong
<a href="https://kodewithgreg.com/sessions">Sessions</a>
```

**4. GA4 lives only in BaseLayout**
Never add the GA4 `<script>` tag in a page file. It is injected once in
`BaseLayout.astro`'s `<head>` with `is:inline`.

**5. Mobile-first Tailwind — sm: → md: → lg:**
All responsive styles start from the smallest breakpoint and scale up.

```html
<!-- Correct -->
<div class="flex flex-col md:flex-row">

<!-- Wrong -->
<div class="flex flex-row md:flex-col">
```

**6. CTA buttons must meet tap target size**
All interactive elements: `min-h-[44px] px-6 py-3` minimum via the
`btn-primary` component class.

### Anti-Patterns

- Raw `<img>` tags — always use `<Image>`
- Absolute URLs in `href` — always root-relative
- Inline `<style>` blocks for layout — use Tailwind utilities
- `@apply` for one-off styles — only for shared button/CTA classes
- Page-level `<head>` management — always through BaseLayout props
- Decorative images without `alt=""` — set `alt=""` explicitly for decorative, meaningful alt text for content images

## Project Structure & Boundaries

### Complete Project Directory Structure

```
kode-with-greg/
├── README.md
├── package.json
├── astro.config.mjs          # Astro config: sitemap integration, Tailwind vite plugin
├── tsconfig.json
├── .gitignore
│
├── public/
│   ├── robots.txt            # FR-13: SEO
│   └── favicon.ico
│
├── src/
│   ├── assets/
│   │   └── images/
│   │       ├── greg.jpg      # FR-4: Confirmed headshot
│   │       └── cards/        # FR-2: Project Archetype Card icons (TBD — content dep)
│   │
│   ├── layouts/
│   │   └── BaseLayout.astro  # FR-10, FR-11, FR-13: nav, GA4, <head> meta, footer
│   │
│   ├── components/
│   │   ├── Nav.astro              # FR-10: Persistent nav with CTA button
│   │   ├── Hero.astro             # FR-1: Hero section
│   │   ├── SparkSection.astro     # FR-2: Project Archetype Cards container
│   │   ├── ProjectCard.astro      # FR-2: Single archetype card (reusable, slot-based)
│   │   ├── HowItWorks.astro       # FR-3: Three-step section
│   │   ├── CredibilityBlock.astro # FR-4: Greg bio + photo + LinkedIn + GitHub
│   │   ├── CTAButton.astro        # FR-5, FR-7, FR-10: Reusable CTA button
│   │   ├── CTABanner.astro        # FR-5, FR-7: Full-width CTA section (footer + mid-page)
│   │   ├── SessionTrack.astro     # FR-6: Single session track card (reusable)
│   │   ├── SessionTracks.astro    # FR-6: Three-track container + logistics block
│   │   └── ContactInfo.astro      # FR-8, FR-9: Email, phone, Facebook link
│   │
│   ├── pages/
│   │   ├── index.astro       # Homepage: Hero + Spark + HowItWorks + Credibility + CTABanner
│   │   ├── sessions.astro    # Services page: SessionTracks + CTABanner (×2)
│   │   └── contact.astro     # Contact page: ContactInfo
│   │
│   └── styles/
│       └── global.css        # @import "tailwindcss" + @layer components (btn-primary, btn-secondary)
│
├── terraform/
│   ├── main.tf               # S3 bucket + CloudFront distribution
│   ├── variables.tf          # bucket_name, aws_region, tags
│   └── outputs.tf            # bucket_name, cloudfront_domain, distribution_id
│
└── .github/
    └── workflows/
        └── deploy.yml        # push to main → build → s3 sync → CF invalidation
```

### Requirements to Structure Mapping

| FR | Component/File |
|---|---|
| FR-1 Hero | `src/components/Hero.astro` |
| FR-2 Spark Section | `src/components/SparkSection.astro` + `ProjectCard.astro` |
| FR-3 How It Works | `src/components/HowItWorks.astro` |
| FR-4 Credibility Block | `src/components/CredibilityBlock.astro` + `src/assets/images/greg.jpg` |
| FR-5 Footer CTA | `src/components/CTABanner.astro` (reused) |
| FR-6 Session Tracks | `src/components/SessionTracks.astro` + `SessionTrack.astro` |
| FR-7 Services CTA | `src/components/CTABanner.astro` (reused) |
| FR-8 Contact Info | `src/components/ContactInfo.astro` |
| FR-9 Facebook Link | `src/components/ContactInfo.astro` |
| FR-10 Persistent Nav | `src/components/Nav.astro` → via `BaseLayout.astro` |
| FR-11 GA4 | `src/layouts/BaseLayout.astro` (`<head>`, `is:inline`) |
| FR-12 Mobile | Tailwind mobile-first throughout all components |
| FR-13 SEO | `BaseLayout.astro` (title/meta), `public/robots.txt`, `astro.config.mjs` (sitemap) |

### External Integrations

| Integration | Location | Status |
|---|---|---|
| Google Analytics GA4 | `BaseLayout.astro` | Measurement ID TBD |
| LinkedIn | `CredibilityBlock.astro` | `https://www.linkedin.com/in/gregpascucci/` |
| GitHub | `CredibilityBlock.astro` | `https://github.com/gpascucci` |
| Facebook | `ContactInfo.astro` | URL TBD — pending page rename |
| AWS S3 | `terraform/main.tf` + `deploy.yml` | Bucket name TBD |
| CloudFront | `terraform/main.tf` + `deploy.yml` | Distribution ID post-Terraform |

### Data Flow

```
Developer pushes to main
  → GitHub Actions: npm ci → npm run build
  → Astro: compiles .astro → static HTML/CSS in dist/
  → aws s3 sync dist/ → S3 bucket
  → CloudFront invalidation → cached pages purged
  → Visitor hits CloudFront edge → serves from S3
```

## Architecture Validation Results

### Coherence Validation ✅

**Decision Compatibility:**
Astro (minimal) + Tailwind v4 via `@tailwindcss/vite` confirmed compatible. TypeScript
is first-class in Astro. `@astrojs/sitemap` is an official integration. GitHub Actions
S3 sync + CloudFront invalidation is a standard, well-documented pattern. Flat Terraform
structure matches the scope of the AWS resources. No version conflicts or contradictory
decisions found.

**Pattern Consistency:**
PascalCase component naming aligns with Astro conventions. Mobile-first Tailwind breakpoints
align with the 375px minimum viewport requirement. BaseLayout centralizes `<head>`, GA4,
nav, and footer — no page-level duplication risk. Root-relative links honour the domain-TBD
constraint without requiring updates at launch.

**Structure Alignment:**
File-based routing matches the 3-page structure exactly. All 13 FRs map to specific named
files. Terraform flat structure matches a single S3 bucket + CloudFront distribution.
GitHub Actions workflow path aligns with the build output directory (`dist/`).

### Requirements Coverage Validation ✅

**Functional Requirements Coverage:**
All 13 FRs are architecturally supported with named component files. See Requirements to
Structure Mapping table in Project Structure section.

**Non-Functional Requirements Coverage:**
- Performance: Astro zero JS by default + CloudFront CDN edge caching + Astro `<Image>`
  compression meets <3s on 4G.
- Accessibility: Semantic HTML rule + explicit alt text pattern + `min-h-[44px]` tap
  targets via `btn-primary` class covers WCAG 2.1 Level A with AA tap targets.
- Security: HTTPS enforced at CloudFront layer. No user data collected. No secrets in
  source code.
- Mobile: Tailwind mobile-first (375px base) throughout all components.
- SEO: `@astrojs/sitemap` generates `sitemap.xml`; `public/robots.txt`; `BaseLayout.astro`
  manages unique title + meta per page; "Langford, British Columbia" in page content.
- Browser: Astro outputs standard HTML/CSS; Tailwind targets modern evergreen browsers.

### Gap Analysis Results

**Important Gaps (non-blocking — required before launch):**

| Gap | Location | Action |
|---|---|---|
| GA4 Measurement ID | `BaseLayout.astro` | Greg to provide ID; inject as env var or hardcode |
| Facebook page URL | `ContactInfo.astro` | Confirm after page rename from "Kode Kids" |
| Domain name | `terraform/variables.tf`, ACM, Route53 | Register domain; update Terraform + CloudFront |
| Card icons/illustrations | `src/assets/images/cards/` | Source or create 4 icons (content dep, not build dep) |

**Nice-to-Have Gaps (post-launch):**
- Visual regression testing (e.g., Playwright screenshots) — not required for v1 static site

### Architecture Completeness Checklist

**Requirements Analysis**
- [x] Project context thoroughly analyzed
- [x] Scale and complexity assessed
- [x] Technical constraints identified
- [x] Cross-cutting concerns mapped

**Architectural Decisions**
- [x] Critical decisions documented with versions
- [x] Technology stack fully specified
- [x] Integration patterns defined
- [x] Performance considerations addressed

**Implementation Patterns**
- [x] Naming conventions established
- [x] Structure patterns defined
- [x] Communication patterns specified
- [x] Process patterns documented

**Project Structure**
- [x] Complete directory structure defined
- [x] Component boundaries established
- [x] Integration points mapped
- [x] Requirements to structure mapping complete

### Architecture Readiness Assessment

**Overall Status:** READY FOR IMPLEMENTATION

**Confidence Level:** High

**Key Strengths:**
- Zero-JS static output is the best possible performance baseline for this site
- Every FR has a named, bounded component — no ambiguity for implementing agents
- BaseLayout as single source of truth for head/nav/analytics prevents duplication bugs
- Deferred decisions (domain, ACM, Route53) are cleanly isolated and don't block MVP build

**Areas for Future Enhancement:**
- Visual regression testing once design is stable
- `sitemap.xml` domain prefix will need updating once domain is registered
- Route53 + ACM cert wired into Terraform once domain is confirmed

### Implementation Handoff

**AI Agent Guidelines:**
- Follow all architectural decisions exactly as documented
- Use implementation patterns consistently across all components
- Every page MUST use BaseLayout — no exceptions
- Never use raw `<img>` — always `<Image>` from `astro:assets`
- Never hardcode the domain in links — always root-relative

**First Implementation Priority:**

```bash
npm create astro@latest kode-with-greg -- --template minimal
npx astro add tailwind
npx astro add sitemap
```
