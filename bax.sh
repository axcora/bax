#!/bin/bash

# ============================================================
# BAX - STATIC SITE GENERATOR v1.0
# Built by Axcora Tech
# ============================================================

# Create directories
mkdir -p public public/tags public/pages data pages

# Copy assets
[ -f style.css ] && cp style.css public/style.css
[ -d images ] && cp -r images public/
[ -d assets ] && cp -r assets public/
[ -f favicon.ico ] && cp favicon.ico public/
[ -f logo.png ] && cp logo.png public/

# ============================================================
# CONFIG
# ============================================================
SITE_TITLE="MyBlog"
SITE_URL="/"
SITE_DESCRIPTION=""
SITE_IMAGE=""
SITE_FAVICON=""
POSTS_PER_PAGE=6
NAV_ITEMS=""
nav_text=""
nav_url=""

SITE_KEYWORDS="static site generator, ssg, batch, bash, jamstack, seo friendly"
SITE_AUTHOR="Axcora Tech"
SITE_TWITTER_HANDLE="https://bax.axcora.com"
SITE_OG_TYPE="website"

# HERO SECTION (DEFAULT)
HERO_TITLE="Build Fast Sites with BAX"
HERO_SUBTITLE="Static Site Generator"
HERO_DESC="Modern static site generator built with Batch. Zero dependencies, cross-platform, and SEO-friendly."
HERO_BTN1_TEXT="Download BAX"
HERO_BTN1_URL="https://creativitaz.gumroad.com/coffee"
HERO_BTN2_TEXT="Documentation"
HERO_BTN2_URL="pages/documentation.html"

# FEATURES SECTION (DEFAULT)
FEATURES_TITLE="Why Choose BAX?"
FEATURES_SUBTITLE="Simple, fast, and SEO-friendly static site generator"

if [ -f config.zet ]; then
    while IFS=':' read -r key value; do
        key="${key%% }"
        value="${value## }"
        
        case "$key" in
            SITE_TITLE) SITE_TITLE="$value" ;;
            SITE_URL) SITE_URL="$value" ;;
            SITE_DESCRIPTION) SITE_DESCRIPTION="$value" ;;
            SITE_IMAGE) SITE_IMAGE="$value" ;;
            SITE_FAVICON) SITE_FAVICON="$value" ;;
            SITE_KEYWORDS) SITE_KEYWORDS="$value" ;;
            SITE_AUTHOR) SITE_AUTHOR="$value" ;;
            SITE_TWITTER_HANDLE) SITE_TWITTER_HANDLE="$value" ;;
            SITE_OG_TYPE) SITE_OG_TYPE="$value" ;;
            POSTS_PER_PAGE) POSTS_PER_PAGE="$value" ;;
            HERO_TITLE) HERO_TITLE="$value" ;;
            HERO_SUBTITLE) HERO_SUBTITLE="$value" ;;
            HERO_DESC) HERO_DESC="$value" ;;
            HERO_BTN1_TEXT) HERO_BTN1_TEXT="$value" ;;
            HERO_BTN1_URL) HERO_BTN1_URL="$value" ;;
            HERO_BTN2_TEXT) HERO_BTN2_TEXT="$value" ;;
            HERO_BTN2_URL) HERO_BTN2_URL="$value" ;;
            FEATURES_TITLE) FEATURES_TITLE="$value" ;;
            FEATURES_SUBTITLE) FEATURES_SUBTITLE="$value" ;;
            "  - text") nav_text="$value" ;;
            "    url")
                nav_url="${value// /}"
                NAV_ITEMS="${NAV_ITEMS}<li class=\"nav-item\"><a class=\"nav-link text-dark fw-medium\" href=\"${SITE_URL}${nav_url}\">${nav_text}</a></li>"
                ;;
        esac
    done < config.zet
fi

# Clean and format SITE_URL
SITE_URL="${SITE_URL// /}"
[[ "$SITE_URL" != */ ]] && SITE_URL="${SITE_URL}/"

# ============================================================
# BUILD NAVBAR
# ============================================================
NAV="<nav class=\"container navbar rounded-5 p-2 navbar-expand-lg bg-white border-bottom sticky-top\"><div class=\"container\"><a class=\"navbar-brand fw-bold text-primary ms-2\" href=\"${SITE_URL}\">${SITE_TITLE}</a><button class=\"navbar-toggler btn btn-sm rounded-circle\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#nav\"><span class=\"navbar-toggler-icon\"></span></button><div class=\"collapse navbar-collapse\" id=\"nav\"><ul class=\"navbar-nav ms-auto p-3\">${NAV_ITEMS}</ul></div></div></nav>"

# ============================================================
# FOOTER
# ============================================================
FOOT="<footer class=\"container rounded-5 bg-white border-top py-4 mt-2\"><div class=\"container text-center\"><p class=\"mb-0 text-muted\">&copy; 2026 <a href=\"index.html\" class=\"text-dark text-decoration-none fw-medium\">${SITE_TITLE}</a>. Built with BAX by Axcora Tech.</p></div></footer>"

# ============================================================
# META TEMPLATE
# ============================================================
META_OPEN="<meta property=\"og:type\" content=\"website\"><meta property=\"og:title\" content=\"${SITE_TITLE}\"><meta property=\"og:description\" content=\"${SITE_DESCRIPTION}\"><meta property=\"og:image\" content=\"${SITE_IMAGE}\"><meta name=\"twitter:card\" content=\"summary_large_image\"><meta name=\"twitter:title\" content=\"${SITE_TITLE}\"><meta name=\"twitter:description\" content=\"${SITE_DESCRIPTION}\"><meta name=\"twitter:image\" content=\"${SITE_IMAGE}\">"

# ============================================================
# TOTAL POST + PAGINATION
# ============================================================
total_posts=$(ls -1 data/*.zet 2>/dev/null | wc -l)
total_pages=$(( (total_posts + POSTS_PER_PAGE - 1) / POSTS_PER_PAGE ))
[ $total_pages -eq 0 ] && total_pages=1

# ============================================================
# FUNCTIONS
# ============================================================

generate_index() {
    local page=$1
    local output="public/index.html"
    [ $page -ne 1 ] && output="public/page-${page}.html"
    
    local start_post=$(( (page - 1) * POSTS_PER_PAGE + 1 ))
    local end_post=$(( page * POSTS_PER_PAGE ))
    
    cat > "$output" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-site-verification" content="fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4">
    <meta name="google-site-verification" content="Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0">
    <title>${SITE_TITLE} - Page ${page}</title>
    <meta name="description" content="${SITE_DESCRIPTION}">
    ${SITE_FAVICON:+<link rel="icon" href="${SITE_FAVICON}">}
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    ${META_OPEN}
    <meta name="keywords" content="${SITE_KEYWORDS}">
    <meta name="author" content="${SITE_AUTHOR}">
    <meta name="robots" content="index, follow">
    <meta name="generator" content="BAX v1.0 - Static Site Generator by Axcora Tech">
</head>
<body>
    ${NAV}
    <main class="container py-5">
EOF

    if [ $page -eq 1 ]; then
        cat >> "$output" << EOF
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <span class="section-badge mb-3 d-inline-block">🚀 ${HERO_SUBTITLE}</span>
                    <h1 class="hero-title mb-4">${HERO_TITLE}</h1>
                    <p class="hero-desc mb-4">${HERO_DESC}</p>
                    <div class="d-flex flex-wrap gap-3">
                        <a href="${HERO_BTN1_URL}" class="btn btn-hero btn-hero-primary">
                            <i class="fas fa-download me-2"></i>${HERO_BTN1_TEXT}
                        </a>
                        <a href="${HERO_BTN2_URL}" class="btn btn-hero btn-hero-outline">
                            <i class="fas fa-book me-2"></i>${HERO_BTN2_TEXT}
                        </a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="terminal-window">
                        <div class="terminal-dots">
                            <span class="terminal-dot red"></span>
                            <span class="terminal-dot yellow"></span>
                            <span class="terminal-dot green"></span>
                        </div>
                        <div class="terminal-line">
                            <span class="prompt">$ </span>
                            <span class="cmd">git clone https://github.com/mesinkasir/bax.git</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">Cloning into 'bax'...</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">Resolving deltas: 100% done</span>
                        </div>
                        <div class="terminal-line mt-2">
                            <span class="prompt">$ </span>
                            <span class="cmd">cd bax</span>
                        </div>
                        <div class="terminal-line">
                            <span class="prompt">$ </span>
                            <span class="cmd">./bax.sh</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">==========================================</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">  BUILD COMPLETE!</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">  [${total_posts}] posts generated</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">  Ready for production!</span>
                        </div>
                        <div class="terminal-line">
                            <span class="output">==========================================</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="features-section">
        <div class="container p-3 p-md-5">
            <div class="text-center mb-5">
                <span class="section-badge">✨ Features</span>
                <h2 class="display-6 fw-bold mt-3">${FEATURES_TITLE}</h2>
                <p class="text-muted">${FEATURES_SUBTITLE}</p>
            </div>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="feature-card text-center">
                        <div class="feature-icon">⚡</div>
                        <div class="feature-title">Zero Dependencies</div>
                        <div class="feature-desc">No Node.js, no Python, no Ruby. Just pure shell scripts.</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-card text-center">
                        <div class="feature-icon">🌐</div>
                        <div class="feature-title">Cross-Platform</div>
                        <div class="feature-desc">Works on Windows, Linux, and macOS out of the box.</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-card text-center">
                        <div class="feature-icon">🔍</div>
                        <div class="feature-title">SEO Optimized</div>
                        <div class="feature-desc">Auto-generates meta tags, Open Graph, and sitemaps.</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-card text-center">
                        <div class="feature-icon">🚀</div>
                        <div class="feature-title">Lightning Fast</div>
                        <div class="feature-desc">Builds your entire site in milliseconds, not seconds.</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
EOF
    fi

    cat >> "$output" << EOF
    <div class="text-center mt-5 mb-5">
        <h1 class="display-5 fw-bold mb-2">Latest Posts</h1>
        <div class="divider mx-auto"></div>
    </div>
    <div class="row g-4">
EOF

    local count=0
    for f in data/*.zet; do
        count=$((count + 1))
        if [ $count -ge $start_post ] && [ $count -le $end_post ]; then
            render_post_card "$f"
        fi
    done

    cat >> "$output" << EOF
    </div>
EOF

    # Pagination
    if [ $total_pages -gt 1 ]; then
        cat >> "$output" << EOF
    <nav class="mt-5 mb-0" aria-label="Page navigation">
        <ul class="pagination justify-content-center">
EOF
        if [ $page -gt 1 ]; then
            [ $((page - 1)) -eq 1 ] && echo '<li class="page-item"><a class="page-link" href="index.html">Prev</a></li>' >> "$output" || echo "<li class=\"page-item\"><a class=\"page-link\" href=\"page-$((page - 1)).html\">Prev</a></li>" >> "$output"
        else
            echo '<li class="page-item disabled"><span class="page-link">Prev</span></li>' >> "$output"
        fi

        for ((i=1; i<=total_pages; i++)); do
            if [ $i -eq $page ]; then
                echo "<li class=\"page-item active\"><span class=\"page-link\">${i}</span></li>" >> "$output"
            elif [ $i -eq 1 ]; then
                echo "<li class=\"page-item\"><a class=\"page-link\" href=\"index.html\">1</a></li>" >> "$output"
            else
                echo "<li class=\"page-item\"><a class=\"page-link\" href=\"page-${i}.html\">${i}</a></li>" >> "$output"
            fi
        done

        if [ $page -lt $total_pages ]; then
            echo "<li class=\"page-item\"><a class=\"page-link\" href=\"page-$((page + 1)).html\">Next</a></li>" >> "$output"
        else
            echo '<li class="page-item disabled"><span class="page-link">Next</span></li>' >> "$output"
        fi

        cat >> "$output" << EOF
        </ul>
    </nav>
EOF
    fi

    # Donation Section
    cat >> "$output" << EOF
    <section class="donation-section py-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <span class="section-badge">❤️ Support BAX</span>
                <h2 class="display-6 fw-bold mt-3">Support the Project</h2>
                <p class="text-muted">Help us keep BAX free and open-source for everyone</p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-md-4">
                    <div class="donation-card text-center p-4 bg-white rounded-4 shadow-sm h-100">
                        <div class="donation-icon mb-3">📌</div>
                        <h4 class="fw-bold">GitHub Sponsors</h4>
                        <p class="text-muted">Support us on GitHub</p>
                        <a href="https://github.com/sponsors/mesinkasir" class="btn btn-dark rounded-pill px-4" target="_blank">
                            <i class="fab fa-github me-2"></i>Sponsor
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="donation-card text-center p-4 bg-white rounded-4 shadow-sm h-100">
                        <div class="donation-icon mb-3">💵</div>
                        <h4 class="fw-bold">PayPal</h4>
                        <p class="text-muted">Send one-time donation</p>
                        <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JVZVXBC4N9DAN" class="btn btn-primary rounded-pill px-4" target="_blank">
                            <i class="fab fa-paypal me-2"></i>Donate
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="donation-card text-center p-4 bg-white rounded-4 shadow-sm h-100">
                        <div class="donation-icon mb-3">☕</div>
                        <h4 class="fw-bold">Buy Me a Coffee</h4>
                        <p class="text-muted">Buy us a coffee</p>
                        <a href="https://creativitaz.gumroad.com/coffee" class="btn btn-warning rounded-pill px-4 text-dark" target="_blank">
                            <i class="fas fa-mug-hot me-2"></i>Buy Coffee
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
EOF

    cat >> "$output" << EOF
    </main>
    ${FOOT}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF
}

render_post_card() {
    local file="$1"
    local title img desc date
    local fname=$(basename "$file" .zet)
    
    title=$(grep "^TITLE:" "$file" | cut -d':' -f2- | sed 's/^ //')
    img=$(grep "^IMG:" "$file" | cut -d':' -f2- | sed 's/^ //')
    desc=$(grep "^DESC:" "$file" | cut -d':' -f2- | sed 's/^ //')
    date=$(grep "^DATE:" "$file" | cut -d':' -f2- | sed 's/^ //')
    
    [ -z "$img" ] && img="https://picsum.photos/seed/${fname}/600/400"
    [ -z "$desc" ] && desc="Click to read more about this article."
    
    cat << EOF
<div class="col-md-4 col-12">
    <article class="post-card">
        <a href="${fname}.html" class="post-card-link text-underline-none text-dark">
            <div class="ratio ratio-21x9">
                <img src="${img}" class="img-fluid mb-3 rounded-3 shadow-sm" height="100%" width="100%" alt="${title}" loading="lazy">
            </div>
            <div class="col-md-10 mx-auto mt-3">
                ${date:+<div class="post-date text-sm text-muted">${date}</div>}
                <h3 class="post-title fw-bold text-primary h5">${title}</h3>
                <p class="post-desc">${desc}</p>
            </div>
        </a>
    </article>
</div>
EOF
}

process_post() {
    local file="$1"
    local fname=$(basename "$file" .zet)
    
    local post_title="$SITE_TITLE"
    local post_desc="$SITE_DESCRIPTION"
    local post_image="$SITE_IMAGE"
    
    local title=$(grep "^TITLE:" "$file" | cut -d':' -f2- | sed 's/^ //')
    local desc=$(grep "^DESC:" "$file" | cut -d':' -f2- | sed 's/^ //')
    local img=$(grep "^IMG:" "$file" | cut -d':' -f2- | sed 's/^ //')
    
    [ -n "$title" ] && post_title="$title"
    [ -n "$desc" ] && post_desc="$desc"
    [ -n "$img" ] && post_image="$img"
    
    cat > "public/${fname}.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-site-verification" content="fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4">
    <meta name="google-site-verification" content="Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0">
    <title>${post_title}</title>
    <meta name="description" content="${post_desc}">
    ${SITE_FAVICON:+<link rel="icon" href="${SITE_FAVICON}">}
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    <meta property="og:type" content="article">
    <meta property="og:title" content="${post_title}">
    <meta property="og:description" content="${post_desc}">
    <meta property="og:image" content="${post_image}">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="${post_title}">
    <meta name="twitter:description" content="${post_desc}">
    <meta name="twitter:image" content="${post_image}">
    <meta name="keywords" content="${SITE_KEYWORDS}">
    <meta name="author" content="${SITE_AUTHOR}">
    <meta name="robots" content="index, follow">
    <meta name="generator" content="BAX v1.0 - Static Site Generator by Axcora Tech">
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6422989243541464" crossorigin="anonymous"></script>
</head>
<body>
    ${NAV}
    <main class="container py-5">
        <div class="row">
            <div class="col-md-10 mx-auto">
                <article class="post-content">
EOF

    while IFS=':' read -r key value; do
        key="${key%% }"
        value="${value## }"
        
        case "$key" in
            TITLE) echo "<h1 class=\"post-content-title fw-bold text-primary\">${value}</h1>" ;;
            DATE) echo "<div class=\"post-content-date mb-3 text-muted\">${value}</div>" ;;
            IMG) echo "<img src=\"${value}\" class=\"img-fluid rounded-4 mb-4 w-100\" alt=\"\">" ;;
            H2) echo "<h2 class=\"h2 fw-bold mt-4 mb-3\">${value}</h2>" ;;
            H3) echo "<h3 class=\"h3 fw-bold mt-3 mb-2\">${value}</h3>" ;;
            H4) echo "<h4 class=\"h4 fw-bold mt-3 mb-2\">${value}</h4>" ;;
            H5) echo "<h5 class=\"h5 fw-bold mt-2 mb-2\">${value}</h5>" ;;
            H6) echo "<h6 class=\"h6 fw-bold mt-2 mb-2\">${value}</h6>" ;;
            P) echo "<p class=\"mb-3\">${value}</p>" ;;
            UL) echo "<ul class=\"mb-3\">" ;;
            OL) echo "<ol class=\"mb-3\">" ;;
            LI) echo "<li class=\"mb-1\">${value}</li>" ;;
            /UL) echo "</ul>" ;;
            /OL) echo "</ol>" ;;
            CODE) echo "<pre class=\"bg-light p-3 rounded-3 mb-3\"><code>${value}</code></pre>" ;;
            BLOCKQUOTE) echo "<blockquote class=\"blockquote p-3 bg-light rounded-3 border-start border-4 border-primary mb-3\"><p class=\"mb-0\">${value}</p></blockquote>" ;;
            HR) echo "<hr class=\"my-4\">" ;;
            TAGS)
                echo "<div class=\"post-tags mt-4 text-sm mb-3\">"
                for tag in $value; do
                    echo "<a href=\"tags/${tag}.html\" class=\"btn btn-sm btn-outline-dark rounded-pill me-1\">#${tag}</a>"
                done
                echo "</div>"
                ;;
        esac
    done < "$file"

    cat >> "public/${fname}.html" << EOF
                    <a href="index.html" class="btn btn-primary rounded-pill mt-3">← Back to posts</a>
                </article>
            </div>
        </div>
    </main>
    ${FOOT}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF
}

process_page() {
    local file="$1"
    local fname=$(basename "$file" .zet)
    
    local page_title="$SITE_TITLE"
    local page_desc="$SITE_DESCRIPTION"
    local page_image="$SITE_IMAGE"
    local page_url="${SITE_URL}pages/${fname}.html"
    
    local title=$(grep "^TITLE:" "$file" | cut -d':' -f2- | sed 's/^ //')
    local desc=$(grep "^DESC:" "$file" | cut -d':' -f2- | sed 's/^ //')
    local img=$(grep "^IMG:" "$file" | cut -d':' -f2- | sed 's/^ //')
    local url=$(grep "^URL:" "$file" | cut -d':' -f2- | sed 's/^ //')
    
    [ -n "$title" ] && page_title="$title"
    [ -n "$desc" ] && page_desc="$desc"
    [ -n "$img" ] && page_image="$img"
    [ -n "$url" ] && page_url="$url"
    
    cat > "public/pages/${fname}.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-site-verification" content="fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4">
    <meta name="google-site-verification" content="Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0">
    <title>${page_title}</title>
    <meta name="description" content="${page_desc}">
    ${SITE_FAVICON:+<link rel="icon" href="${SITE_FAVICON}">}
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../style.css" rel="stylesheet">
    <meta property="og:type" content="website">
    <meta property="og:title" content="${page_title}">
    <meta property="og:description" content="${page_desc}">
    <meta property="og:image" content="${page_image}">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="${page_title}">
    <meta name="twitter:description" content="${page_desc}">
    <meta name="twitter:image" content="${page_image}">
    <meta name="keywords" content="${SITE_KEYWORDS}">
    <meta name="author" content="${SITE_AUTHOR}">
    <meta name="robots" content="index, follow">
    <meta name="generator" content="BAX v1.0 - Static Site Generator by Axcora Tech">
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6422989243541464" crossorigin="anonymous"></script>
</head>
<body>
    ${NAV}
    <main class="container py-5">
        <div class="row">
            <div class="col-lg-10 p-3 mx-auto">
                <article class="post-content p-3 p-md-5 bg-white rounded-5 shadw mb-3 mt-3">
EOF

    local page_title=""
    local page_url=""
    
    while IFS=':' read -r key value; do
        key="${key%% }"
        value="${value## }"
        
        case "$key" in
            TITLE) page_title="$value" ;;
            URL) page_url="$value" ;;
        esac
    done < "$file"
    
    if [ -n "$page_url" ]; then
        echo "<h1 class=\"post-content-title text-primary\"><a href=\"${page_url}\" class=\"text-primary text-decoration-none\">${page_title}</a></h1>" >> "public/pages/${fname}.html"
    else
        echo "<h1 class=\"post-content-title text-primary\">${page_title}</h1>" >> "public/pages/${fname}.html"
    fi
    
    while IFS=':' read -r key value; do
        key="${key%% }"
        value="${value## }"
        
        case "$key" in
            DESC) echo "<h2 class=\"lead text-muted mb-4\">${value}</h2>" ;;
            IMG) echo "<img src=\"${value}\" class=\"img-fluid rounded-4 mb-4 w-100\" alt=\"\">" ;;
            H2) echo "<h2 class=\"h2 fw-bold mt-4 mb-3\">${value}</h2>" ;;
            H3) echo "<h3 class=\"h3 fw-bold mt-3 mb-2\">${value}</h3>" ;;
            H4) echo "<h4 class=\"h4 fw-bold mt-3 mb-2\">${value}</h4>" ;;
            H5) echo "<h5 class=\"h5 fw-bold mt-2 mb-2\">${value}</h5>" ;;
            H6) echo "<h6 class=\"h6 fw-bold mt-2 mb-2\">${value}</h6>" ;;
            P) echo "<p class=\"mb-3\">${value}</p>" ;;
            UL) echo "<ul class=\"mb-3\">" ;;
            OL) echo "<ol class=\"mb-3\">" ;;
            LI) echo "<li class=\"mb-1\">${value}</li>" ;;
            /UL) echo "</ul>" ;;
            /OL) echo "</ol>" ;;
            CODE) echo "<pre class=\"bg-light p-3 rounded-3 mb-3\"><code>${value}</code></pre>" ;;
            BLOCKQUOTE) echo "<blockquote class=\"blockquote p-3 bg-light rounded-3 border-start border-4 border-primary mb-3\"><p class=\"mb-0\">${value}</p></blockquote>" ;;
            HR) echo "<hr class=\"my-4\">" ;;
        esac
    done < "$file"

    cat >> "public/pages/${fname}.html" << EOF
                    <a href="../index.html" class="btn btn-primary rounded-pill px-4 mt-3">← Back to Home</a>
                </article>
            </div>
        </div>
    </main>
    ${FOOT}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF
}

process_tag() {
    local tag="$1"
    
    cat > "public/tags/${tag}.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-site-verification" content="fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4">
    <meta name="google-site-verification" content="Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0">
    <title>#${tag} - ${SITE_TITLE}</title>
    <meta name="description" content="Posts tagged with ${tag} - ${SITE_TITLE}">
    ${SITE_FAVICON:+<link rel="icon" href="${SITE_FAVICON}">}
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../style.css" rel="stylesheet">
    <meta property="og:type" content="website">
    <meta property="og:title" content="#${tag} - ${SITE_TITLE}">
    <meta property="og:description" content="Posts tagged with ${tag} - ${SITE_TITLE}">
    <meta property="og:image" content="${SITE_IMAGE}">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="#${tag} - ${SITE_TITLE}">
    <meta name="twitter:description" content="Posts tagged with ${tag} - ${SITE_TITLE}">
    <meta name="twitter:image" content="${SITE_IMAGE}">
    <meta name="keywords" content="${SITE_KEYWORDS}">
    <meta name="author" content="${SITE_AUTHOR}">
    <meta name="robots" content="index, follow">
    <meta name="generator" content="BAX v1.0 - Static Site Generator by Axcora Tech">
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6422989243541464" crossorigin="anonymous"></script>
</head>
<body>
    ${NAV}
    <main class="container py-5">
        <h2 class="text-center fw-light mb-4">Posts tagged <span class="fw-bold">#${tag}</span></h2>
        <div class="divider mx-auto mb-5"></div>
        <div class="list-group list-group-flush mx-auto" style="max-width: 700px;">
EOF

    for f in data/*.zet; do
        if grep -q "${tag}" "$f"; then
            local tag_title=$(grep "^TITLE:" "$f" | cut -d':' -f2- | sed 's/^ //')
            local fname=$(basename "$f" .zet)
            if [ -n "$tag_title" ]; then
                echo "<a href=\"../${fname}.html\" class=\"list-group-item list-group-item-action border-0 py-3\">${tag_title}</a>" >> "public/tags/${tag}.html"
            fi
        fi
    done

    cat >> "public/tags/${tag}.html" << EOF
        </div>
        <div class="text-center mt-4"><a href="../index.html" class="rounded-pill btn btn-primary">← All posts</a></div>
    </main>
    ${FOOT}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF
}

generate_seo() {
    local sitemap="public/sitemap.xml"
    
    cat > "$sitemap" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
EOF

    cat >> "$sitemap" << EOF
    <url>
        <loc>${SITE_URL}</loc>
        <lastmod>$(date +%Y-%m-%dT%H:%M:%S)</lastmod>
        <changefreq>daily</changefreq>
        <priority>1.0</priority>
    </url>
EOF

    for ((p=2; p<=total_pages; p++)); do
        cat >> "$sitemap" << EOF
    <url>
        <loc>${SITE_URL}page-${p}.html</loc>
        <lastmod>$(date +%Y-%m-%dT%H:%M:%S)</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.9</priority>
    </url>
EOF
    done

    for f in data/*.zet; do
        fname=$(basename "$f" .zet)
        cat >> "$sitemap" << EOF
    <url>
        <loc>${SITE_URL}${fname}.html</loc>
        <lastmod>$(date +%Y-%m-%dT%H:%M:%S)</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
EOF
    done

    for f in pages/*.zet; do
        fname=$(basename "$f" .zet)
        cat >> "$sitemap" << EOF
    <url>
        <loc>${SITE_URL}pages/${fname}.html</loc>
        <lastmod>$(date +%Y-%m-%dT%H:%M:%S)</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.7</priority>
    </url>
EOF
    done

    for f in public/tags/*.html; do
        [ -f "$f" ] || continue
        fname=$(basename "$f")
        cat >> "$sitemap" << EOF
    <url>
        <loc>${SITE_URL}tags/${fname}</loc>
        <lastmod>$(date +%Y-%m-%dT%H:%M:%S)</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.6</priority>
    </url>
EOF
    done

    echo "</urlset>" >> "$sitemap"

    # Robots.txt
    cat > public/robots.txt << EOF
User-agent: *
Allow: /
Disallow: /pages/
Disallow: /tags/
Sitemap: ${SITE_URL}sitemap.xml
EOF

    echo ""
    echo "=========================================="
    echo "  SEO FILES GENERATED!"
    echo "=========================================="
    echo "  public/sitemap.xml"
    echo "  public/robots.txt"
    echo "=========================================="
}