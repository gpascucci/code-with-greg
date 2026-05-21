---
title: 'Kode With Greg — Full Website Build'
type: 'feature'
created: '2026-05-20'
status: 'done'
baseline_commit: '61b8f7af65dfea7cb1b599945f9dd4d2965f6dec'
context:
  - _bmad-output/planning-artifacts/architecture.md
  - _bmad-output/planning-artifacts/prds/prd-kode-kids-2026-05-20/prd.md
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** Kode With Greg has no public website — the front door for Greg's local in-person tech coaching service doesn't exist. The old placeholder HTML template has been deleted.

**Approach:** Build the complete 3-page static marketing site (Homepage, Sessions, Contact) using the existing Astro v6.3.6 minimal setup, adding Tailwind v4, sitemap, a shared BaseLayout, all page components, and infrastructure (Terraform S3+CloudFront + GitHub Actions deploy).

## Boundaries & Constraints

**Always:**
- Use `<Image>` from `astro:assets` — never raw `<img>`
- Every page uses `BaseLayout.astro` — no page-level `<head>` management
- Internal links are root-relative (`/sessions`, `/contact`) — never hardcode a domain
- Mobile-first Tailwind: base styles → `sm:` → `md:` → `lg:`
- CTA buttons use `btn-primary` class with `min-h-[44px]`
- Tailwind v4 via `@tailwindcss/vite` Vite plugin — NOT the deprecated `@astrojs/tailwind`
- GA4 `<script>` only in BaseLayout `<head>` with `is:inline` — never duplicated in pages
- Component filenames: PascalCase; page filenames: kebab-case
- All 13 FRs from the PRD must be implemented

**Ask First:**
- GA4 Measurement ID — placeholder `G-XXXXXXXXXX` until Greg provides it
- Greg's email address and phone number for the Contact page
- Facebook page URL — placeholder until page renamed from "Kode Kids" to "Kode With Greg"
- Final copy — use descriptive placeholder text; creative writer delivers final headlines/body

**Never:**
- No backend, database, forms, auth, or payment processing
- No `@astrojs/tailwind` integration
- No absolute URLs in internal `href` attributes
- No `@apply` except for `btn-primary` / `btn-secondary` in `global.css`
- No real student testimonials — v1 uses archetype cards only

</frozen-after-approval>

## Code Map

- `package.json` — add `@tailwindcss/vite`, `@astrojs/sitemap`
- `astro.config.mjs` — register Tailwind Vite plugin + sitemap integration
- `src/styles/global.css` — `@import "tailwindcss"` + `@layer components` btn classes
- `src/layouts/BaseLayout.astro` — `<head>`, GA4, nav, footer, per-page title/description props
- `src/components/Nav.astro` — persistent top nav: Home · Sessions · Contact · "Let's Talk"
- `src/components/CTAButton.astro` — reusable CTA button (href + label props)
- `src/components/CTABanner.astro` — full-width CTA section (FR-5, FR-7)
- `src/components/Hero.astro` — FR-1: headline, subhead, CTA button
- `src/components/ProjectCard.astro` — FR-2: slot-based archetype card (title + outcome + icon)
- `src/components/SparkSection.astro` — FR-2: four-card grid container
- `src/components/HowItWorks.astro` — FR-3: three numbered steps
- `src/components/CredibilityBlock.astro` — FR-4: Greg bio + headshot + LinkedIn + GitHub links
- `src/components/SessionTrack.astro` — FR-6: single track card (name + description + audience)
- `src/components/SessionTracks.astro` — FR-6: three-track container + logistics block
- `src/components/ContactInfo.astro` — FR-8, FR-9: mailto + tel + Facebook link
- `src/pages/index.astro` — Homepage: Hero + SparkSection + HowItWorks + CredibilityBlock + CTABanner
- `src/pages/sessions.astro` — Sessions: SessionTracks + CTABanner (mid + bottom)
- `src/pages/contact.astro` — Contact: ContactInfo
- `public/robots.txt` — FR-13: SEO
- `src/assets/images/greg.jpg` — FR-4: Greg's headshot (file must be placed before CredibilityBlock renders)
- `terraform/main.tf` — S3 bucket + CloudFront distribution
- `terraform/variables.tf` — `bucket_name`, `aws_region`
- `terraform/outputs.tf` — `cloudfront_domain`, `distribution_id`, `bucket_name`
- `.github/workflows/deploy.yml` — push to main → `npm ci` → build → S3 sync → CF invalidation

## Tasks & Acceptance

**Execution:**
- [x] `package.json` -- add `@tailwindcss/vite` and `@astrojs/sitemap` to dependencies -- required before any Tailwind or sitemap features work
- [x] `astro.config.mjs` -- add `@tailwindcss/vite` to `vite.plugins` and `@astrojs/sitemap` to `integrations` -- wires Tailwind v4 and sitemap generation
- [x] `src/styles/global.css` -- create with `@import "tailwindcss"` and `@layer components` defining `btn-primary` (solid CTA) and `btn-secondary` (outline variant) with `min-h-[44px]` -- shared button classes used across all CTAs
- [x] `src/layouts/BaseLayout.astro` -- create with `interface Props { title: string; description: string }`, `<head>` meta (title, description, viewport, generator), GA4 placeholder script (`G-XXXXXXXXXX`), global.css import, `<Nav />`, `<slot />`, site footer -- single source of truth for all shared layout
- [x] `src/components/Nav.astro` -- create persistent top nav with logo/site name linking to `/`, nav links (Home, Sessions, Contact), `<CTAButton href="/contact" label="Let's Talk" />`, active page highlight via `Astro.url.pathname` -- FR-10
- [x] `src/components/CTAButton.astro` -- create with `interface Props { href: string; label: string }`, renders `<a>` with `btn-primary` class -- reusable across all CTAs
- [x] `src/components/CTABanner.astro` -- create with `interface Props { heading: string; cta: string }`, full-width section with heading and `<CTAButton>` -- FR-5 and FR-7
- [x] `src/components/Hero.astro` -- create with placeholder headline ("Build something real. This Saturday."), subhead, and `<CTAButton href="/contact" label="Let's Talk" />` visible above fold at 375px -- FR-1
- [x] `src/components/ProjectCard.astro` -- create slot-based card with `interface Props { title: string; outcome: string; icon?: string }`, renders title + outcome text + icon placeholder -- FR-2; slot-based so swapping content requires no layout changes
- [x] `src/components/SparkSection.astro` -- create four-card grid using `<ProjectCard>` for: Business Website, Game, Raspberry Pi Project, Online Store -- FR-2
- [x] `src/components/HowItWorks.astro` -- create three-step numbered section: (1) Pick an idea, (2) Show up Saturday, (3) Build something real -- FR-3
- [x] `src/components/CredibilityBlock.astro` -- create with `<Image src={gregPhoto} alt="Greg Pascucci, founder of Kode With Greg" />`, four-sentence bio, LinkedIn link (`https://www.linkedin.com/in/gregpascucci/` opens new tab), GitHub link (`https://github.com/gpascucci` opens new tab) -- FR-4; requires `src/assets/images/greg.jpg` to be present
- [x] `src/components/SessionTrack.astro` -- create with `interface Props { name: string; description: string; audience: string }`, renders named track card with outcome language -- FR-6
- [x] `src/components/SessionTracks.astro` -- create three `<SessionTrack>` instances (Build a Business, Build Something, Play Around) plus a single logistics block ($200/person, Saturdays, small groups, cash or e-transfer) -- FR-6
- [x] `src/components/ContactInfo.astro` -- create with Greg's email as `<a href="mailto:PLACEHOLDER">`, phone as `<a href="tel:PLACEHOLDER">`, one-sentence prompt ("Tell Greg what you want to build."), Facebook link as `<a href="PLACEHOLDER" target="_blank">` -- FR-8, FR-9; placeholders until Greg provides values
- [x] `src/pages/index.astro` -- assemble Homepage: `<BaseLayout title="Kode With Greg | Learn to Build with AI" description="In-person AI and web-building sessions in Langford, BC. Saturdays, $200/person.">` wrapping Hero + SparkSection + HowItWorks + CredibilityBlock + CTABanner -- FR-1–5
- [x] `src/pages/sessions.astro` -- assemble Sessions page: BaseLayout + SessionTracks + CTABanner (mid-page) + CTABanner (bottom) -- FR-6, FR-7
- [x] `src/pages/contact.astro` -- assemble Contact page: BaseLayout + ContactInfo -- FR-8, FR-9
- [x] `public/robots.txt` -- create: `User-agent: *`, `Allow: /`, `Sitemap: /sitemap-index.xml` -- FR-13
- [x] `terraform/main.tf` -- create S3 bucket resource (static website hosting, public read policy) and CloudFront distribution (S3 origin, default root object `index.html`, HTTPS redirect, price class 100) -- infrastructure for deployment
- [x] `terraform/variables.tf` -- define `bucket_name` (string), `aws_region` (default `us-east-1`) -- parameterised for different environments
- [x] `terraform/outputs.tf` -- output `cloudfront_domain`, `distribution_id`, `bucket_name` -- values needed for GitHub Actions secrets
- [x] `.github/workflows/deploy.yml` -- create workflow: trigger on push to `main`, steps: checkout → setup-node → `npm ci` → `npm run build` → configure AWS credentials (secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) → `aws s3 sync dist/ s3://${{ secrets.BUCKET_NAME }} --delete` → `aws cloudfront create-invalidation --distribution-id ${{ secrets.DISTRIBUTION_ID }} --paths "/*"` -- automated deploy pipeline

**Acceptance Criteria:**
- Given any page, when rendered, then the nav shows Home/Sessions/Contact links and a "Let's Talk" CTA button; the active page is visually indicated
- Given a 375px viewport, when any page loads, then no horizontal scroll occurs and all CTA buttons have a minimum 44px tap target height
- Given `npm run build`, when run from project root, then the command exits 0 and `dist/` is populated
- Given `dist/`, when inspected, then `sitemap-index.xml` and `robots.txt` are present
- Given the Homepage, when rendered, then four Project Archetype Cards display (Business Website, Game, Raspberry Pi Project, Online Store) each with title and outcome copy
- Given the Sessions page, when rendered, then three Session Tracks display (Build a Business, Build Something, Play Around) and the logistics block (price, day, format, payment) appears exactly once
- Given the Contact page, when rendered, then email is a `mailto:` link and phone is a `tel:` link; both visible above fold at 375px
- Given `terraform validate` run in `terraform/`, then output is "Success! The configuration is valid."
- Given a push to `main`, when the workflow runs, then all steps complete without error (assuming secrets are configured)

## Design Notes

**Tailwind v4 setup in Astro — differs from v3:**
```js
// astro.config.mjs
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';
export default defineConfig({
  site: 'https://PLACEHOLDER.com',
  integrations: [sitemap()],
  vite: { plugins: [tailwindcss()] },
});
```
```css
/* src/styles/global.css */
@import "tailwindcss";
@layer components {
  .btn-primary { @apply inline-flex items-center justify-center min-h-[44px] px-6 py-3 bg-black text-white font-semibold rounded-none hover:bg-gray-800 transition-colors; }
}
```

**CredibilityBlock headshot:** Import greg.jpg as a local asset so Astro optimizes it at build time. If the file is missing, the build will error — add a placeholder image first.

## Verification

**Commands:**
- `npm install` -- expected: exits 0, node_modules populated
- `npm run build` -- expected: exits 0, `dist/` populated with HTML, `sitemap-index.xml` present
- `npm run dev` -- expected: dev server starts on port 4321, no console errors
- `terraform validate` (in `terraform/`) -- expected: "Success! The configuration is valid."

## Suggested Review Order

**Shared foundation — start here to understand the design contract**

- Single source of truth for `<head>`, GA4 (loader-first order), nav, footer, slot
  [`BaseLayout.astro:1`](../../src/layouts/BaseLayout.astro#L1)

- Tailwind v4 import + `btn-primary` / `btn-secondary` with 44px min-height
  [`global.css:1`](../../src/styles/global.css#L1)

- Site config: `trailingSlash: 'never'`, Tailwind Vite plugin, sitemap integration
  [`astro.config.mjs:1`](../../astro.config.mjs#L1)

**Navigation**

- Desktop nav + CSS-only mobile hamburger (`<details>`/`<summary>`), trailing-slash-aware active state
  [`Nav.astro:19`](../../src/components/Nav.astro#L19)

**Reusable primitives**

- Renders `<a>` with `btn-primary`/`btn-secondary`; 44px tap target guaranteed by global.css
  [`CTAButton.astro:11`](../../src/components/CTAButton.astro#L11)

- `href` prop with default `/contact`; heading uses `<h2>` for correct outline
  [`CTABanner.astro:7`](../../src/components/CTABanner.astro#L7)

**Homepage sections**

- Above-fold hero: H1, subhead, CTA — visible at 375px
  [`Hero.astro:7`](../../src/components/Hero.astro#L7)

- Four archetype cards; icon `aria-hidden`; slot-based for copy swaps
  [`SparkSection.astro:1`](../../src/components/SparkSection.astro#L1)

- Three numbered steps; step numbers `aria-hidden` so screen readers skip decorative numbers
  [`HowItWorks.astro:25`](../../src/components/HowItWorks.astro#L25)

- `<Image>` from astro:assets (not raw `<img>`); Astro optimises `greg.jpg` to WebP at build time
  [`CredibilityBlock.astro:1`](../../src/components/CredibilityBlock.astro#L1)

**Sessions page**

- Three track cards + logistics block (price, day, format, payment) — logistics appears exactly once
  [`SessionTracks.astro:1`](../../src/components/SessionTracks.astro#L1)

**Contact page**

- `mailto:` live; `tel:` and Facebook rendered as non-linked text until Greg provides values
  [`ContactInfo.astro:10`](../../src/components/ContactInfo.astro#L10)

**Page assembly**

- Homepage: BaseLayout title/description + component composition order
  [`index.astro:10`](../../src/pages/index.astro#L10)

- Sessions: dual CTABanner placement (mid-page + bottom)
  [`sessions.astro:1`](../../src/pages/sessions.astro#L1)

- Contact: BaseLayout + ContactInfo only — no form in v1
  [`contact.astro:1`](../../src/pages/contact.astro#L1)

**Infrastructure & deploy**

- S3 private bucket + CloudFront OAC; no SPA 404→200 fallback (static Astro doesn't need it)
  [`main.tf:68`](../../terraform/main.tf#L68)

- Split S3 sync: immutable cache for hashed assets, must-revalidate for HTML/sitemap/robots
  [`deploy.yml:36`](../../.github/workflows/deploy.yml#L36)

**Peripherals**

- Bucket, region, tags variables
  [`variables.tf:1`](../../terraform/variables.tf#L1)

- Outputs needed for GitHub Actions secrets
  [`outputs.tf:1`](../../terraform/outputs.tf#L1)

- SEO: allow-all + sitemap pointer
  [`robots.txt:1`](../../public/robots.txt#L1)
