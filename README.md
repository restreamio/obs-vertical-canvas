# Vertical Canvas for OBS Studio

Plugin for [OBS Studio](https://github.com/obsproject/obs-studio) to add vertical canvas by [Restream](http://restream.io/)

# Support

For support, please visit our [Help Center](https://support.restream.io/)

# Build
- In-tree build
    - Build OBS Studio: https://obsproject.com/wiki/Install-Instructions
    - Check out this repository to UI/frontend-plugins/vertical-canvas
    - Add `add_subdirectory(vertical-canvas)` to UI/frontend-plugins/CMakeLists.txt
    - Rebuild OBS Studio
- Stand-alone build
    - Verify that you have development files for OBS
    - Check out this repository and run `cmake -S . -B build -DBUILD_OUT_OF_TREE=On && cmake --build build`

