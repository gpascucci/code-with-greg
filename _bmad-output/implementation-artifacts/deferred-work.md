# Deferred Work

Items surfaced during review that are pre-existing or pre-launch requirements, not caused by the current implementation.

---

## Before Launch Checklist

### Content Placeholders (Greg must provide)
- **GA4 Measurement ID** — replace `G-XXXXXXXXXX` in `src/layouts/BaseLayout.astro` (2 occurrences)
- **Domain name** — replace `https://PLACEHOLDER.com` in `astro.config.mjs`
- **Facebook page URL** — optionally add once page is renamed from "Kode Kids" to "Kode With Greg" (LinkedIn + GitHub are live in ContactInfo)
- **Greg's headshot** — replace `src/assets/images/greg.jpg` (currently a 1×1 placeholder) with a real photo before deploying

### Infrastructure (one-time setup)
- **Terraform state backend** — currently local state; configure S3 backend before team/CI use
- **GitHub Actions secrets** — configure `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `BUCKET_NAME`, `DISTRIBUTION_ID` in repo settings
- **AWS account** — `terraform apply` not yet run; bucket and CloudFront distribution do not exist

### Copy (creative writer delivers)
- Final homepage headline and subhead (Hero.astro)
- Final CTABanner headings on Sessions and Homepage
- Final four Project Archetype Card titles and outcome copy (SparkSection.astro)
- Final Session Track descriptions (SessionTracks.astro)

---

## Post-Launch Enhancements (future stories)
- Real phone `tel:` link in ContactInfo once number is confirmed
- Real Facebook link in ContactInfo once page is renamed
- Custom 404 page (`src/pages/404.astro`) — currently CloudFront serves a blank S3 XML error
- Contact form (requires backend or third-party service — out of v1 scope per spec)
- Dark mode
