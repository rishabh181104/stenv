# Reload with :config-source or restart qutebrowser after editing
c = c
config = config

# Load settings configured via the GUI (autoconfig.yml)
# Set to False if you want to ignore GUI settings and use only this file
config.load_autoconfig(True)

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

# Switch to the previous tab with Alt+Shift-Tab
config.bind('<Alt-Shift-Tab>', 'tab-prev')

# Open URL prompt with Alt+o
config.bind('<Alt-o>', 'set-cmd-text -s :open')

# Yank current URL with Alt+y
config.bind('<Alt-y>', 'yank')

# Reload page with Alt+r
config.bind('<Alt-r>', 'reload')

config.bind('jk', 'mode-leave', mode='insert')


# Unbind 'Ctrl-V' to prevent accidental pasting (optional)
# config.unbind('Ctrl-V')

# === Aliases ===
# Create shortcuts for commands (e.g., type ':q' to quit)
c.aliases = {
    'q': 'quit',
    'w': 'session-save',
    'today': 'open https://www.linuxtoday.com/',
    'youtube': 'open https://www.youtube.com/',
    'chess': 'https://www.chess.com/',
}

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

# === User Stylesheets ===
# Apply custom CSS to specific websites or all pages
# Place CSS files in ~/.config/qutebrowser/css/ and reference them here
# c.content.user_stylesheets = ['css/custom.css']

# === Greasemonkey Scripts ===
# Load JavaScript userscripts from ~/.local/share/qutebrowser/greasemonkey/
# Example: c.content.greasemonkey_scripts = ['script.js']
