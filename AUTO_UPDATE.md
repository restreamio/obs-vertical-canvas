# Auto-Update System

The OBS Vertical Canvas plugin includes an automatic update notification system that checks for new releases on GitHub.

## How it works

1. **Version Checking**: The plugin automatically checks for updates from GitHub releases
2. **Visual Notification**: When an update is available, the settings button turns orange
3. **Update Dialog**: In the settings dialog, you'll see:
   - Update notification with version number
   - "Download Update" button

## Update Process

1. Click the orange settings button when an update is available
2. Click the "Download Update" button in the settings dialog
3. The plugin will download the appropriate installer for your platform:
   - **Windows**: `.exe` installer
   - **macOS**: `.pkg` installer  
   - **Linux**: `.deb` package
4. Choose whether to install immediately or later
5. Restart OBS Studio after installation

## Release Process (for developers)

New releases are automatically created when code is pushed to the `master-restream` branch:

1. Code is built and tested
2. If the version in `buildspec.json` doesn't exist as a release, a new GitHub release is created
3. Release includes:
   - Windows installer (`.exe`)
   - macOS installer (`.pkg`)
   - Linux package (`.deb`)
   - Source code archives
   - SHA256 checksums

## Manual Installation

If you prefer to install updates manually:

1. Visit the [Releases page](https://github.com/restreamio/obs-vertical-canvas/releases)
2. Download the appropriate file for your platform
3. Close OBS Studio
4. Run the installer
5. Restart OBS Studio

## Disabling Auto-Updates

Currently, there is no option to disable update checking. The system only notifies you of available updates and does not automatically install them.

## Troubleshooting

- **Orange button but no update shown**: Restart OBS Studio
- **Download fails**: Check your internet connection and try again
- **Installation fails**: Make sure OBS Studio is completely closed before installing
- **Update not detected**: Updates are checked when the plugin loads; restart OBS Studio to check again