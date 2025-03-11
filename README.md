

This is a ford of geographiclib wiht one change: CMakeLists.txt is changed to build a STATIC library instead of shared. 
See line 84 of CMakeLists.txt

was

```cmake
option (BUILD_SHARED_LIBS "Build as a shared library" ON)
```

changed to 

```cmake
option (BUILD_STATIC_LIBS "Build as a shared library" ON)
```

This is downloaded with a CMakeLists.txt for an example GeoLibrary project:

```cmake
cmake_minimum_required (VERSION 3.17.0)
project (geodesictest)

set (GeographicLib_USE_STATIC_LIBS ON) 

include(FetchContent)
FetchContent_Declare(GeographicLib
  GIT_REPOSITORY https://github.com/Flinterpop/geographiclib
  GIT_TAG        main
)

FetchContent_MakeAvailable(GeographicLib)

if (NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  # Set a default build type for single-configuration cmake generators
  # if no build type is set.
  set (CMAKE_BUILD_TYPE "Release")
endif ()

set (GeographicLib_USE_STATIC_LIBS ON) 

add_executable (${PROJECT_NAME} example-Geodesic-small.cpp)
target_link_libraries (${PROJECT_NAME} GeographicLib::GeographicLib)
```

### Example Project
```c++
// Small example of using the GeographicLib::Geodesic class

#include <iostream>
#include <GeographicLib/Geodesic.hpp>

using namespace std;
using namespace GeographicLib;

int main() {
    const Geodesic& geod = Geodesic::WGS84();
    // Distance from JFK to LHR
    double
        lat1 = 40.6, lon1 = -73.8, // JFK Airport
        lat2 = 51.6, lon2 = -0.5;  // LHR Airport
    double s12;
    geod.Inverse(lat1, lon1, lat2, lon2, s12);
    cout << s12 / 1000 << " km\n";
}

```




# GeographicLib

GeographicLib is a small C++ library for

* geodesic and rhumb line calculations;
* conversions between geographic, UTM, UPS, MGRS, geocentric, and local
  cartesian coordinates;
* gravity (e.g., EGM2008) and geomagnetic field (e.g., WMM2020)
  calculations.

It is licensed under the MIT License; see
[LICENSE.txt](https://geographiclib.sourceforge.io/LICENSE.txt).

## Links:

* Library documentation (latest release):
  https://geographiclib.sourceforge.io/C++/doc
* Library documentation (all versions):
  https://geographiclib.sourceforge.io/C++
* Change log: https://geographiclib.sourceforge.io/C++/doc/changes.html
* Git repository: https://github.com/geographiclib/geographiclib
  * Releases are on the [`release`](../../tree/release) branch, and specific
    releases are tagged as, e.g., [`r1.52`](../../tree/r1.52),
    [`r2.0`](../../tree/r2.0), etc.  This is the appropriate branch
    for most *users* of GeographicLib.
  * The main branch is [`main`](../..) and most development is done on
    the [`devel`](../../tree/devel) branch.  These branches are for the
    *developers* of GeographicLib.  Tags [`v1.52`](../../tree/v1.52),
    [`v2.0`](../../tree/v2.0), etc., are aligned with the
    corresponding release tags `r1.52`, `r2.0`, etc.
* Source distribution:
  https://sourceforge.net/projects/geographiclib/files/distrib-C++
* GeographicLib: https://geographiclib.sourceforge.io
* GeographicLib in various languages:
  https://geographiclib.sourceforge.io/doc/library.html#languages
* Author: Charles Karney, <karney@alum.mit.edu>
