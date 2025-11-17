# Comprehensive Project Plan: Network Penetration Testing Assignment

## Overview
This document provides a step-by-step guide to complete the Network Security and Penetration Testing CA1 assignment for National College of Ireland.

## Phase 1: Research and Planning (Week 1-2)

### Step 1.1: Research Penetration Testing Platforms

**Objective**: Identify and compare online platforms offering penetration testing labs.

**Platforms to Research**:
- HackTheBox (https://www.hackthebox.com/)
- TryHackMe (https://tryhackme.com/)
- VulnHub (https://www.vulnhub.com/)
- PentesterLab (https://pentesterlab.com/)
- OverTheWire (https://overthewire.org/)
- PicoCTF (https://picoctf.org/)
- Root-Me (https://www.root-me.org/)
- CyberDefenders (https://cyberdefenders.org/)

**Deliverable**: Create `REFERENCES/platforms_research.md` with:
- Platform name and URL
- Pros and Cons
- Suitability for network penetration testing
- Pricing/access requirements
- Types of challenges available
- Difficulty levels

### Step 1.2: Select 4 Target Systems

**Requirements**:
- At least 3 systems must be newly released in the past 3 months
- Systems must complement each other (different OS, services, vulnerabilities)
- Must enable complete network penetration test
- Cannot use Metasploitable, DVWA, or lab exercise systems

**Selection Criteria**:
1. **Operating System Diversity**: Mix of Windows, Linux, BSD
2. **Service Diversity**: Web servers, databases, file shares, custom services
3. **Vulnerability Types**: Different exploit categories (buffer overflow, SQL injection, misconfigurations, etc.)
4. **Difficulty Levels**: Mix of easy, medium, hard (as rated by platform)
5. **Release Date**: Check release dates to ensure 3+ are recent

**Documentation Required**:
- System name and platform
- Release date
- Difficulty rating
- Operating System
- Key services/technologies
- Why it complements other selections

**Optional Custom Setup** (1 out of 4):
If creating your own network:
- Must be more complex than basic lab setup
- Multiple VMs, firewall, IDS/IPS
- Enable at least 2 attacks exploiting recent vulnerabilities
- Document setup complexity and learning outcomes

### Step 1.3: Create Network Diagrams

For each selected system, create a diagram showing:
- Attacking machine (Kali Linux)
- Target system/network
- IP addresses
- Operating systems
- Key services
- Network topology

**Tools**: Draw.io, Visio, or similar

## Phase 2: Environment Setup (Week 2)

### Step 2.1: Set Up Penetration Testing Environment

**Required**:
- Kali Linux VM (latest version)
- VirtualBox/VMware
- Sufficient resources (4GB+ RAM, 50GB+ disk)
- VPN access (for HackTheBox, TryHackMe)

**Tools to Install**:
- Nmap
- Metasploit Framework
- Burp Suite
- Wireshark
- Nikto
- SQLMap
- Hydra
- John the Ripper
- Gobuster/Dirbuster
- OpenVAS or Nessus (if available)
- Custom scripts as needed

### Step 2.2: Set Up Documentation Structure

Create folders for each system:
- `DOCUMENTATION/system1/` through `system4/`
- Subfolders: reconnaissance/, scanning/, exploitation/, post-exploitation/, screenshots/

### Step 2.3: Set Up Note-Taking System

**Tools**:
- CherryTree (hierarchical notes)
- Obsidian (markdown notes)
- OneNote
- Simple text files

**What to Document**:
- All commands executed
- Tool outputs
- Screenshots at each step
- IP addresses and ports
- Credentials discovered
- Vulnerabilities found
- Exploitation steps
- Post-exploitation activities
- Time taken for each phase

## Phase 3: Penetration Testing Execution (Week 3-5)

### Step 3.1: System 1 Penetration Test

Follow PTES (Penetration Testing Execution Standard) methodology:

#### 3.1.1 Pre-engagement Interactions
- Understand scope
- Rules of engagement
- Communication channels

#### 3.1.2 Intelligence Gathering
- Passive reconnaissance
- OSINT (Open Source Intelligence)
- DNS enumeration
- Subdomain discovery
- Social media research

**Tools**: theHarvester, Shodan, Google Dorks, DNSenum

#### 3.1.3 Threat Modeling
- Identify threat actors
- Attack vectors
- Business impact

#### 3.1.4 Vulnerability Analysis
- Port scanning (Nmap)
- Service enumeration
- Version detection
- Vulnerability scanning (OpenVAS, Nessus, or manual)
- Web application scanning (Nikto, Burp Suite)

**Tools**: Nmap, OpenVAS, Nessus, Nikto, Burp Suite, Gobuster

#### 3.1.5 Exploitation
- Exploit identified vulnerabilities
- Gain initial access
- Document proof (screenshots, flags)

**Tools**: Metasploit, custom exploits, manual exploitation

#### 3.1.6 Post-Exploitation
- Privilege escalation
- Persistence mechanisms
- Lateral movement
- Data exfiltration
- Cover tracks

**Tools**: Meterpreter, Mimikatz, BloodHound, etc.

#### 3.1.7 Reporting
- Document all steps
- Screenshots
- Commands and outputs
- Create appendix entry

**Repeat Steps 3.1.1-3.1.7 for Systems 2, 3, and 4**

### Step 3.2: Cross-System Analysis

After completing all 4 systems:
- Compare methodologies used
- Identify complementary techniques
- Note differences in approaches
- Document learning outcomes

## Phase 4: Report Writing (Week 6-7)

### Step 4.1: Executive Summary

**Content**:
- Brief scope and objectives (2-3 paragraphs)
- Summary table of systems tested:
  - System name
  - Platform
  - Release date
  - Difficulty rating
  - OS
  - Key findings
- Critical analysis of exploitation difficulty
- Summary of key findings (top 5-10 vulnerabilities)
- High-level recommendations

**Length**: 2-3 pages

### Step 4.2: Selection of Networks/Systems

**Content**:
- **Platform Research Section**:
  - List all platforms researched
  - Comparison table (Pros/Cons, suitability, pricing)
  - Critical analysis of each
  - Justification for platforms chosen

- **System Selection Section**:
  - List selected systems with details
  - Justification for each selection
  - How they complement each other:
    - OS diversity
    - Service diversity
    - Vulnerability type diversity
    - Learning outcomes
  - If custom setup: complexity, setup process, attacks enabled

- **Network Diagrams**:
  - One diagram per system
  - Show attacking machine and target
  - Include IPs, OS, key services
  - Professional formatting

**Length**: 3-4 pages

### Step 4.3: Methodology

**Content**:
- **PTES Framework Overview**:
  - Pre-engagement
  - Intelligence Gathering
  - Threat Modeling
  - Vulnerability Analysis
  - Exploitation
  - Post-Exploitation
  - Reporting

- **Detailed Methodology Steps**:
  - For each phase, describe:
    - Methods used
    - Techniques applied
    - Justification with references
    - How methods complement across systems

- **Risk Rating Methodology**:
  - CVSS (Common Vulnerability Scoring System) explanation
  - Risk calculation formula
  - Severity levels (Critical, High, Medium, Low)
  - Justification for chosen methodology

**References Required**: PTES documentation, NIST guidelines, CVSS documentation

**Length**: 3-4 pages

### Step 4.4: Tools

**Content**:
- **Tool Matrix Table**:
  - Tool name
  - Version
  - Brief description
  - Which systems it was used on
  - Purpose (reconnaissance, scanning, exploitation, etc.)

- **Tool Justifications**:
  - For key tools, explain:
    - Why chosen over alternatives
    - How tools complement each other
    - Unique features utilized
    - Examples: Why OpenVAS vs Nessus, Why Burp Suite vs OWASP ZAP

**Length**: 2-3 pages

### Step 4.5: Findings

**Structure for Each Finding**:
1. **Finding ID**: F-001, F-002, etc.
2. **Title**: Brief descriptive title
3. **Affected System**: Which system(s)
4. **Severity**: Critical/High/Medium/Low (with CVSS score)
5. **Description**: Detailed explanation
6. **Risk Details**: 
   - Threat
   - Vulnerability
   - Impact
   - Likelihood
   - Supporting references
7. **Impact**: Business/technical impact if exploited
8. **Recommendation**: 
   - Remediation steps
   - Alternative solutions
   - Supporting references

**Organization**:
- Group by system or by severity
- Use tables for summary
- Include graphs/charts for visualization

**Length**: 8-10 pages

### Step 4.6: Conclusions

**Content**:
- Overall summary of findings
- Key themes across all systems
- Limitations of the testing:
  - Scope limitations
  - Time constraints
  - Tool limitations
  - Methodology limitations
- Implications:
  - For organizations
  - For security practices
  - For future testing
- Lessons learned

**Length**: 2-3 pages

### Step 4.7: Reflection and Individual Contribution

**Content**:
- **Personal Reflection**:
  - How CA improved pentesting knowledge/skills
  - Specific techniques learned
  - Challenges faced and overcome

- **Group Work Reflection**:
  - How working as a group maximized learning
  - Knowledge sharing experiences
  - Collaboration benefits

- **Future Improvements**:
  - What would you do differently?
  - What additional systems/techniques would you explore?
  - How would you improve methodology?

- **Individual Contributions**:
  - For each team member:
    - Practical tasks completed
    - Report sections written
    - Presentation contributions
    - Specific achievements

**Length**: 2-3 pages

### Step 4.8: References

**Requirements**:
- IEEE citation style
- Alphabetical by author
- All in-text citations must have corresponding reference
- Include:
  - Research papers
  - Industry reports
  - Tool documentation
  - Platform documentation
  - Walkthroughs/tutorials (properly cited)
  - Standards (PTES, NIST, CVSS)

**Tools**: Zotero, Mendeley, or manual management

**Length**: 2-3 pages

### Step 4.9: Appendices

**Structure**:
- Appendix A: System 1 Penetration Test Walkthrough
- Appendix B: System 2 Penetration Test Walkthrough
- Appendix C: System 3 Penetration Test Walkthrough
- Appendix D: System 4 Penetration Test Walkthrough

**Each Appendix Should Include**:
- Step-by-step narrative
- All commands executed
- Tool outputs (screenshots)
- Requests and responses
- Detailed descriptions
- Enough detail for reproduction

**Length**: As needed (not counted in 25 pages)

## Phase 5: Presentation (Week 8)

### Step 5.1: Create Presentation Slides

**Structure** (10-15 slides):
1. Title slide (Group members, date)
2. Agenda/Overview
3. Executive Summary
4. Platform Selection (1-2 slides)
5. Systems Overview (1 slide with table)
6. Methodology Overview (1 slide)
7. Key Tools (1 slide)
8. Top Findings (2-3 slides)
9. Conclusions (1 slide)
10. Reflection (1 slide)
11. Q&A

**Design Tips**:
- Professional design
- Consistent formatting
- Clear visuals (diagrams, charts)
- Minimal text (bullet points)
- High-quality screenshots
- Practice timing (10-12 minutes)

### Step 5.2: Practice Presentation

- Time each section
- Prepare for questions
- Assign speaking roles
- Rehearse transitions

## Phase 6: Finalization (Week 8)

### Step 6.1: Review and Edit Report

- Peer review by all team members
- Check for:
  - Grammar and spelling
  - Consistency
  - Completeness
  - IEEE citation format
  - Figure/table captions
  - Page numbering
  - Table of contents accuracy

### Step 6.2: Complete Forms

- **AI Acknowledgement Form**: Declare any AI tool usage (ChatGPT, Grammarly, Copilot, etc.)
- **Peer Evaluation Forms**: Each student rates all team members' contributions

### Step 6.3: Final Submission

- Convert to PDF
- Check file size
- Verify all sections included
- Submit before deadline

## Quality Checklist

Before submission, verify:

- [ ] All 4 systems tested and documented
- [ ] At least 3 systems released in past 3 months
- [ ] Systems complement each other
- [ ] Complete penetration test for each system
- [ ] Report is ~25 pages (main content)
- [ ] All sections included
- [ ] IEEE references formatted correctly
- [ ] All figures/tables have captions
- [ ] Appendices detailed enough for reproduction
- [ ] Presentation ready (10-15 slides)
- [ ] Forms completed
- [ ] No plagiarism (check Turnitin)
- [ ] Professional formatting throughout

## Common Pitfalls to Avoid

1. **Using Lab Systems**: Don't use Metasploitable, DVWA, or systems from lab exercises
2. **Insufficient Documentation**: Document everything during testing, not after
3. **Poor System Selection**: Ensure systems are diverse and complement each other
4. **Weak Justifications**: Always explain why you chose platforms/systems/tools
5. **Missing References**: Cite all sources, including walkthroughs
6. **Incomplete Appendices**: Appendices must enable reproduction
7. **Poor Formatting**: Professional appearance matters
8. **Late Submission**: Plan buffer time for unexpected issues

## Resources

- **PTES**: http://www.pentest-standard.org/
- **CVSS**: https://www.first.org/cvss/
- **NIST Guidelines**: https://csrc.nist.gov/
- **IEEE Citation Guide**: https://libguides.ncirl.ie/referencingandavoidingplagiarism
- **Zotero Tutorial**: https://www.youtube.com/watch?v=ExmY4b3LvAA

## Next Steps

1. Start with platform research
2. Select your 4 systems
3. Set up your environment
4. Begin penetration testing
5. Document everything as you go
6. Write report sections progressively
7. Leave time for review and editing

Good luck with your assignment!

