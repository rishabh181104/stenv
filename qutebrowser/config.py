# Reload with :config-source or restart qutebrowser after editing
c = c
config = config

# Load settings configured via the GUI (autoconfig.yml)
# Set to False if you want to ignore GUI settings and use only this file
import subprocess
def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], capture_output=True, check=True, text=True)
    lines = x.stdout.split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

config.load_autoconfig(True)

# === Theme Settings ===
# Carbonfox-inspired dark theme
c.colors.webpage.bg = '#1a1a1a'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# Tab colors
c.colors.tabs.bar.bg = '#1a1a1a'
c.colors.tabs.even.bg = '#1a1a1a'
c.colors.tabs.odd.bg = '#1a1a1a'
c.colors.tabs.selected.even.bg = '#2a2a2a'
c.colors.tabs.selected.odd.bg = '#2a2a2a'
c.colors.tabs.pinned.even.bg = '#1a1a1a'
c.colors.tabs.pinned.odd.bg = '#1a1a1a'
c.colors.tabs.pinned.selected.even.bg = '#2a2a2a'
c.colors.tabs.pinned.selected.odd.bg = '#2a2a2a'

# Text colors
c.colors.tabs.even.fg = '#808080'
c.colors.tabs.odd.fg = '#808080'
c.colors.tabs.selected.even.fg = '#ffffff'
c.colors.tabs.selected.odd.fg = '#ffffff'

# Status bar colors
c.colors.statusbar.normal.bg = '#1a1a1a'
c.colors.statusbar.normal.fg = '#808080'
c.colors.statusbar.insert.bg = '#1a1a1a'
c.colors.statusbar.insert.fg = '#ffffff'
c.colors.statusbar.command.bg = '#1a1a1a'
c.colors.statusbar.command.fg = '#ffffff'
c.colors.statusbar.url.success.http.fg = '#808080'
c.colors.statusbar.url.success.https.fg = '#808080'
c.colors.statusbar.url.hover.fg = '#ffffff'

# Scrolling
c.scrolling.smooth = True
c.qt.args = ['enable-gpu']

# Completion colors
c.colors.completion.category.bg = '#1a1a1a'
c.colors.completion.category.fg = '#808080'
c.colors.completion.category.border.bottom = '#1a1a1a'
c.colors.completion.category.border.top = '#1a1a1a'
c.colors.completion.even.bg = '#1a1a1a'
c.colors.completion.odd.bg = '#1a1a1a'
c.colors.completion.item.selected.bg = '#2a2a2a'
c.colors.completion.item.selected.fg = '#ffffff'
c.colors.completion.item.selected.border.bottom = '#2a2a2a'
c.colors.completion.item.selected.border.top = '#2a2a2a'

# === General Settings ===
# Set the default page shown when qutebrowser starts
c.url.start_pages = ['https://start.duckduckgo.com']

# Set the default homepage when opening a new window or pressing 'gh'
c.url.default_page = 'https://start.duckduckgo.com'

# Define search engines; 'DEFAULT' is used when typing a query in the address bar
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'g': 'https://www.google.com/search?q={}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'wiki': 'https://en.wikipedia.org/wiki/{}'
}

# Set the editor to use when editing text fields (e.g., :open-editor or Ctrl-E)
c.editor.command = ['xdg-open', '{}']

# Enable auto-saving of sessions (tabs) when quitting
c.auto_save.session = True

# Save interval for session data (in milliseconds; 0 to disable)
c.auto_save.interval = 150

# === Appearance Settings ===
# Position of the tab bar ('top', 'bottom', 'left', 'right')
c.tabs.position = 'top'

# Show tabs even when there's only one tab open
c.tabs.show = 'always'

# Enable dark mode for websites (if supported)
c.colors.webpage.darkmode.enabled = True

# Set the preferred color scheme for websites ('auto', 'light', 'dark')
c.colors.webpage.preferred_color_scheme = 'dark'

# Background color for tabs (even-numbered tabs)
c.colors.tabs.even.bg = '#00000000'

# Background color for tabs (odd-numbered tabs)
c.colors.tabs.odd.bg = '#00000000'

# Background color for the selected tab
c.colors.tabs.selected.even.bg = '#00000000'

# Background color for the selected tab (odd-numbered)
c.colors.tabs.selected.odd.bg = '#00000000'

# === Content Settings ===
# Enable JavaScript by default
c.content.javascript.enabled = True

# Allow websites to show notifications
c.content.notifications.enabled = True

# Block ads and trackers using built-in adblocker
c.content.blocking.enabled = True

# Choose adblock method ('auto', 'adblock-plus', 'hosts')
c.content.blocking.method = 'auto'

# Load images automatically
c.content.images = True

# Enable autoplay for videos
c.content.autoplay = False

# Allow websites to access the clipboard
c.content.javascript.clipboard = 'access'

# === Keybindings ===
# Bind ',v' to open the current URL in MPV (external media player)
config.bind(',v', 'spawn mpv {url}')

# Bind ',p' to run a userscript for password management (e.g., qute-pass)
config.bind(',p', 'spawn --userscript qute-pass')

# Bind 't' to open a new tab
config.bind('t', 'tab-next')


# Close current tab with Alt+w
config.bind('<Alt-w>', 'tab-close')

# Reopen last closed tab with Alt+Shift+t
config.bind('<Alt-Shift-t>', 'undo')

# Switch to the next tab with Alt+Tab
config.bind('<Alt-Tab>', 'tab-next')
config.bind('<Alt-t>', 'open -t', mode='normal')

# Switch to the previous tab with Alt+Shift-Tab
config.bind('<Alt-Shift-Tab>', 'tab-prev')

# Open URL prompt with Alt+o
config.bind('<Alt-o>', 'cmd-set-text -s :open')

# Yank current URL with Alt+y
config.bind('<Alt-y>', 'yank')

# Reload page with Alt+r
config.bind('<Alt-r>', 'reload')

config.bind(';j', 'mode-leave', mode='insert')


# fonts
c.fonts.default_family = []
c.fonts.default_size = '10pt'
c.fonts.web.family.fixed = 'Meslo Nerd Font'
c.fonts.web.family.sans_serif = 'Meslo Nerd Font'
c.fonts.web.family.serif = 'Meslo Nerd Font'
c.fonts.web.family.standard = 'Meslo Nerd Font'


# === Aliases ===
# Create shortcuts for commands (e.g., type ':q' to quit)
c.aliases = {
    'q': 'quit',
    'w': 'session-save',
    'today': 'open https://www.linuxtoday.com/',
    'tube': 'open https://www.youtube.com/',
    'mail': 'open https://mail.google.com/',
    'keep': 'open https://keep.google.com/',
    'iitm': 'open https://ds.study.iitm.ac.in/',
    'type': 'open https://monkeytype.com/',
    'chess': 'open https://www.chess.com/',
    'grok': 'open https://grok.com/',
    'github': 'open https://github.com/',
    'insta': 'open https://www.instagram.com/',
    'anime': 'open https://animekai.to/home/',
    'manhwa': 'open https://manhwaread.com/home/',
}

c.content.blocking.enabled = True
c.content.blocking.method = 'adblock' # uncomment this if you install python-adblock
c.content.blocking.adblock.lists = [
    "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]

# styles, cosmetics
c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
# c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
c.window.transparent = True # apparently not needed
c.tabs.width = '7%'

# === Downloads ===
# Directory for downloads (use absolute path or relative to qutebrowser config dir)
c.downloads.location.directory = '~/Downloads'

# Prompt for download location each time
c.downloads.location.prompt = True

# Remove finished downloads from the download bar after 5 seconds
c.downloads.remove_finished = 5000

# === Privacy ===
# Send a "Do Not Track" header with requests
c.content.headers.do_not_track = True

# Block third-party cookies
c.content.cookies.accept = 'no-3rdparty'

# Clear browsing data (cookies, cache) when qutebrowser closes
c.content.cache.size = 52428800  # 50MB cache size

# === Performance ===
# Number of web pages to keep in memory for faster back/forward navigation
c.session.lazy_restore = False

# Enable hardware acceleration for rendering
c.qt.args = ['enable-accelerated-video-decode']

# === YouTube Ad Skipping ===
# Block YouTube ads by intercepting specific requests
from qutebrowser.api import interceptor
def filter_yt(info: interceptor.Request):
    """Block YouTube ad requests."""
    url = info.request_url
    if (url.host() == 'www.youtube.com' and url.path() == '/get_video_info' and '&adformat=' in url.query()):
        info.block()
interceptor.register(filter_yt)
