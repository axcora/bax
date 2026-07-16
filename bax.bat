@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: BAX - STATIC SITE GENERATOR v1.0
:: Built by Axcora Tech
:: ============================================================

if not exist public mkdir public
if not exist public\tags mkdir public\tags
if not exist public\pages mkdir public\pages
if not exist data mkdir data
if not exist pages mkdir pages

if exist style.css copy style.css public\style.css >nul
if exist images xcopy /E /I /Y images public\images >nul
if exist assets xcopy /E /I /Y assets public\assets >nul

:: ============================================================
:: CONFIG
:: ============================================================
set "SITE_TITLE=MyBlog"
set "SITE_URL=/"
set "SITE_DESCRIPTION="
set "SITE_IMAGE="
set "SITE_FAVICON=https://bax.axcora.com/images/axcoranewlogored.webp"
set "POSTS_PER_PAGE=6"
set "NAV_ITEMS="
set "nav_text="
set "nav_url="

set "SITE_KEYWORDS=static site generator, ssg, batch, bash, jamstack, seo friendly"
set "SITE_AUTHOR=Axcora Tech"
set "SITE_TWITTER_HANDLE=https://bax.axcora.com"
set "SITE_OG_TYPE=website"

:: HERO SECTION (DEFAULT)
set "HERO_TITLE=Build Fast Sites with BAX"
set "HERO_SUBTITLE=Static Site Generator"
set "HERO_DESC=Modern static site generator built with Batch. Zero dependencies, cross-platform, and SEO-friendly."
set "HERO_BTN1_TEXT=Download BAX"
set "HERO_BTN1_URL=https://creativitaz.gumroad.com/coffee"
set "HERO_BTN2_TEXT=Documentation"
set "HERO_BTN2_URL=pages/documentation.html"

:: FEATURES SECTION (DEFAULT)
set "FEATURES_TITLE=Why Choose BAX?"
set "FEATURES_SUBTITLE=Simple, fast, and SEO-friendly static site generator"

if exist config.zet (
    for /f "usebackq tokens=1,* delims=:" %%A in ("config.zet") do (
        if "%%A"=="SITE_TITLE" set "SITE_TITLE=%%B"
        if "%%A"=="SITE_URL" set "SITE_URL=%%B"
        if "%%A"=="SITE_DESCRIPTION" set "SITE_DESCRIPTION=%%B"
        if "%%A"=="SITE_IMAGE" set "SITE_IMAGE=%%B"
        if "%%A"=="SITE_FAVICON" set "SITE_FAVICON=%%B"
        if "%%A"=="POSTS_PER_PAGE" set "POSTS_PER_PAGE=%%B"

        if "%%A"=="SITE_KEYWORDS" set "SITE_KEYWORDS=%%B"
        if "%%A"=="SITE_AUTHOR" set "SITE_AUTHOR=%%B"
        if "%%A"=="SITE_TWITTER_HANDLE" set "SITE_TWITTER_HANDLE=%%B"
        if "%%A"=="SITE_OG_TYPE" set "SITE_OG_TYPE=%%B"
        
        :: HERO
        if "%%A"=="HERO_TITLE" set "HERO_TITLE=%%B"
        if "%%A"=="HERO_SUBTITLE" set "HERO_SUBTITLE=%%B"
        if "%%A"=="HERO_DESC" set "HERO_DESC=%%B"
        if "%%A"=="HERO_BTN1_TEXT" set "HERO_BTN1_TEXT=%%B"
        if "%%A"=="HERO_BTN1_URL" set "HERO_BTN1_URL=%%B"
        if "%%A"=="HERO_BTN2_TEXT" set "HERO_BTN2_TEXT=%%B"
        if "%%A"=="HERO_BTN2_URL" set "HERO_BTN2_URL=%%B"
        
        :: FEATURES
        if "%%A"=="FEATURES_TITLE" set "FEATURES_TITLE=%%B"
        if "%%A"=="FEATURES_SUBTITLE" set "FEATURES_SUBTITLE=%%B"
        
        :: NAV
        if "%%A"=="  - text" (
            set "nav_text=%%B"
        )
        if "%%A"=="    url" (
            set "nav_url=%%B"
            set "nav_url=!nav_url: =!"
            set "NAV_ITEMS=!NAV_ITEMS!^<li class=^"nav-item^"^>^<a class=^"nav-link text-dark fw-medium^" href=^"!SITE_URL!!nav_url!^"^>!nav_text!^</a^>^</li^>"
        )
    )
)

set "SITE_URL=!SITE_URL: =!"
if not "!SITE_URL:~-1!"=="/" set "SITE_URL=!SITE_URL!/"

:: ============================================================
:: BUILD NAVBAR
:: ============================================================
set "NAV=^<nav class=^"container navbar rounded-5 p-2 navbar-expand-lg bg-white border-bottom sticky-top^"^>^<div class=^"container^"^>^<a class=^"navbar-brand fw-bold text-primary ms-2^" href=^"!SITE_URL!^"^>!SITE_TITLE!^</a^>^<button class=^"navbar-toggler btn btn-sm rounded-circle^" type=^"button^" data-bs-toggle=^"collapse^" data-bs-target=^"#nav^"^>^<span class=^"navbar-toggler-icon^"^>^</span^>^</button^>^<div class=^"collapse navbar-collapse^" id=^"nav^"^>^<ul class=^"navbar-nav ms-auto p-3^"^>!NAV_ITEMS!^<li class=^"nav-item^"^>^<a class=^"nav-link text-dark fw-medium^" href=^"https://creativitaz.gumroad.com/l/bax^" target=^"_blank^"^>^<i class=^"fas fa-download me-1^"^>^</i^> Download^</a^>^</li^>^<li class=^"nav-item^"^>^<a class=^"nav-link text-dark fw-medium^" href=^"https://github.com/mesinkasir/bax^" target=^"_blank^"^>^<i class=^"fab fa-github me-1^"^>^</i^> Github^</a^>^</li^>^<li class=^"nav-item^"^>^<a class=^"nav-link text-dark fw-medium^" href=^"https://www.fiverr.com/creativitas/design-your-modern-website-using-jekyll^" target=^"_blank^"^>^<i class=^"fas fa-user-tie me-1^"^>^</i^> Hire^</a^>^</li^>^</ul^>^</div^>^</div^>^</nav^>"

:: ============================================================
:: FOOTER
:: ============================================================
set "FOOT=^<footer class=^"container rounded-5 bg-white border-top py-4 mt-2^"^>^<div class=^"container text-center^"^>^<p class=^"mb-0 text-muted^"^>^&copy; 2026 ^<a href=^"index.html^" class=^"text-dark text-decoration-none fw-medium^"^>!SITE_TITLE!^</a^>. by ^<a href=^"https://axcora.com^" class=^"text-dark text-decoration-none fw-medium^"^>Axcora^</a^>.^</p^>^</div^>^</footer^>"

:: ============================================================
:: META TEMPLATE
:: ============================================================
set "META_OPEN=^<meta property=^"og:type^" content=^"website^"^>^<meta property=^"og:title^" content=^"!SITE_TITLE!^"^>^<meta property=^"og:description^" content=^"!SITE_DESCRIPTION!^"^>^<meta property=^"og:image^" content=^"!SITE_IMAGE!^"^>^<meta name=^"twitter:card^" content=^"summary_large_image^"^>^<meta name=^"twitter:title^" content=^"!SITE_TITLE!^"^>^<meta name=^"twitter:description^" content=^"!SITE_DESCRIPTION!^"^>^<meta name=^"twitter:image^" content=^"!SITE_IMAGE!^"^>"

:: ============================================================
:: TOTAL POST + PAGINATION
:: ============================================================
set "total_posts=0"
for %%f in (data\*.zet) do set /a total_posts+=1

set /a total_pages=^(total_posts + POSTS_PER_PAGE - 1^) / POSTS_PER_PAGE
if !total_pages! equ 0 set total_pages=1

:: Generate index.html + page-2.html, page-3.html, dst
for /l %%p in (1,1,!total_pages!) do (
    call :GenerateIndexPage %%p
)

:: ============================================================
:: POSTS
:: ============================================================
for %%f in (data\*.zet) do call :ProcessPost "%%f"

:: ============================================================
:: PAGES
:: ============================================================
for %%f in (pages\*.zet) do call :ProcessPage "%%f"

:: ============================================================
:: TAGS
:: ============================================================
for %%f in (data\*.zet) do (
    for /f "usebackq tokens=1,* delims=:" %%A in ("%%f") do (
        if "%%A"=="TAGS" (
            for %%T in (%%B) do call :ProcessTag "%%T"
        )
    )
)

echo.
echo ==========================================
echo  BUILD COMPLETE!
echo ==========================================
echo  [!total_posts!] posts generated
echo  [!total_pages!] pages created
echo  All tags processed
echo  Pages rendered
echo.
echo  Output: public/
echo  Build time: %time%
echo ==========================================
echo  Ready for production!
echo  Open: public/index.html
echo ==========================================
echo.
echo  BAX v1.0 - Built with Batch by Axcora Tech
echo  www.axcora.com
echo ==========================================
echo.

:: ============================================================
:: GENERATE SEO FILES (SITEMAP + ROBOTS.TXT)
:: ============================================================
call :GenerateSEO

pause
goto :eof

:: ============================================================
:: FUNCTIONS
:: ============================================================

:GenerateIndexPage
set "current_page=%1"
set "output_file=public\index.html"
if not %1 equ 1 set "output_file=public\page-%1.html"

set /a start_post=^(%1 - 1^) * POSTS_PER_PAGE + 1
set /a end_post=%1 * POSTS_PER_PAGE

(
    echo ^<!DOCTYPE html^>
    echo ^<html lang=^"en^"^>
    echo ^<head^>
    echo ^<meta charset=^"UTF-8^"^>
    echo ^<meta name=^"viewport^" content=^"width=device-width, initial-scale=1.0^"^>
    echo ^<meta name=^"google-site-verification^" content=^"fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4^"^>
    echo ^<meta name=^"google-site-verification^" content=^"Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0^"^>
    echo ^<title^>!SITE_TITLE! - Page %1^</title^>
    echo ^<meta name=^"description^" content=^"!SITE_DESCRIPTION!^"^>
    if defined SITE_FAVICON echo ^<link rel=^"icon^" href=^"!SITE_FAVICON!^"^>
    echo ^<link href=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css^" rel=^"stylesheet^"^>
    echo ^<link href=^"style.css^" rel=^"stylesheet^"^>
    echo !META_OPEN!
    echo ^<meta name=^"keywords^" content=^"!SITE_KEYWORDS!^"^>
    echo ^<meta name=^"author^" content=^"!SITE_AUTHOR!^"^>
    echo ^<meta name=^"robots^" content=^"index, follow^"^>
    echo ^<meta name=^"generator^" content=^"BAX v1.0 - Static Site Generator by Axcora Tech^"^>
    echo ^</head^>
    echo ^<body^>
    echo !NAV!
    echo ^<main class=^"container py-5^"^>
	
	
    if %1 equ 1 (
        echo ^<section class=^"hero-section^"^>
        echo ^<div class=^"container^"^>
        echo ^<div class=^"row align-items-center g-5^"^>
        echo ^<div class=^"col-lg-6^"^>
        echo ^<span class=^"section-badge mb-3 d-inline-block^"^>🚀 !HERO_SUBTITLE!^</span^>
        echo ^<h1 class=^"hero-title mb-4^"^>!HERO_TITLE!^</h1^>
        echo ^<p class=^"hero-desc mb-4^"^>!HERO_DESC!^</p^>
        echo ^<div class=^"d-flex flex-wrap gap-3^"^>
        echo ^<a href=^"!HERO_BTN1_URL!^" class=^"btn btn-hero btn-hero-primary^"^>
        echo ^<i class=^"fas fa-download me-2^"^>^</i^>!HERO_BTN1_TEXT!
        echo ^</a^>
        echo ^<a href=^"!HERO_BTN2_URL!^" class=^"btn btn-hero btn-hero-outline^"^>
        echo ^<i class=^"fas fa-book me-2^"^>^</i^>!HERO_BTN2_TEXT!
        echo ^</a^>
        echo ^</div^>
        echo ^</div^>
        echo ^<div class=^"col-lg-6^"^>
        echo ^<div class=^"terminal-window^"^>
        echo ^<div class=^"terminal-dots^"^>
        echo ^<span class=^"terminal-dot red^"^>^</span^>
        echo ^<span class=^"terminal-dot yellow^"^>^</span^>
        echo ^<span class=^"terminal-dot green^"^>^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"prompt^"^>$ ^</span^>
        echo ^<span class=^"cmd^"^>git clone https://github.com/mesinkasir/bax.git^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>Cloning into 'bax'...^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>Resolving deltas: 100%% done^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line mt-2^"^>
        echo ^<span class=^"prompt^"^>$ ^</span^>
        echo ^<span class=^"cmd^"^>cd bax^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"prompt^"^>$ ^</span^>
        echo ^<span class=^"cmd^"^>./bax.sh^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>==========================================^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>  BUILD COMPLETE!^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>  [!total_posts!] posts generated^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>  Ready for production!^</span^>
        echo ^</div^>
        echo ^<div class=^"terminal-line^"^>
        echo ^<span class=^"output^"^>==========================================^</span^>
        echo ^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^</section^>

        echo ^<section class=^"features-section^"^>
        echo ^<div class=^"container p-3 p-md-5^"^>
        echo ^<div class=^"text-center mb-5^"^>
        echo ^<span class=^"section-badge^"^>✨ Features^</span^>
        echo ^<h2 class=^"display-6 fw-bold mt-3^"^>!FEATURES_TITLE!^</h2^>
        echo ^<p class=^"text-muted^"^>!FEATURES_SUBTITLE!^</p^>
        echo ^</div^>
        echo ^<div class=^"row g-4^"^>
        echo ^<div class=^"col-md-3^"^>
        echo ^<div class=^"feature-card text-center^"^>
        echo ^<div class=^"feature-icon^"^>⚡^</div^>
        echo ^<div class=^"feature-title^"^>Zero Dependencies^</div^>
        echo ^<div class=^"feature-desc^"^>No Node.js, no Python, no Ruby. Just pure shell scripts.^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^<div class=^"col-md-3^"^>
        echo ^<div class=^"feature-card text-center^"^>
        echo ^<div class=^"feature-icon^"^>🌐^</div^>
        echo ^<div class=^"feature-title^"^>Cross-Platform^</div^>
        echo ^<div class=^"feature-desc^"^>Works on Windows, Linux, and macOS out of the box.^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^<div class=^"col-md-3^"^>
        echo ^<div class=^"feature-card text-center^"^>
        echo ^<div class=^"feature-icon^"^>🔍^</div^>
        echo ^<div class=^"feature-title^"^>SEO Optimized^</div^>
        echo ^<div class=^"feature-desc^"^>Auto-generates meta tags, Open Graph, and sitemaps.^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^<div class=^"col-md-3^"^>
        echo ^<div class=^"feature-card text-center^"^>
        echo ^<div class=^"feature-icon^"^>🚀^</div^>
        echo ^<div class=^"feature-title^"^>Lightning Fast^</div^>
        echo ^<div class=^"feature-desc^"^>Builds your entire site in milliseconds, not seconds.^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^</div^>
        echo ^</section^>
		
    )
	
	
	
    echo ^<div class=^"text-center mt-5 mb-5^"^>
    echo ^<h1 class=^"display-5 fw-bold mb-2^"^>Latest Posts^</h1^>
    echo ^<div class=^"divider mx-auto^"^>^</div^>
    echo ^</div^>
    echo ^<div class=^"row g-4^"^>
    
    set "post_num=0"
    for %%f in (data\*.zet) do (
        set /a post_num+=1
        if !post_num! geq !start_post! if !post_num! leq !end_post! (
            call :RenderPostCard "%%f"
        )
    )
    
    echo ^</div^>
    
    :: PAGINATION
    if !total_pages! gtr 1 (
        echo ^<nav class=^"mt-5 mb-0^" aria-label=^"Page navigation^"^>
        echo ^<ul class=^"pagination justify-content-center^"^>
        
        set /a prev_page=%1 - 1
        if !prev_page! geq 1 (
            if !prev_page! equ 1 (
                echo ^<li class=^"page-item^"^>^<a class=^"page-link^" href=^"index.html^"^>Prev^</a^>^</li^>
            ) else (
                echo ^<li class=^"page-item^"^>^<a class=^"page-link^" href=^"page-!prev_page!.html^"^>Prev^</a^>^</li^>
            )
        ) else (
            echo ^<li class=^"page-item disabled^"^>^<span class=^"page-link^"^>Prev^</span^>^</li^>
        )
        
        for /l %%i in (1,1,!total_pages!) do (
            if %%i equ %1 (
                echo ^<li class=^"page-item active^"^>^<span class=^"page-link^"^>%%i^</span^>^</li^>
            ) else (
                if %%i equ 1 (
                    echo ^<li class=^"page-item^"^>^<a class=^"page-link^" href=^"index.html^"^>1^</a^>^</li^>
                ) else (
                    echo ^<li class=^"page-item^"^>^<a class=^"page-link^" href=^"page-%%i.html^"^>%%i^</a^>^</li^>
                )
            )
        )
        
        set /a next_page=%1 + 1
        if !next_page! leq !total_pages! (
            echo ^<li class=^"page-item^"^>^<a class=^"page-link^" href=^"page-!next_page!.html^"^>Next^</a^>^</li^>
        ) else (
            echo ^<li class=^"page-item disabled^"^>^<span class=^"page-link^"^>Next^</span^>^</li^>
        )
        
        echo ^</ul^>
        echo ^</nav^>
    ) 
	echo ^<section class=^"donation-section py-5 bg-light^"^>
echo ^<div class=^"container^"^>
echo ^<div class=^"text-center mb-5^"^>
echo ^<span class=^"section-badge^"^>❤️ Support BAX^</span^>
echo ^<h2 class=^"display-6 fw-bold mt-3^"^>Support the Project^</h2^>
echo ^<p class=^"text-muted^"^>Help us keep BAX free and open-source for everyone^</p^>
echo ^</div^>
echo ^<div class=^"row g-4 justify-content-center^"^>
echo ^<div class=^"col-md-4^"^>
echo ^<div class=^"donation-card text-center p-4 bg-white rounded-4 shadow-sm h-100^"^>
echo ^<div class=^"donation-icon mb-3^"^>📌^</div^>
echo ^<h4 class=^"fw-bold^"^>GitHub Sponsors^</h4^>
echo ^<p class=^"text-muted^"^>Support us on GitHub^</p^>
echo ^<a href=^"https://github.com/sponsors/mesinkasir^" class=^"btn btn-dark rounded-pill px-4^" target=^"_blank^"^>
echo ^<i class=^"fab fa-github me-2^"^>^</i^>Sponsor
echo ^</a^>
echo ^</div^>
echo ^</div^>
echo ^<div class=^"col-md-4^"^>
echo ^<div class=^"donation-card text-center p-4 bg-white rounded-4 shadow-sm h-100^"^>
echo ^<div class=^"donation-icon mb-3^"^>💵^</div^>
echo ^<h4 class=^"fw-bold^"^>PayPal^</h4^>
echo ^<p class=^"text-muted^"^>Send one-time donation^</p^>
echo ^<a href=^"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick^&hosted_button_id=JVZVXBC4N9DAN^" class=^"btn btn-primary rounded-pill px-4^" target=^"_blank^"^>
echo ^<i class=^"fab fa-paypal me-2^"^>^</i^>Donate
echo ^</a^>
echo ^</div^>
echo ^</div^>
echo ^<div class=^"col-md-4^"^>
echo ^<div class=^"donation-card text-center p-4 bg-white rounded-4 shadow-sm h-100^"^>
echo ^<div class=^"donation-icon mb-3^"^>☕^</div^>
echo ^<h4 class=^"fw-bold^"^>Buy Me a Coffee^</h4^>
echo ^<p class=^"text-muted^"^>Buy us a coffee^</p^>
echo ^<a href=^"https://creativitaz.gumroad.com/coffee^" class=^"btn btn-warning rounded-pill px-4 text-dark^" target=^"_blank^"^>
echo ^<i class=^"fas fa-mug-hot me-2^"^>^</i^>Buy Coffee
echo ^</a^>
echo ^</div^>
echo ^</div^>
echo ^</div^>
echo ^</div^>
echo ^</section^>

    echo ^</main^>

    echo !FOOT!
    echo ^<link rel=^"stylesheet^" href=^"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css^"^>
    echo ^<script src=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js^"^>^</script^>
    echo ^</body^>
    echo ^</html^>
) > !output_file!
goto :eof

:RenderPostCard
set "title="
set "img="
set "desc="
set "date="
set "fname=%~n1"
for /f "usebackq tokens=1,* delims=:" %%A in (%1) do (
    if "%%A"=="TITLE" set "title=%%B"
    if "%%A"=="IMG" set "img=%%B"
    if "%%A"=="DESC" set "desc=%%B"
    if "%%A"=="DATE" set "date=%%B"
)
if not defined img set "img=https://picsum.photos/seed/%fname%/600/400"
if not defined desc set "desc=Click to read more about this article."

echo ^<div class=^"col-md-4 col-12^"^>
echo ^<article class=^"post-card^"^>
echo ^<a href=^"%fname%.html^" class=^"post-card-link text-underline-none text-dark^"^>
echo ^<div class=^"ratio ratio-21x9^"^"^>
echo ^<img src=^"!img!^" class=^"img-fluid mb-3 rounded-3 shadow-sm^" height=^"100%^" width=^"100%^" alt=^"!title!^" loading=^"lazy^"^>
echo ^</div^>
echo ^<div class=^"col-md-10 mx-auto mt-3^"^>
if defined date echo ^<div class=^"post-date text-sm text-muted^"^>!date!^</div^>
echo ^<h3 class=^"post-title fw-bold text-primary h5^"^>!title!^</h3^>
echo ^<p class=^"post-desc^"^>!desc!^</p^>
echo ^</div^>
echo ^</a^>
echo ^</article^>
echo ^</div^>
goto :eof

:ProcessPost
set "post_title="
set "post_desc="
set "post_image="
set "post_url="

for /f "usebackq tokens=1,* delims=:" %%A in (%1) do (
    if "%%A"=="TITLE" set "post_title=%%B"
    if "%%A"=="DESC" set "post_desc=%%B"
    if "%%A"=="IMG" set "post_image=%%B"
)

if not defined post_title set "post_title=!SITE_TITLE!"
if not defined post_desc set "post_desc=!SITE_DESCRIPTION!"
if not defined post_image set "post_image=!SITE_IMAGE!"

set "post_url=!SITE_URL!%%~n1.html"

(
    echo ^<!DOCTYPE html^>
    echo ^<html lang=^"en^"^>
    echo ^<head^>
    echo ^<meta charset=^"UTF-8^"^>
    echo ^<meta name=^"viewport^" content=^"width=device-width, initial-scale=1.0^"^>
    echo ^<meta name=^"google-site-verification^" content=^"fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4^"^>
    echo ^<meta name=^"google-site-verification^" content=^"Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0^"^>
    echo ^<title^>!post_title!^</title^>
    echo ^<meta name=^"description^" content=^"!post_desc!^"^>
    if defined SITE_FAVICON echo ^<link rel=^"icon^" href=^"!SITE_FAVICON!^"^>
    echo ^<link href=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css^" rel=^"stylesheet^"^>
    echo ^<link href=^"style.css^" rel=^"stylesheet^"^>
    echo ^<meta property=^"og:type^" content=^"article^"^>
    echo ^<meta property=^"og:title^" content=^"!post_title!^"^>
    echo ^<meta property=^"og:description^" content=^"!post_desc!^"^>
    echo ^<meta property=^"og:image^" content=^"!post_image!^"^>
    echo ^<meta name=^"twitter:card^" content=^"summary_large_image^"^>
    echo ^<meta name=^"twitter:title^" content=^"!post_title!^"^>
    echo ^<meta name=^"twitter:description^" content=^"!post_desc!^"^>
    echo ^<meta name=^"twitter:image^" content=^"!post_image!^"^>
    echo ^<meta name=^"keywords^" content=^"!SITE_KEYWORDS!^"^>
    echo ^<meta name=^"author^" content=^"!SITE_AUTHOR!^"^>
    echo ^<meta name=^"robots^" content=^"index, follow^"^>
    echo ^<meta name=^"generator^" content=^"BAX v1.0 - Static Site Generator by Axcora Tech^"^>
    echo ^<script async src=^"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6422989243541464^" crossorigin=^"anonymous^"^>^</script^>
    echo ^</head^>
    echo ^<body^>
    echo !NAV!
    echo ^<main class=^"container py-5^"^>
    echo ^<div class=^"row^"^>
    echo ^<div class=^"col-md-10 mx-auto^"^>
    echo ^<article class=^"post-content^"^>
    
    for /f "usebackq tokens=1,* delims=:" %%A in (%1) do (
    if "%%A"=="TITLE" echo ^<h1 class=^"post-content-title fw-bold text-primary^"^>%%B^</h1^>
    if "%%A"=="DATE" echo ^<div class=^"post-content-date mb-3 text-muted^"^>%%B^</div^>
    if "%%A"=="IMG" echo ^<img src=^"%%B^" class=^"img-fluid rounded-4 mb-4 w-100^" alt=^"^"^>
    
    if "%%A"=="H2" echo ^<h2 class=^"h2 fw-bold mt-4 mb-3^"^>%%B^</h2^>
    if "%%A"=="H3" echo ^<h3 class=^"h3 fw-bold mt-3 mb-2^"^>%%B^</h3^>
    if "%%A"=="H4" echo ^<h4 class=^"h4 fw-bold mt-3 mb-2^"^>%%B^</h4^>
    if "%%A"=="H5" echo ^<h5 class=^"h5 fw-bold mt-2 mb-2^"^>%%B^</h5^>
    if "%%A"=="H6" echo ^<h6 class=^"h6 fw-bold mt-2 mb-2^"^>%%B^</h6^>
    
    if "%%A"=="P" echo ^<p class=^"mb-3^"^>%%B^</p^>
    
    if "%%A"=="TABLE" echo ^<div class=^"table-responsive mb-3^"^>^<table class=^"table table-striped table-hover table-bordered^"^>
    if "%%A"=="THEAD" echo ^<thead class=^"table-light^"^>
    if "%%A"=="TBODY" echo ^<tbody^>
    if "%%A"=="TR" echo ^<tr^>
    if "%%A"=="TH" echo ^<th^>%%B^</th^>
    if "%%A"=="TD" echo ^<td^>%%B^</td^>
    if "%%A"=="/TR" echo ^</tr^>
    if "%%A"=="/THEAD" echo ^</thead^>
    if "%%A"=="/TBODY" echo ^</tbody^>
    if "%%A"=="/TABLE" echo ^</table^>^</div^>
    
    if "%%A"=="UL" echo ^<ul class=^"mb-3^"^>
    if "%%A"=="OL" echo ^<ol class=^"mb-3^"^>
    if "%%A"=="LI" echo ^<li class=^"mb-1^"^>%%B^</li^>
    if "%%A"=="/UL" echo ^</ul^>
    if "%%A"=="/OL" echo ^</ol^>
    
    if "%%A"=="CODE" echo ^<pre class=^"bg-light p-3 rounded-3 mb-3^"^>^<code^>%%B^</code^>^</pre^>
    if "%%A"=="BLOCKQUOTE" echo ^<blockquote class=^"blockquote p-3 bg-light rounded-3 border-start border-4 border-primary mb-3^"^>^<p class=^"mb-0^"^>%%B^</p^>^</blockquote^>
    if "%%A"=="HR" echo ^<hr class=^"my-4^"^>
    
    if "%%A"=="TAGS" (
        echo ^<div class=^"post-tags mt-4 text-sm mb-3^"^>
        for %%T in (%%B) do echo ^<a href=^"tags/%%T.html^" class=^"btn btn-sm btn-outline-dark rounded-pill me-1^"^>#%%T^</a^>
        echo ^</div^>
    )
)
    
    echo ^<a href=^"index.html^" class=^"btn btn-primary rounded-pill mt-3^"^>← Back to posts^</a^>
    echo ^</article^>
    echo ^</div^>
    echo ^</div^>
    echo ^</main^>
    echo !FOOT!
    echo ^<link rel=^"stylesheet^" href=^"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css^"^>
    echo ^<script src=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js^"^>^</script^>
    echo ^</body^>
    echo ^</html^>
) > "public\%~n1.html"
goto :eof

:ProcessPage
set "page_title="
set "page_desc="
set "page_image="
set "page_url="

for /f "usebackq tokens=1,* delims=:" %%A in (%1) do (
    if "%%A"=="TITLE" set "page_title=%%B"
    if "%%A"=="DESC" set "page_desc=%%B"
    if "%%A"=="IMG" set "page_image=%%B"
    if "%%A"=="URL" set "page_url=%%B"
)

if not defined page_title set "page_title=!SITE_TITLE!"
if not defined page_desc set "page_desc=!SITE_DESCRIPTION!"
if not defined page_image set "page_image=!SITE_IMAGE!"
if not defined page_url set "page_url=!SITE_URL!pages/%%~n1.html"

(
    echo ^<!DOCTYPE html^>
    echo ^<html lang=^"en^"^>
    echo ^<head^>
    echo ^<meta charset=^"UTF-8^"^>
    echo ^<meta name=^"viewport^" content=^"width=device-width, initial-scale=1.0^"^>
    echo ^<meta name=^"google-site-verification^" content=^"fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4^"^>
    echo ^<meta name=^"google-site-verification^" content=^"Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0^"^>
    echo ^<title^>!page_title!^</title^>
    echo ^<meta name=^"description^" content=^"!page_desc!^"^>
    if defined SITE_FAVICON echo ^<link rel=^"icon^" href=^"!SITE_FAVICON!^"^>
    echo ^<link href=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css^" rel=^"stylesheet^"^>
    echo ^<link href=^"../style.css^" rel=^"stylesheet^"^>
    echo ^<meta property=^"og:type^" content=^"website^"^>
    echo ^<meta property=^"og:title^" content=^"!page_title!^"^>
    echo ^<meta property=^"og:description^" content=^"!page_desc!^"^>
    echo ^<meta property=^"og:image^" content=^"!page_image!^"^>
    echo ^<meta name=^"twitter:card^" content=^"summary_large_image^"^>
    echo ^<meta name=^"twitter:title^" content=^"!page_title!^"^>
    echo ^<meta name=^"twitter:description^" content=^"!page_desc!^"^>
    echo ^<meta name=^"twitter:image^" content=^"!page_image!^"^>
    echo ^<meta name=^"keywords^" content=^"!SITE_KEYWORDS!^"^>
    echo ^<meta name=^"author^" content=^"!SITE_AUTHOR!^"^>
    echo ^<meta name=^"robots^" content=^"index, follow^"^>
    echo ^<meta name=^"generator^" content=^"BAX v1.0 - Static Site Generator by Axcora Tech^"^>
    echo ^<script async src=^"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6422989243541464^" crossorigin=^"anonymous^"^>^</script^>
    echo ^</head^>
    echo ^<body^>
    echo !NAV!
    echo ^<main class=^"container py-5^"^>
    echo ^<div class=^"row^"^>
    echo ^<div class=^"col-lg-10 p-3 mx-auto^"^>
    echo ^<article class=^"post-content p-3 p-md-5 bg-white rounded-5 shadw mb-3 mt-3^"^>
    
    set "page_title="
    set "page_url="
    
    for /f "usebackq tokens=1,* delims=:" %%A in (%1) do (
        if "%%A"=="TITLE" set "page_title=%%B"
        if "%%A"=="URL" set "page_url=%%B"
    )
    
    if defined page_url (
        echo ^<h1 class=^"post-content-title text-primary^"^>^<a href=^"!page_url!^" class=^"text-primary text-decoration-none^"^>!page_title!^</a^>^</h1^>
    ) else (
        echo ^<h1 class=^"post-content-title text-primary^"^>!page_title!^</h1^>
    )
    
    for /f "usebackq tokens=1,* delims=:" %%A in (%1) do (
    if "%%A"=="DESC" echo ^<h2 class=^"lead text-muted mb-4^"^>%%B^</h2^>
    if "%%A"=="IMG" echo ^<img src=^"%%B^" class=^"img-fluid rounded-4 mb-4 w-100^" alt=^"^"^>
    
    if "%%A"=="H2" echo ^<h2 class=^"h2 fw-bold mt-4 mb-3^"^>%%B^</h2^>
    if "%%A"=="H3" echo ^<h3 class=^"h3 fw-bold mt-3 mb-2^"^>%%B^</h3^>
    if "%%A"=="H4" echo ^<h4 class=^"h4 fw-bold mt-3 mb-2^"^>%%B^</h4^>
    if "%%A"=="H5" echo ^<h5 class=^"h5 fw-bold mt-2 mb-2^"^>%%B^</h5^>
    if "%%A"=="H6" echo ^<h6 class=^"h6 fw-bold mt-2 mb-2^"^>%%B^</h6^>
    
    if "%%A"=="P" echo ^<p class=^"mb-3^"^>%%B^</p^>
    
    if "%%A"=="TABLE" echo ^<div class=^"table-responsive mb-3^"^>^<table class=^"table table-striped table-hover table-bordered^"^>
    if "%%A"=="THEAD" echo ^<thead class=^"table-light^"^>
    if "%%A"=="TBODY" echo ^<tbody^>
    if "%%A"=="TR" echo ^<tr^>
    if "%%A"=="TH" echo ^<th^>%%B^</th^>
    if "%%A"=="TD" echo ^<td^>%%B^</td^>
    if "%%A"=="/TR" echo ^</tr^>
    if "%%A"=="/THEAD" echo ^</thead^>
    if "%%A"=="/TBODY" echo ^</tbody^>
    if "%%A"=="/TABLE" echo ^</table^>^</div^>
    
    if "%%A"=="UL" echo ^<ul class=^"mb-3^"^>
    if "%%A"=="OL" echo ^<ol class=^"mb-3^"^>
    if "%%A"=="LI" echo ^<li class=^"mb-1^"^>%%B^</li^>
    if "%%A"=="/UL" echo ^</ul^>
    if "%%A"=="/OL" echo ^</ol^>
    
    if "%%A"=="CODE" echo ^<pre class=^"bg-light p-3 rounded-3 mb-3^"^>^<code^>%%B^</code^>^</pre^>
    if "%%A"=="BLOCKQUOTE" echo ^<blockquote class=^"blockquote p-3 bg-light rounded-3 border-start border-4 border-primary mb-3^"^>^<p class=^"mb-0^"^>%%B^</p^>^</blockquote^>
    if "%%A"=="HR" echo ^<hr class=^"my-4^"^>
)
    
    echo ^<a href=^"../index.html^" class=^"btn btn-primary rounded-pill px-4 mt-3^"^>← Back to Home^</a^>
    echo ^</article^>
    echo ^</div^>
    echo ^</div^>
    echo ^</main^>
    echo !FOOT!
    echo ^<link rel=^"stylesheet^" href=^"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css^"^>
    echo ^<script src=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js^"^>^</script^>
    echo ^</body^>
    echo ^</html^>
) > "public\pages\%~n1.html"
goto :eof

:ProcessTag
(
    echo ^<!DOCTYPE html^>
    echo ^<html lang=^"en^"^>
    echo ^<head^>
    echo ^<meta charset=^"UTF-8^"^>
    echo ^<meta name=^"viewport^" content=^"width=device-width, initial-scale=1.0^"^>
    echo ^<meta name=^"google-site-verification^" content=^"fJTzwsNcz2AtRxQpJZzU7db7TLPdR_lKSAXfyWDtHB4^"^>
    echo ^<meta name=^"google-site-verification^" content=^"Xi3WpckDbMBvm1pdlc5XukNoA9uWDmnExIiOeaTOxq0^"^>
    echo ^<title^>#%~1 - !SITE_TITLE!^</title^>
    echo ^<meta name=^"description^" content=^"Posts tagged with %~1 - !SITE_TITLE!^"^>
    if defined SITE_FAVICON echo ^<link rel=^"icon^" href=^"!SITE_FAVICON!^"^>
    echo ^<link href=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css^" rel=^"stylesheet^"^>
    echo ^<link href=^"../style.css^" rel=^"stylesheet^"^>
    echo ^<meta property=^"og:type^" content=^"website^"^>
    echo ^<meta property=^"og:title^" content=^"#%~1 - !SITE_TITLE!^"^>
    echo ^<meta property=^"og:description^" content=^"Posts tagged with %~1 - !SITE_TITLE!^"^>
    echo ^<meta property=^"og:image^" content=^"!SITE_IMAGE!^"^>
    echo ^<meta name=^"twitter:card^" content=^"summary_large_image^"^>
    echo ^<meta name=^"twitter:title^" content=^"#%~1 - !SITE_TITLE!^"^>
    echo ^<meta name=^"twitter:description^" content=^"Posts tagged with %~1 - !SITE_TITLE!^"^>
    echo ^<meta name=^"twitter:image^" content=^"!SITE_IMAGE!^"^>
    echo ^<meta name=^"keywords^" content=^"!SITE_KEYWORDS!^"^>
    echo ^<meta name=^"author^" content=^"!SITE_AUTHOR!^"^>
    echo ^<meta name=^"robots^" content=^"index, follow^"^>
    echo ^<meta name=^"generator^" content=^"BAX v1.0 - Static Site Generator by Axcora Tech^"^>
    echo ^<script async src=^"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6422989243541464^" crossorigin=^"anonymous^"^>^</script^>
    echo ^</head^>
    echo ^<body^>
    echo !NAV!
    echo ^<main class=^"container py-5^"^>
    echo ^<h2 class=^"text-center fw-light mb-4^"^>Posts tagged ^<span class=^"fw-bold^"^>#%~1^</span^>^</h2^>
    echo ^<div class=^"divider mx-auto mb-5^"^>^</div^>
    echo ^<div class=^"list-group list-group-flush mx-auto^" style=^"max-width: 700px^"^>
    
    for %%d in (data\*.zet) do (
        findstr /i /c:"%~1" "%%d" >nul 2>&1 && (
            set "tag_title="
            for /f "usebackq tokens=1,* delims=:" %%L in ("%%d") do (
                if "%%L"=="TITLE" set "tag_title=%%M"
            )
            if defined tag_title (
                echo ^<a href=^"../%%~nd.html^" class=^"list-group-item list-group-item-action border-0 py-3^"^>!tag_title!^</a^>
            )
        )
    )
    
    echo ^</div^>
    echo ^<div class=^"text-center mt-4^"^>^<a href=^"../index.html^" class=^"rounded-pill btn btn-primary^"^>← All posts^</a^>^</div^>
    echo ^</main^>
    echo !FOOT!
    echo ^<link rel=^"stylesheet^" href=^"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css^"^>
    echo ^<script src=^"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js^"^>^</script^>
    echo ^</body^>
    echo ^</html^>
) > "public\tags\%~1.html"
goto :eof

:: ============================================================
:: GENERATE SITEMAP & ROBOTS.TXT (FIXED DATE - FINAL)
:: ============================================================
:GenerateSEO

:: Get date components
for /f "tokens=1-3 delims=/- " %%a in ('echo %date%') do (
    set "dd=%%a"
    set "mm=%%b"
    set "yyyy=%%c"
)

:: Convert month name to number (JANUARY=01, FEBRUARY=02, etc)
set "mm=!mm:January=01!"
set "mm=!mm:February=02!"
set "mm=!mm:March=03!"
set "mm=!mm:April=04!"
set "mm=!mm:May=05!"
set "mm=!mm:June=06!"
set "mm=!mm:July=07!"
set "mm=!mm:August=08!"
set "mm=!mm:September=09!"
set "mm=!mm:October=10!"
set "mm=!mm:November=11!"
set "mm=!mm:December=12!"

:: Convert short month names
set "mm=!mm:Jan=01!"
set "mm=!mm:Feb=02!"
set "mm=!mm:Mar=03!"
set "mm=!mm:Apr=04!"
set "mm=!mm:May=05!"
set "mm=!mm:Jun=06!"
set "mm=!mm:Jul=07!"
set "mm=!mm:Aug=08!"
set "mm=!mm:Sep=09!"
set "mm=!mm:Oct=10!"
set "mm=!mm:Nov=11!"
set "mm=!mm:Dec=12!"

:: Pad with leading zeros
if "!mm:~0,1!"==" " set "mm=0!mm:~1!"
if "!dd:~0,1!"==" " set "dd=0!dd:~1!"

:: Get time
for /f "tokens=1-3 delims=:. " %%a in ('echo %time%') do (
    set "hh=%%a"
    set "min=%%b"
    set "sec=%%c"
)

if "!hh:~0,1!"==" " set "hh=0!hh:~1!"
if "!hh:~0,1!"=="" set "hh=00"
if "!min!"=="" set "min=00"
if "!sec!"=="" set "sec=00"

:: Build ISO date
set "ISO_DATE=!yyyy!-!mm!-!dd!T!hh!:!min!:!sec!"

set "sitemap=public\sitemap.xml"

(
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"^>
    
    :: Homepage
    echo ^<url^>
    echo ^<loc^>!SITE_URL!^</loc^>
    echo ^<lastmod^>!ISO_DATE!^</lastmod^>
    echo ^<changefreq^>daily^</changefreq^>
    echo ^<priority^>1.0^</priority^>
    echo ^</url^>
    
    :: Index Pages (pagination)
    for /l %%p in (2,1,!total_pages!) do (
        echo ^<url^>
        if %%p equ 1 (
            echo ^<loc^>!SITE_URL!index.html^</loc^>
        ) else (
            echo ^<loc^>!SITE_URL!page-%%p.html^</loc^>
        )
        echo ^<lastmod^>!ISO_DATE!^</lastmod^>
        echo ^<changefreq^>weekly^</changefreq^>
        echo ^<priority^>0.9^</priority^>
        echo ^</url^>
    )
    
    :: Posts
    for %%f in (data\*.zet) do (
        set "fname=%%~nf"
        echo ^<url^>
        echo ^<loc^>!SITE_URL!!fname!.html^</loc^>
        echo ^<lastmod^>!ISO_DATE!^</lastmod^>
        echo ^<changefreq^>monthly^</changefreq^>
        echo ^<priority^>0.8^</priority^>
        echo ^</url^>
    )
    
    :: Pages
    for %%f in (pages\*.zet) do (
        set "fname=%%~nf"
        echo ^<url^>
        echo ^<loc^>!SITE_URL!pages/%%~nf.html^</loc^>
        echo ^<lastmod^>!ISO_DATE!^</lastmod^>
        echo ^<changefreq^>monthly^</changefreq^>
        echo ^<priority^>0.7^</priority^>
        echo ^</url^>
    )
    
    :: Tags
    for %%f in (public\tags\*.html) do (
        set "fname=%%~nf"
        echo ^<url^>
        echo ^<loc^>!SITE_URL!tags/%%~nxf^</loc^>
        echo ^<lastmod^>!ISO_DATE!^</lastmod^>
        echo ^<changefreq^>monthly^</changefreq^>
        echo ^<priority^>0.6^</priority^>
        echo ^</url^>
    )
    
    echo ^</urlset^>
) > !sitemap!

:: Generate robots.txt
(
    echo User-agent: *
    echo Allow: /
    echo Disallow: /pages/
    echo Disallow: /tags/
    echo Sitemap: !SITE_URL!sitemap.xml
) > public\robots.txt

echo.
echo ==========================================
echo  SEO FILES GENERATED!
echo ==========================================
echo  public/sitemap.xml
echo  public/robots.txt
echo  Lastmod: !ISO_DATE!
echo ==========================================

goto :eof