---
title: "Input Reconciliation — Product Brief vs PRD"
created: 2026-05-20
---

# Input Reconciliation — Product Brief vs PRD

## Summary

The PRD is a strong translation of the brief: the core value proposition, personas, scope boundaries, pricing, and two of the four brief success criteria are well-captured. Two gaps stand out as material: the brief's five explicit "What Makes This Different" differentiators are not anchored anywhere as requirements or copy direction, and Greg's personal biography — which the brief treats as a key credibility asset — is reduced to four sparse content rules in the Credibility Block FR with no requirement that the depth and specificity of his background actually appear on the site. A third gap is the "Garage Energy" tone marker, which the brief uses as a defined brand pillar but the PRD references only once in passing without making it a testable requirement.

---

## Gaps Found

- **high** — Differentiator list not carried forward as requirements — The brief names five explicit competitive differentiators ("What Makes This Different"): in-person/hands-on, accessible to everyone including kids and total beginners, garage energy as a brand pillar, BMad + LLM-native curriculum (contrasted with legacy "learn to code" approaches AI is disrupting), and Greg as a real practitioner (not a YouTuber). None of these appear as FRs, copy-direction requirements, or testable consequences anywhere in the PRD. The PRD references them implicitly through persona descriptions and tone guidance, but a developer or copywriter working only from the PRD has no explicit direction to express these differentiators. Suggested fix: add a "Key Differentiators" subsection to §5 (Aesthetic and Tone) or §6.1 (Homepage) listing these five points as required messaging beats — i.e., the site must communicate each one, even if it doesn't use these exact words.

- **high** — Greg's credibility depth is capped too tightly — The brief devotes a full named section ("About Greg") to his professional biography: 20+ years of software development since 2005, specific Java/PostgreSQL/Oracle/Linux expertise, 3 years of full-stack React/Vue/Angular/Node/NestJS/Express/Spring Boot, Scrum/Agile for 15+ years, and the 2024 pivot to being all-in on LLMs professionally — inventing new processes and patterns using BMad, Claude Code, Codex CLI, Gemini CLI, and GitHub Copilot. The brief explicitly frames this depth as a differentiator ("real practitioner, not a YouTuber"). FR-4 in the PRD limits the Credibility Block to four sentences and prohibits listing technologies as a curriculum inventory. That constraint risks under-communicating Greg's credibility. The four-sentence cap may be right for the homepage, but there is no Services page section or anywhere else where Greg's full background can land. Suggested fix: clarify in FR-4 that the four-sentence cap applies to the homepage Credibility Block specifically, and consider adding an FR or design note for a more expansive credibility treatment on the Services page or a dedicated "About" section — or confirm explicitly that four sentences is intentional and sufficient.

- **medium** — "Garage Energy" is defined in the brief as a brand pillar but is not testable in the PRD — The brief names "Garage Energy" as a differentiator: "low-pressure, informal, community feel — the opposite of a corporate training course." The PRD mentions it once in §5 ("the garage is a feature, not a liability; the design should reflect the intimacy and energy of a real place, not a polished e-learning platform") but it is framing text, not a testable requirement. No FR or consequence verifies that the site does not feel corporate or that it communicates informality. Suggested fix: add a testable consequence to the Visual Direction in §5 or to FR-1 (Hero): e.g., "No stock-photo imagery of offices, classrooms, or generic tech setups" or "Hero section references the physical location/setting (garage) to communicate informality."

- **medium** — Brief's vision / growth trajectory not reflected anywhere in the PRD — The brief closes with an explicit Vision paragraph: Kode With Greg becomes a local community hub; potential expansion to weekend workshops, guest instructors, and a structured curriculum. This is not a v1 requirement, but it has architectural implications — the site should not foreclose that future. The PRD's Non-Goals (§8) correctly defers online courses and booking systems, but there is no note that the information architecture or content structure should accommodate future expansion (e.g., a second instructor, a second location, a workshop format). Suggested fix: add a brief forward-compatibility note in §9.2 (Out of Scope) or §7 (NFRs) noting that the IA and tech choices should not structurally prevent future expansion to multi-instructor or multi-format without a rebuild.

- **low** — "Greg feels proud to hand someone the URL" success criterion is dropped — The brief lists four success criteria. Three map cleanly to PRD metrics (SM-1 for the 10-second comprehension test, SM-2 for the 3-attendees/$600 target, and the community discoverability intent). The fourth — "Greg feels proud to hand someone the URL" — is a qualitative bar for overall design quality and personal brand. It is absent from the PRD's Success Metrics. While subjective, it functions as a practical acceptance gate (Greg won't launch a site he's embarrassed by). Suggested fix: add it as SM-5 with a defined evaluation method: e.g., "Greg reviews the staged site and approves it for launch — his personal bar is a site he would hand to a stranger without hesitation."

---

## Well-Covered

- Core value proposition and service description — accurately and fully carried into §1 (Vision)
- Both primary and secondary personas from the brief — expanded into three well-defined personas in §2.1, with a new Entrepreneur persona (Persona C) that the brief implied but did not name
- Pricing ($200/person/session, cash or e-transfer, Saturday cadence) — captured verbatim in FR-6 logistics block
- All four scope-in items from the brief — Homepage, Services page, CTA throughout, Contact page — map 1:1 to §6 FRs
- All four scope-out items — student showcase, blog, online courses, automated booking — carried faithfully into §8 Non-Goals
- The 10-second comprehension success criterion — SM-1 is a strong, testable operationalization with a concrete measurement method
- The $600/week revenue target — SM-2 matches the brief's "3 paying attendees, $600/week, within the first few months" exactly
- Mobile-friendly requirement — FR-12 with specific viewport and tap-target constraints
- Contact page directness (no form, no widget) — FR-8 and FR-9 faithfully capture the frictionless intent
- Qualitative voice guidance — §5 (Voice) is a strong translation of the brief's implied tone into actionable, testable copy direction
