```markdown
# 🔥 BAX - Static Site Generator

> **B**atch & **A**xcora **X** - Static Site Generator v1.0

<div align="center">

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/mesinkasir/bax)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)](https://github.com/mesinkasir/bax)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Made with](https://img.shields.io/badge/Made%20with-Batch%20%26%20Bash-orange.svg)](https://github.com/mesinkasir/bax)

**Modern, lightweight, and SEO-friendly static site generator** built with pure Batch and Bash scripts. No dependencies, no bloat - just pure static site magic!

[Features](#-features) • [Quick Start](#-quick-start) • [Configuration](#-configuration) • [Documentation](#-documentation) • [Demo](#-demo)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Content Creation](#-content-creation)
  - [Creating Posts](#-creating-posts)
  - [Creating Pages](#-creating-pages)
  - [Navigation](#-navigation)
- [SEO Features](#-seo-features)
- [Directory Structure](#-directory-structure)
- [CSS Customization](#-css-customization)
- [Commands](#-commands)
- [Deployment](#-deployment)
- [Contributing](#-contributing)
- [License](#-license)
- [Support & Donation](#-support--donation)

---

## ✨ Features

- ⚡ **Lightning Fast** - Pure Batch/Bash, no dependencies
- 🎨 **Modern Design** - Bootstrap 5 with custom elegant CSS
- 📱 **Fully Responsive** - Looks great on all devices
- 🔍 **SEO Optimized** - Meta tags, Open Graph, Twitter Cards
- 📝 **Markdown-like** - Simple `.zet` file format
- 🏷️ **Tag Support** - Auto-generate tag pages
- 📄 **Pagination** - Built-in post pagination
- 🗺️ **Sitemap Ready** - Clean URL structure
- 🌐 **Cross-platform** - Windows (`.bat`) & Linux/Mac (`.sh`)
- 🎯 **User-friendly** - Simple configuration file
- 🚀 **Production Ready** - Deploy anywhere

---

## 🚀 Quick Start

### Windows
```cmd
bax.bat
```

### Linux / macOS
```bash
chmod +x bax.sh
./bax.sh
```

---

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/mesinkasir/bax.git
cd bax
```

### 2. Project structure

```
bax/
├── bax.bat            # Windows build script
├── bax.sh             # Linux/Mac build script
├── config.zet         # Site configuration
├── style.css          # Custom styles
├── data/              # Blog posts
│   └── *.zet
├── pages/             # Static pages
│   └── *.zet
└── public/            # Generated output (auto-created)
    ├── index.html
    ├── pages/
    ├── tags/
    └── *.html
```

---

## ⚙️ Configuration

Create `config.zet` in your project root:

```yaml
SITE_TITLE:Axcora Zetta Core
SITE_URL:https://axcora.my.id
SITE_DESCRIPTION:Modern static site generator built with Batch
SITE_IMAGE:https://axcora.com/default-og.jpg
SITE_FAVICON:/favicon.ico
POSTS_PER_PAGE:6

NAV:
  - text: Home
    url: /
  - text: About
    url: /about
  - text: Portfolio
    url: /portfolio
  - text: Contact
    url: /contact
```

### Configuration Options

| Option | Description | Required |
|--------|-------------|----------|
| `SITE_TITLE` | Site title (used in navbar & SEO) | ✅ |
| `SITE_URL` | Site URL (with or without trailing slash) | ✅ |
| `SITE_DESCRIPTION` | Site description for SEO | ❌ |
| `SITE_IMAGE` | Default OG image for social sharing | ❌ |
| `SITE_FAVICON` | Path to favicon | ❌ |
| `POSTS_PER_PAGE` | Number of posts per page | ❌ (default: 6) |
| `NAV` | Navigation menu items | ❌ |

---

## 📝 Content Creation

### 📄 Creating Posts

Create `.zet` files in `data/` folder:

**File: `data/my-first-post.zet`**
```yaml
TITLE:My First Blog Post
DATE:15 July 2026
IMG:https://picsum.photos/seed/hello/600/400
DESC:This is an amazing first post about something interesting
TAGS:technology programming tutorial

P:Welcome to my first blog post! Today we're going to learn about...

P:This is another paragraph with more content.

P:You can add as many paragraphs as you want!
```

Complete Content example

```
TITLE:Rich Content Example
DATE:15 July 2026
IMG:https://picsum.photos/seed/rich/1200/600
DESC:This post shows all rich content features

H2:Heading 2 - Section Title
P:This is a paragraph after heading 2.

H3:Heading 3 - Sub Section
P:Another paragraph with some content.

TABLE:
THEAD:
TR:
TH:No
TH:Name
TH:Email
/TR:
/THEAD:
TBODY:
TR:
TD:1
TD:John Doe
TD:john@example.com
/TR:
TR:
TD:2
TD:Jane Smith
TD:jane@example.com
/TR:
/TBODY:
/TABLE:

H4:Heading 4 - Smaller Section
P:This is a paragraph.

BLOCKQUOTE:This is a blockquote with important information.

UL:
LI:Item one
LI:Item two
LI:Item three
/UL:

CODE:console.log("Hello World!");

TAGS:technology programming tutorial
```


**Post Fields:**
| Field | Description | Required |
|-------|-------------|----------|
| `TITLE` | Post title | ✅ |
| `DATE` | Publication date | ❌ |
| `IMG` | Featured image URL | ❌ |
| `DESC` | Post description/excerpt | ❌ |
| `TAGS` | Space-separated tags | ❌ |
| `P` | Paragraph content | ❌ |

### 📄 Creating Pages

Create `.zet` files in `pages/` folder:

**File: `pages/about.zet`**
```yaml
TITLE:About Us
DESC:Learn more about our team
IMG:https://picsum.photos/seed/about/1200/400

P:We are a team of passionate developers...

P:Our mission is to make the web better.
```

**Page Fields:**
| Field | Description | Required |
|-------|-------------|----------|
| `TITLE` | Page title | ✅ |
| `DESC` | Page description | ❌ |
| `IMG` | Page image | ❌ |
| `URL` | Custom page URL | ❌ |
| `P` | Paragraph content | ❌ |

### 🧭 Navigation

Add navigation items in `config.zet`:

```yaml
NAV:
  - text: Home
    url: /
  - text: Blog
    url: /blog
  - text: About
    url: /about
  - text: Contact
    url: /contact
```

---

## 🔍 SEO Features

BAX automatically generates SEO-friendly meta tags:

### Auto-generated Meta Tags

```html
<!-- Basic Meta -->
<title>Page Title - Site Title</title>
<meta name="description" content="Page description">

<!-- Open Graph (Facebook, LinkedIn) -->
<meta property="og:type" content="website|article">
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Page description">
<meta property="og:image" content="https://axcora.com/image.jpg">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Page Title">
<meta name="twitter:description" content="Page description">
<meta name="twitter:image" content="https://axcora.com/image.jpg">

<!-- Generator -->
<meta name="generator" content="BAX v1.0 - Static Site Generator by Axcora Tech">

<!-- Favicon -->
<link rel="icon" href="/favicon.ico">
```

### Priority System

BAX uses a priority system for SEO metadata:

1. **Post/Page specific** (highest priority)
2. **Site-wide config** (fallback)
3. **Default values** (last resort)

---

## 📁 Directory Structure

After build, your `public/` folder will contain:

```
public/
├── index.html              # Homepage
├── page-2.html             # Page 2
├── page-3.html             # Page 3
├── style.css               # Compiled CSS
├── sitemap.xml             # Sitemap
├── robots.txt              # Robots file
├── pages/                  # Static pages
│   ├── about.html
│   ├── portfolio.html
│   └── contact.html
├── tags/                   # Tag pages
│   ├── technology.html
│   ├── programming.html
│   └── tutorial.html
├── my-first-post.html      # Post 1
├── another-post.html       # Post 2
└── ...
```

---

## 🎨 CSS Customization

### Built-in Modern Design

BAX comes with a beautiful, modern CSS design featuring:

- 🎯 **Clean typography** with Inter font
- 🌈 **Gradient accents** (primary blue to purple)
- 💨 **Smooth animations** and transitions
- 📱 **Fully responsive** layout
- ✨ **Glass-morphism** navbar
- 🖼️ **Image hover effects**
- 🏷️ **Styled tags** and buttons

### Customize Style

Edit `style.css` in your project root:

```css
/* Change primary color */
.btn-primary {
    background: linear-gradient(135deg, #your-color, #your-color2) !important;
}

/* Change font */
body {
    font-family: 'Your Font', sans-serif;
}

/* Customize card design */
.post-card {
    border-radius: 20px;
    /* your styles */
}
```

---

## 🛠️ Commands

### Windows
```cmd
bax.bat
```

### Linux/macOS
```bash
chmod +x bax.sh
./bax.sh
```

### Clean Build
```bash
# Windows
rmdir /s /q public
bax.bat

# Linux/macOS
rm -rf public
./bax.sh
```

---

## 🚀 Deployment

### GitHub Pages

1. Rename `deploy.yml.example` to `deploy.yml`:
```bash
mv .github/workflows/deploy.yml.example .github/workflows/deploy.yml
```

2. Push to GitHub:
```bash
git add .
git commit -m "Deploy to GitHub Pages"
git push origin main
```

3. Enable GitHub Pages in repository Settings → Pages → Source: GitHub Actions

### Netlify
```bash
# Set build command
./bax.sh

# Set publish directory
public/
```

### Vercel
```bash
# Set build command
./bax.sh

# Set output directory
public/
```

### Cloudflare Pages
```bash
# Set build command
./bax.sh

# Set build output
public/
```

---

## 🤝 Contributing

We welcome contributions! Here's how:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines

- Keep it simple and clean
- Maintain cross-platform compatibility
- Update documentation
- Test on both Windows and Linux

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Support & Donation

### 💬 Community
- [Website](https://bax.axcora.com)

### ⭐ Support Us
If you find BAX helpful, consider supporting us:

#### GitHub Sponsors
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-181717.svg)](https://github.com/sponsors/mesinkasir)

#### PayPal
[![PayPal](https://img.shields.io/badge/Donate-PayPal-00457C.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JVZVXBC4N9DAN)

#### Buy Me a Coffee
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00.svg)](https://creativitaz.gumroad.com/coffee)

Your support helps us maintain and improve BAX! ❤️

---

## 🏆 Acknowledgments

- Built with ❤️ by [Axcora Tech](https://axcora.com)
- Powered by [Bootstrap 5](https://getbootstrap.com)

---

<div align="center">

**Made with ❤️ by Axcora Tech**

[Website](https://axcora.com) • [GitHub](https://github.com/axcora) • [Documentation](https://bax.axcora.com)

</div>

---

**BAX - Because Static Sites Should Be Simple!** 🚀
```
